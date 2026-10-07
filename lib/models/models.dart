class UserModel {
  final String id;
  final String name;
  final String? regNumber;
  final String? email;
  final String role; // 'admin' | 'student'
  final String status; // 'active' | 'deactivated'
  final String createdAt;

  UserModel({
    required this.id,
    required this.name,
    this.regNumber,
    this.email,
    this.role = 'student',
    this.status = 'active',
    required this.createdAt,
  });

  bool get isAdmin => role == 'admin';

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? json['regNumber']?.toString() ?? 'Student',
      regNumber: json['regNumber']?.toString() ?? json['name']?.toString(),
      email: json['email']?.toString(),
      role: json['role']?.toString() ?? 'student',
      status: json['status']?.toString() ?? 'active',
      createdAt: json['createdAt']?.toString() ?? json['created_at']?.toString() ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'regNumber': regNumber,
      'email': email,
      'role': role,
      'status': status,
      'createdAt': createdAt,
    };
  }
}

class CourseModel {
  final String id;
  final String code;
  final String name;
  final String description;
  final int totalQuestions;
  final List<int> weeks;
  final String status; // 'draft' | 'review' | 'published'
  final String? createdAt;
  final String? publishedAt;

  CourseModel({
    required this.id,
    required this.code,
    required this.name,
    this.description = '',
    this.totalQuestions = 0,
    this.weeks = const [],
    this.status = 'published',
    this.createdAt,
    this.publishedAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    List<int> parsedWeeks = [];
    final rawWeeks = json['weeks'];
    if (rawWeeks is List) {
      parsedWeeks = rawWeeks.map((w) => int.tryParse(w.toString()) ?? 0).where((w) => w > 0).toList();
    } else if (rawWeeks is String) {
      // try parsing string "[1,2,3]"
      final clean = rawWeeks.replaceAll('[', '').replaceAll(']', '').trim();
      if (clean.isNotEmpty) {
        parsedWeeks = clean.split(',').map((w) => int.tryParse(w.trim()) ?? 0).where((w) => w > 0).toList();
      }
    }
    parsedWeeks.sort();

    return CourseModel(
      id: json['id']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      totalQuestions: int.tryParse(json['total_questions']?.toString() ?? json['totalQuestions']?.toString() ?? '0') ?? 0,
      weeks: parsedWeeks,
      status: json['status']?.toString() ?? 'draft',
      createdAt: json['created_at']?.toString() ?? json['createdAt']?.toString(),
      publishedAt: json['published_at']?.toString() ?? json['publishedAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'totalQuestions': totalQuestions,
      'weeks': weeks,
      'status': status,
      'createdAt': createdAt,
      'publishedAt': publishedAt,
    };
  }
}

class QuestionModel {
  final String id;
  final String courseId;
  final int weekNumber;
  final String? sourcePdfId;
  final String? sourcePdfName;
  final String questionText;
  final List<String> options;
  final int? correctAnswerIndex;
  final String answerSource;
  final bool isApproved;
  final String explanation;
  final String? createdAt;

  QuestionModel({
    required this.id,
    required this.courseId,
    required this.weekNumber,
    this.sourcePdfId,
    this.sourcePdfName,
    required this.questionText,
    required this.options,
    this.correctAnswerIndex,
    this.answerSource = 'Manually Verified',
    this.isApproved = true,
    this.explanation = '',
    this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedOptions = ['Option A', 'Option B', 'Option C', 'Option D'];
    final rawOptions = json['options'];
    if (rawOptions is List) {
      parsedOptions = rawOptions.map((o) => o?.toString() ?? '').toList();
    }
    while (parsedOptions.length < 4) {
      parsedOptions.add('Option ${String.fromCharCode(65 + parsedOptions.length)}');
    }

    final rawCorrect = json['correct_answer_index'] ?? json['correctAnswerIndex'];
    final int? correctIdx = rawCorrect != null ? int.tryParse(rawCorrect.toString()) : null;

    final rawApproved = json['is_approved'] ?? json['isApproved'];
    final bool isApproved = rawApproved != null ? (rawApproved == true || rawApproved.toString() == 'true') : (correctIdx != null);

    return QuestionModel(
      id: json['id']?.toString() ?? '',
      courseId: json['course_id']?.toString() ?? json['courseId']?.toString() ?? '',
      weekNumber: int.tryParse(json['week_number']?.toString() ?? json['weekNumber']?.toString() ?? '1') ?? 1,
      sourcePdfId: json['source_pdf_id']?.toString() ?? json['sourcePdfId']?.toString(),
      sourcePdfName: json['source_pdf_name']?.toString() ?? json['sourcePdfName']?.toString() ?? '',
      questionText: json['question_text']?.toString() ?? json['questionText']?.toString() ?? '',
      options: parsedOptions.take(4).toList(),
      correctAnswerIndex: correctIdx,
      answerSource: json['answer_source']?.toString() ?? json['answerSource']?.toString() ?? (correctIdx != null ? 'Manually Verified' : 'Not Available'),
      isApproved: isApproved,
      explanation: json['explanation']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? json['createdAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'weekNumber': weekNumber,
      'sourcePdfId': sourcePdfId,
      'sourcePdfName': sourcePdfName,
      'questionText': questionText,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'answerSource': answerSource,
      'isApproved': isApproved,
      'explanation': explanation,
      'createdAt': createdAt,
    };
  }
}

class MockConfigModel {
  final String courseId;
  final String courseName;
  final List<int> selectedWeeks;
  final dynamic questionCount; // int or 'all'
  final String selectionType; // 'random' | 'unattempted' | 'wrong' | 'all'
  final String mode; // 'practice' | 'exam'
  final int timeLimitMinutes;

  MockConfigModel({
    required this.courseId,
    required this.courseName,
    required this.selectedWeeks,
    required this.questionCount,
    this.selectionType = 'random',
    this.mode = 'practice',
    this.timeLimitMinutes = 15,
  });

  bool get isExam => mode == 'exam';

  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'courseName': courseName,
      'selectedWeeks': selectedWeeks,
      'questionCount': questionCount,
      'selectionType': selectionType,
      'mode': mode,
      'timeLimitMinutes': timeLimitMinutes,
    };
  }

  factory MockConfigModel.fromJson(Map<String, dynamic> json) {
    List<int> weeks = [];
    final rawWeeks = json['selectedWeeks'];
    if (rawWeeks is List) {
      weeks = rawWeeks.map((w) => int.tryParse(w.toString()) ?? 0).where((w) => w > 0).toList();
    }
    return MockConfigModel(
      courseId: json['courseId']?.toString() ?? '',
      courseName: json['courseName']?.toString() ?? '',
      selectedWeeks: weeks,
      questionCount: json['questionCount'] == 'all' ? 'all' : (int.tryParse(json['questionCount']?.toString() ?? '10') ?? 10),
      selectionType: json['selectionType']?.toString() ?? 'random',
      mode: json['mode']?.toString() ?? 'practice',
      timeLimitMinutes: int.tryParse(json['timeLimitMinutes']?.toString() ?? '15') ?? 15,
    );
  }
}

class AttemptQuestionItemModel {
  final String questionId;
  final int questionIndex;
  final String questionText;
  final List<String> displayedOptions;
  int? selectedOptionIndex;
  final int? correctOptionIndex;
  bool isMarkedForReview;
  int timeSpentSeconds;
  final String? explanation;

  AttemptQuestionItemModel({
    required this.questionId,
    required this.questionIndex,
    required this.questionText,
    required this.displayedOptions,
    this.selectedOptionIndex,
    this.correctOptionIndex,
    this.isMarkedForReview = false,
    this.timeSpentSeconds = 0,
    this.explanation,
  });

  bool get isCorrect =>
      selectedOptionIndex != null && selectedOptionIndex == correctOptionIndex;

  factory AttemptQuestionItemModel.fromJson(Map<String, dynamic> json) {
    List<String> options = [];
    final rawOptions = json['displayed_options'] ?? json['displayedOptions'];
    if (rawOptions is List) {
      options = rawOptions.map((o) => o?.toString() ?? '').toList();
    }
    return AttemptQuestionItemModel(
      questionId: json['question_id']?.toString() ?? json['questionId']?.toString() ?? '',
      questionIndex: int.tryParse(json['question_index']?.toString() ?? json['questionIndex']?.toString() ?? '0') ?? 0,
      questionText: json['question_text']?.toString() ?? json['questionText']?.toString() ?? '',
      displayedOptions: options,
      selectedOptionIndex: json['selected_option_index'] != null
          ? int.tryParse(json['selected_option_index'].toString())
          : (json['selectedOptionIndex'] != null ? int.tryParse(json['selectedOptionIndex'].toString()) : null),
      correctOptionIndex: json['correct_option_index'] != null
          ? int.tryParse(json['correct_option_index'].toString())
          : (json['correctOptionIndex'] != null ? int.tryParse(json['correctOptionIndex'].toString()) : null),
      isMarkedForReview: json['is_marked_for_review'] == true || json['isMarkedForReview'] == true,
      timeSpentSeconds: int.tryParse(json['time_spent_seconds']?.toString() ?? json['timeSpentSeconds']?.toString() ?? '0') ?? 0,
      explanation: json['explanation']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionIndex': questionIndex,
      'questionText': questionText,
      'displayedOptions': displayedOptions,
      'selectedOptionIndex': selectedOptionIndex,
      'correctOptionIndex': correctOptionIndex,
      'isMarkedForReview': isMarkedForReview,
      'timeSpentSeconds': timeSpentSeconds,
      'explanation': explanation,
    };
  }
}

class MockAttemptModel {
  final String id;
  final String? userId;
  final String? studentName;
  final String? regNumber;
  final String courseId;
  final String courseName;
  final String mode; // 'practice' | 'exam'
  final int totalQuestions;
  final int score;
  final double percentage;
  final int correctCount;
  final int wrongCount;
  final int unansweredCount;
  final int timeTakenSeconds;
  final int? timeLimitSeconds;
  final List<int>? selectedWeeks;
  final String? startedAt;
  final String? submittedAt;
  final String createdAt;
  final String completedAt;
  final List<AttemptQuestionItemModel> items;

  MockAttemptModel({
    required this.id,
    this.userId,
    this.studentName,
    this.regNumber,
    required this.courseId,
    required this.courseName,
    required this.mode,
    required this.totalQuestions,
    required this.score,
    required this.percentage,
    required this.correctCount,
    required this.wrongCount,
    required this.unansweredCount,
    required this.timeTakenSeconds,
    this.timeLimitSeconds,
    this.selectedWeeks,
    this.startedAt,
    this.submittedAt,
    required this.createdAt,
    required this.completedAt,
    required this.items,
  });

  factory MockAttemptModel.fromJson(Map<String, dynamic> json) {
    List<AttemptQuestionItemModel> parsedItems = [];
    final rawItems = json['items'] ?? json['attempt_items'];
    if (rawItems is List) {
      parsedItems = rawItems.map((it) => AttemptQuestionItemModel.fromJson(Map<String, dynamic>.from(it))).toList();
      parsedItems.sort((a, b) => a.questionIndex.compareTo(b.questionIndex));
    }

    List<int>? weeks;
    final rawWeeks = json['selected_weeks'] ?? json['selectedWeeks'];
    if (rawWeeks is List) {
      weeks = rawWeeks.map((w) => int.tryParse(w.toString()) ?? 0).where((w) => w > 0).toList();
    }

    return MockAttemptModel(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? json['userId']?.toString(),
      studentName: json['student_name']?.toString() ?? json['studentName']?.toString() ?? 'Student',
      regNumber: json['reg_number']?.toString() ?? json['regNumber']?.toString() ?? json['student_name']?.toString(),
      courseId: json['course_id']?.toString() ?? json['courseId']?.toString() ?? '',
      courseName: json['course_name']?.toString() ?? json['courseName']?.toString() ?? '',
      mode: json['mode']?.toString() ?? 'practice',
      totalQuestions: int.tryParse(json['total_questions']?.toString() ?? json['totalQuestions']?.toString() ?? '0') ?? 0,
      score: int.tryParse(json['score']?.toString() ?? '0') ?? 0,
      percentage: double.tryParse(json['percentage']?.toString() ?? '0') ?? 0.0,
      correctCount: int.tryParse(json['correct_count']?.toString() ?? json['correctCount']?.toString() ?? '0') ?? 0,
      wrongCount: int.tryParse(json['wrong_count']?.toString() ?? json['wrongCount']?.toString() ?? '0') ?? 0,
      unansweredCount: int.tryParse(json['unanswered_count']?.toString() ?? json['unansweredCount']?.toString() ?? '0') ?? 0,
      timeTakenSeconds: int.tryParse(json['time_taken_seconds']?.toString() ?? json['timeTakenSeconds']?.toString() ?? '0') ?? 0,
      timeLimitSeconds: json['time_limit_seconds'] != null ? int.tryParse(json['time_limit_seconds'].toString()) : null,
      selectedWeeks: weeks,
      startedAt: json['started_at']?.toString() ?? json['startedAt']?.toString(),
      submittedAt: json['submitted_at']?.toString() ?? json['submittedAt']?.toString() ?? json['completed_at']?.toString(),
      createdAt: json['created_at']?.toString() ?? json['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
      completedAt: json['completed_at']?.toString() ?? json['completedAt']?.toString() ?? DateTime.now().toIso8601String(),
      items: parsedItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'studentName': studentName,
      'regNumber': regNumber,
      'courseId': courseId,
      'courseName': courseName,
      'mode': mode,
      'totalQuestions': totalQuestions,
      'score': score,
      'percentage': percentage,
      'correctCount': correctCount,
      'wrongCount': wrongCount,
      'unansweredCount': unansweredCount,
      'timeTakenSeconds': timeTakenSeconds,
      'timeLimitSeconds': timeLimitSeconds,
      'selectedWeeks': selectedWeeks,
      'startedAt': startedAt,
      'submittedAt': submittedAt,
      'createdAt': createdAt,
      'completedAt': completedAt,
      'items': items.map((i) => i.toJson()).toList(),
    };
  }
}

class UserProgressModel {
  final int totalAttempted;
  final int totalCorrect;
  final double accuracy;
  final int bestScore;
  final int testsCompleted;
  final int practiceCompleted;
  final int examCompleted;
  final List<WeekProgressModel> weekWise;

  UserProgressModel({
    this.totalAttempted = 0,
    this.totalCorrect = 0,
    this.accuracy = 0.0,
    this.bestScore = 0,
    this.testsCompleted = 0,
    this.practiceCompleted = 0,
    this.examCompleted = 0,
    this.weekWise = const [],
  });
}

class WeekProgressModel {
  final String courseId;
  final String courseName;
  final int week;
  final int attempted;
  final int correct;
  final double accuracy;

  WeekProgressModel({
    required this.courseId,
    required this.courseName,
    required this.week,
    required this.attempted,
    required this.correct,
    required this.accuracy,
  });
}
