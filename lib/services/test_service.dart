import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';
import 'package:prep_study_lab/models/models.dart';

class ActiveTestSessionModel {
  final String attemptId;
  final MockConfigModel config;
  final List<AttemptQuestionItemModel> items;
  int currentIndex;
  int? secondsRemaining;
  int secondsElapsed;
  bool isCompleted;
  final String startedAt;

  ActiveTestSessionModel({
    required this.attemptId,
    required this.config,
    required this.items,
    this.currentIndex = 0,
    this.secondsRemaining,
    this.secondsElapsed = 0,
    this.isCompleted = false,
    required this.startedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'attemptId': attemptId,
      'config': config.toJson(),
      'items': items.map((i) => i.toJson()).toList(),
      'currentIndex': currentIndex,
      'secondsRemaining': secondsRemaining,
      'secondsElapsed': secondsElapsed,
      'isCompleted': isCompleted,
      'startedAt': startedAt,
    };
  }

  factory ActiveTestSessionModel.fromJson(Map<String, dynamic> json) {
    return ActiveTestSessionModel(
      attemptId: json['attemptId']?.toString() ?? '',
      config: MockConfigModel.fromJson(Map<String, dynamic>.from(json['config'] ?? {})),
      items: (json['items'] as List? ?? [])
          .map((i) => AttemptQuestionItemModel.fromJson(Map<String, dynamic>.from(i)))
          .toList(),
      currentIndex: int.tryParse(json['currentIndex']?.toString() ?? '0') ?? 0,
      secondsRemaining: json['secondsRemaining'] != null ? int.tryParse(json['secondsRemaining'].toString()) : null,
      secondsElapsed: int.tryParse(json['secondsElapsed']?.toString() ?? '0') ?? 0,
      isCompleted: json['isCompleted'] == true,
      startedAt: json['startedAt']?.toString() ?? DateTime.now().toIso8601String(),
    );
  }
}

class TestService extends ChangeNotifier {
  List<CourseModel> _courses = [];
  List<QuestionModel> _questions = [];
  List<MockAttemptModel> _attempts = [];
  ActiveTestSessionModel? _activeSession;
  bool _isLoading = false;

  List<CourseModel> get courses => _courses;
  List<QuestionModel> get questions => _questions;
  List<MockAttemptModel> get attempts => _attempts;
  ActiveTestSessionModel? get activeSession => _activeSession;
  bool get isLoading => _isLoading;

  SupabaseClient get _supabase => Supabase.instance.client;

  Future<void> initialize(String? userId) async {
    _isLoading = true;
    notifyListeners();

    await loadCourses();
    await loadQuestions();
    if (userId != null) {
      await loadAttempts(userId);
      await loadActiveSession(userId);
    }

    _isLoading = false;
    notifyListeners();
  }

  // Fetch published courses directly from Supabase
  Future<List<CourseModel>> loadCourses({bool publishedOnly = true}) async {
    try {
      var query = _supabase.from('courses').select();
      if (publishedOnly) {
        query = query.eq('status', 'published');
      }
      final response = await query.order('created_at', ascending: true);
      final List data = response as List;

      _courses = data.map((row) => CourseModel.fromJson(Map<String, dynamic>.from(row))).toList();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          AppConstants.keyCachedCourses, jsonEncode(_courses.map((c) => c.toJson()).toList()));
      notifyListeners();
      return _courses;
    } catch (e) {
      debugPrint('Error loading courses from Supabase: $e');
      // Load cached fallback
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(AppConstants.keyCachedCourses);
      if (raw != null) {
        final List list = jsonDecode(raw);
        _courses = list.map((c) => CourseModel.fromJson(Map<String, dynamic>.from(c))).toList();
        notifyListeners();
      }
      return _courses;
    }
  }

  // Fetch questions directly from Supabase
  Future<List<QuestionModel>> loadQuestions({
    String? courseId,
    List<int>? weeks,
    bool approvedOnly = true,
  }) async {
    try {
      var query = _supabase.from('questions').select().gte('week_number', 1);
      if (courseId != null) {
        query = query.eq('course_id', courseId);
      }
      if (weeks != null && weeks.isNotEmpty) {
        query = query.inFilter('week_number', weeks);
      }
      final response = await query.order('week_number', ascending: true);
      final List data = response as List;

      var mapped = data.map((row) => QuestionModel.fromJson(Map<String, dynamic>.from(row))).toList();
      if (approvedOnly) {
        mapped = mapped.where((q) => q.isApproved && q.correctAnswerIndex != null).toList();
      }

      if (courseId == null && (weeks == null || weeks.isEmpty)) {
        _questions = mapped;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            AppConstants.keyCachedQuestions, jsonEncode(_questions.map((q) => q.toJson()).toList()));
      }
      notifyListeners();
      return mapped;
    } catch (e) {
      debugPrint('Error fetching questions from Supabase: $e');
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(AppConstants.keyCachedQuestions);
      if (raw != null) {
        final List list = jsonDecode(raw);
        _questions = list.map((q) => QuestionModel.fromJson(Map<String, dynamic>.from(q))).toList();
        notifyListeners();
      }
      return _questions;
    }
  }

  // Load student attempts from Supabase
  Future<List<MockAttemptModel>> loadAttempts(String userId) async {
    try {
      final isUuid = RegExp(
              r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
              caseSensitive: false)
          .hasMatch(userId);

      var query = _supabase.from('mock_attempts').select('*, attempt_items(*)');
      if (isUuid) {
        query = query.eq('user_id', userId);
      } else {
        query = query.or('student_name.eq.$userId,reg_number.eq.$userId');
      }

      final response = await query.order('completed_at', ascending: false);
      final List data = response as List;

      _attempts = data.map((row) => MockAttemptModel.fromJson(Map<String, dynamic>.from(row))).toList();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          '${AppConstants.keyCachedAttempts}_$userId',
          jsonEncode(_attempts.map((a) => a.toJson()).toList()));
      notifyListeners();
      return _attempts;
    } catch (e) {
      debugPrint('Error loading attempts: $e');
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('${AppConstants.keyCachedAttempts}_$userId');
      if (raw != null) {
        final List list = jsonDecode(raw);
        _attempts = list.map((a) => MockAttemptModel.fromJson(Map<String, dynamic>.from(a))).toList();
        notifyListeners();
      }
      return _attempts;
    }
  }

  // Active session persistence
  Future<void> saveActiveSession(ActiveTestSessionModel? session, String? userId) async {
    _activeSession = session;
    if (userId == null) return;
    final prefs = await SharedPreferences.getInstance();
    final key = '${AppConstants.keyActiveTest}_$userId';
    if (session == null || session.isCompleted) {
      await prefs.remove(key);
    } else {
      await prefs.setString(key, jsonEncode(session.toJson()));
    }
    notifyListeners();
  }

  Future<void> loadActiveSession(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${AppConstants.keyActiveTest}_$userId';
    final raw = prefs.getString(key);
    if (raw != null) {
      try {
        final map = jsonDecode(raw);
        final session = ActiveTestSessionModel.fromJson(map);
        if (!session.isCompleted) {
          _activeSession = session;
          notifyListeners();
        }
      } catch (_) {}
    }
  }

  // Build new test session with Fisher-Yates shuffle
  Future<ActiveTestSessionModel> createTestSession(
      MockConfigModel config, String? userId) async {
    // 1. Fetch relevant questions from Supabase
    List<QuestionModel> pool = await loadQuestions(
      courseId: config.courseId,
      weeks: config.selectedWeeks.isNotEmpty ? config.selectedWeeks : null,
      approvedOnly: true,
    );

    if (pool.isEmpty) {
      pool = _questions.where((q) => q.courseId == config.courseId).toList();
    }

    // 2. Filter pool based on selectionType
    if (config.selectionType == 'unattempted' || config.selectionType == 'wrong') {
      final attemptedIds = <String>{};
      final wrongIds = <String>{};
      for (final att in _attempts.where((a) => a.courseId == config.courseId)) {
        for (final item in att.items) {
          attemptedIds.add(item.questionId);
          if (item.selectedOptionIndex != null && item.selectedOptionIndex != item.correctOptionIndex) {
            wrongIds.add(item.questionId);
          }
        }
      }

      if (config.selectionType == 'unattempted') {
        final filtered = pool.where((q) => !attemptedIds.contains(q.id)).toList();
        if (filtered.isNotEmpty) pool = filtered;
      } else if (config.selectionType == 'wrong') {
        final filtered = pool.where((q) => wrongIds.contains(q.id)).toList();
        if (filtered.isNotEmpty) pool = filtered;
      }
    }

    // 3. Shuffle question pool
    final random = Random();
    pool = List.of(pool)..shuffle(random);

    int count = pool.length;
    if (config.questionCount is int) {
      count = min(config.questionCount as int, pool.length);
    }
    final selectedQuestions = pool.take(count).toList();

    // 4. For each question, shuffle options and track mapped correct answer
    final List<AttemptQuestionItemModel> items = [];
    for (int i = 0; i < selectedQuestions.length; i++) {
      final q = selectedQuestions[i];
      final rawOptions = List<String>.from(q.options);
      while (rawOptions.length < 4) {
        rawOptions.add('Option ${String.fromCharCode(65 + rawOptions.length)}');
      }

      final correctIdx = max(0, min(q.correctAnswerIndex ?? 0, rawOptions.length - 1));

      // Build indexed pairs
      final indexedPairs = List.generate(4, (optIdx) {
        return {
          'text': rawOptions[optIdx],
          'isCorrect': optIdx == correctIdx,
        };
      });

      indexedPairs.shuffle(random);

      final displayedOptions = indexedPairs.map((p) => p['text'] as String).toList();
      final newCorrectIndex = indexedPairs.indexWhere((p) => p['isCorrect'] == true);

      items.add(AttemptQuestionItemModel(
        questionId: q.id,
        questionIndex: i,
        questionText: q.questionText,
        displayedOptions: displayedOptions,
        selectedOptionIndex: null,
        correctOptionIndex: newCorrectIndex >= 0 ? newCorrectIndex : 0,
        isMarkedForReview: false,
        timeSpentSeconds: 0,
        explanation: q.explanation,
      ));
    }

    final int? timeLimitSeconds =
        config.timeLimitMinutes > 0 ? config.timeLimitMinutes * 60 : null;

    final session = ActiveTestSessionModel(
      attemptId: 'att_${DateTime.now().millisecondsSinceEpoch}_${random.nextInt(999999)}',
      config: config,
      items: items,
      currentIndex: 0,
      secondsRemaining: timeLimitSeconds,
      secondsElapsed: 0,
      isCompleted: false,
      startedAt: DateTime.now().toIso8601String(),
    );

    await saveActiveSession(session, userId);
    return session;
  }

  // Create retry wrong session
  ActiveTestSessionModel? createRetryWrongSession(
      MockAttemptModel attempt, String? userId) {
    final wrongItems = attempt.items.where((it) =>
        it.selectedOptionIndex != null && it.selectedOptionIndex != it.correctOptionIndex).toList();

    if (wrongItems.isEmpty) return null;

    final random = Random();
    final List<AttemptQuestionItemModel> newItems = [];

    for (int i = 0; i < wrongItems.length; i++) {
      final old = wrongItems[i];
      final pairs = List.generate(old.displayedOptions.length, (optIdx) {
        return {
          'text': old.displayedOptions[optIdx],
          'isCorrect': optIdx == old.correctOptionIndex,
        };
      });
      pairs.shuffle(random);

      final displayed = pairs.map((p) => p['text'] as String).toList();
      final newCorrect = pairs.indexWhere((p) => p['isCorrect'] == true);

      newItems.add(AttemptQuestionItemModel(
        questionId: old.questionId,
        questionIndex: i,
        questionText: old.questionText,
        displayedOptions: displayed,
        selectedOptionIndex: null,
        correctOptionIndex: newCorrect >= 0 ? newCorrect : 0,
        isMarkedForReview: false,
        timeSpentSeconds: 0,
        explanation: old.explanation,
      ));
    }

    final retryConfig = MockConfigModel(
      courseId: attempt.courseId,
      courseName: '${attempt.courseName} (Retry Incorrect)',
      selectedWeeks: attempt.selectedWeeks ?? [],
      questionCount: newItems.length,
      selectionType: 'wrong',
      mode: 'practice',
      timeLimitMinutes: 0,
    );

    final session = ActiveTestSessionModel(
      attemptId: 'att_retry_${DateTime.now().millisecondsSinceEpoch}',
      config: retryConfig,
      items: newItems,
      currentIndex: 0,
      secondsRemaining: null,
      secondsElapsed: 0,
      isCompleted: false,
      startedAt: DateTime.now().toIso8601String(),
    );

    saveActiveSession(session, userId);
    return session;
  }

  // Finalize and save attempt to Supabase
  Future<Map<String, dynamic>> submitAttempt(
      ActiveTestSessionModel session, UserModel? user) async {
    final totalQuestions = session.items.length;
    int correctCount = 0;
    int wrongCount = 0;
    int unansweredCount = 0;

    for (final item in session.items) {
      if (item.selectedOptionIndex == null) {
        unansweredCount++;
      } else if (item.selectedOptionIndex == item.correctOptionIndex) {
        correctCount++;
      } else {
        wrongCount++;
      }
    }

    final double percentage = totalQuestions > 0
        ? ((correctCount / totalQuestions) * 100).roundToDouble()
        : 0.0;
    final completedAt = DateTime.now().toIso8601String();

    String? authUserId;
    if (user != null &&
        RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
                caseSensitive: false)
            .hasMatch(user.id)) {
      authUserId = user.id;
    }

    final studentName = user?.name ?? 'Student';

    final attempt = MockAttemptModel(
      id: session.attemptId,
      userId: authUserId,
      studentName: studentName,
      regNumber: studentName,
      courseId: session.config.courseId,
      courseName: session.config.courseName,
      mode: session.config.mode,
      totalQuestions: totalQuestions,
      score: correctCount,
      percentage: percentage,
      correctCount: correctCount,
      wrongCount: wrongCount,
      unansweredCount: unansweredCount,
      timeTakenSeconds: session.secondsElapsed,
      timeLimitSeconds: session.config.timeLimitMinutes > 0
          ? session.config.timeLimitMinutes * 60
          : null,
      selectedWeeks: session.config.selectedWeeks,
      startedAt: session.startedAt,
      submittedAt: completedAt,
      createdAt: session.startedAt,
      completedAt: completedAt,
      items: session.items,
    );

    // Write to Supabase mock_attempts
    try {
      await _supabase.from('mock_attempts').insert({
        'id': attempt.id,
        'user_id': authUserId,
        'course_id': attempt.courseId,
        'course_name': attempt.courseName,
        'mode': attempt.mode,
        'total_questions': attempt.totalQuestions,
        'score': attempt.score,
        'percentage': attempt.percentage,
        'correct_count': attempt.correctCount,
        'wrong_count': attempt.wrongCount,
        'unanswered_count': attempt.unansweredCount,
        'time_taken_seconds': attempt.timeTakenSeconds,
        'time_limit_seconds': attempt.timeLimitSeconds,
        'is_completed': true,
        'student_name': studentName,
        'reg_number': studentName,
        'selected_weeks': session.config.selectedWeeks,
        'started_at': session.startedAt,
        'submitted_at': completedAt,
        'completed_at': completedAt,
        'created_at': session.startedAt,
      });

      // Write attempt_items
      final itemRows = attempt.items.map((it) {
        return {
          'attempt_id': attempt.id,
          'question_id': it.questionId,
          'question_index': it.questionIndex,
          'question_text': it.questionText,
          'displayed_options': it.displayedOptions,
          'selected_option_index': it.selectedOptionIndex,
          'correct_option_index': it.correctOptionIndex,
          'is_correct': it.isCorrect,
          'is_marked_for_review': it.isMarkedForReview,
          'time_spent_seconds': it.timeSpentSeconds,
        };
      }).toList();

      await _supabase.from('attempt_items').insert(itemRows);
    } catch (e) {
      debugPrint('Notice saving attempt to Supabase: $e');
    }

    _attempts.insert(0, attempt);
    await saveActiveSession(null, user?.id);
    notifyListeners();

    return {'success': true, 'attempt': attempt};
  }

  // Calculate User Progress Model
  UserProgressModel calculateProgress() {
    if (_attempts.isEmpty) return UserProgressModel();

    int totalAttempted = 0;
    int totalCorrect = 0;
    int bestScore = 0;
    int examCompleted = 0;
    int practiceCompleted = 0;

    final Map<String, Map<String, dynamic>> weekMap = {};

    for (final att in _attempts) {
      if (att.mode == 'exam') {
        examCompleted++;
      } else {
        practiceCompleted++;
      }

      totalAttempted += att.totalQuestions;
      totalCorrect += att.correctCount;
      if (att.score > bestScore) {
        bestScore = att.score;
      }

      final weeks = att.selectedWeeks ?? [1];
      for (final w in weeks) {
        final key = '${att.courseId}_$w';
        if (!weekMap.containsKey(key)) {
          weekMap[key] = {
            'courseId': att.courseId,
            'courseName': att.courseName,
            'week': w,
            'attempted': 0,
            'correct': 0,
          };
        }
        weekMap[key]!['attempted'] += (att.totalQuestions / max(1, weeks.length)).round();
        weekMap[key]!['correct'] += (att.correctCount / max(1, weeks.length)).round();
      }
    }

    final double accuracy = totalAttempted > 0
        ? ((totalCorrect / totalAttempted) * 100).roundToDouble()
        : 0.0;

    final List<WeekProgressModel> weekWise = weekMap.values.map((v) {
      final int attCount = v['attempted'] as int;
      final int corrCount = v['correct'] as int;
      final double acc = attCount > 0 ? ((corrCount / attCount) * 100).roundToDouble() : 0.0;
      return WeekProgressModel(
        courseId: v['courseId'] as String,
        courseName: v['courseName'] as String,
        week: v['week'] as int,
        attempted: attCount,
        correct: corrCount,
        accuracy: acc,
      );
    }).toList();

    weekWise.sort((a, b) => a.week.compareTo(b.week));

    return UserProgressModel(
      totalAttempted: totalAttempted,
      totalCorrect: totalCorrect,
      accuracy: accuracy,
      bestScore: bestScore,
      testsCompleted: _attempts.length,
      practiceCompleted: practiceCompleted,
      examCompleted: examCompleted,
      weekWise: weekWise,
    );
  }
}
