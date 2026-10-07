import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';
import 'package:prep_study_lab/core/theme/app_theme.dart';
import 'package:prep_study_lab/models/models.dart';
import 'package:prep_study_lab/services/auth_service.dart';
import 'package:prep_study_lab/services/test_service.dart';
import 'package:prep_study_lab/services/pwa_service.dart';
import 'package:prep_study_lab/widgets/floating_dock_navigation.dart';
import 'package:prep_study_lab/screens/hero_view.dart';
import 'package:prep_study_lab/screens/tests_view.dart';
import 'package:prep_study_lab/screens/courses_view.dart';
import 'package:prep_study_lab/screens/progress_view.dart';
import 'package:prep_study_lab/screens/mock_config_modal.dart';
import 'package:prep_study_lab/screens/mock_test_view.dart';
import 'package:prep_study_lab/screens/test_result_view.dart';
import 'package:prep_study_lab/screens/auth_modal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase with the EXISTING production Supabase database
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => TestService()),
        ChangeNotifierProvider(create: (_) => PwaService()),
      ],
      child: const PrepStudyLabApp(),
    ),
  );
}

class PrepStudyLabApp extends StatelessWidget {
  const PrepStudyLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainShellScreen(),
    );
  }
}

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _activeTabIndex = 0; // 0: Home, 1: Tests, 2: Courses, 3: Progress
  ActiveTestSessionModel? _activeSession;
  MockAttemptModel? _viewingResultAttempt;
  bool _isStartingTest = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initAppServices();
    });
  }

  Future<void> _initAppServices() async {
    final auth = context.read<AuthService>();
    final test = context.read<TestService>();
    await auth.initialize();
    await test.initialize(auth.currentUser?.id);
  }

  void _showAuthModal({String? reasonMessage, VoidCallback? onAuthenticatedAction}) {
    showDialog(
      context: context,
      builder: (ctx) => AuthModal(
        reasonMessage: reasonMessage,
        authService: context.read<AuthService>(),
        onAuthenticated: (user) {
          context.read<TestService>().initialize(user.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Welcome, ${user.name}'),
              backgroundColor: AppColors.primary,
            ),
          );
          if (onAuthenticatedAction != null) {
            onAuthenticatedAction();
          }
        },
      ),
    );
  }

  void _openConfigModal({String? preselectedCourseId}) {
    final auth = context.read<AuthService>();
    if (!auth.isAuthenticated) {
      _showAuthModal(
        reasonMessage: 'Authentication is required before starting any test.',
        onAuthenticatedAction: () => _openConfigModal(preselectedCourseId: preselectedCourseId),
      );
      return;
    }

    final testService = context.read<TestService>();
    showDialog(
      context: context,
      builder: (ctx) => MockConfigModal(
        courses: testService.courses,
        preselectedCourseId: preselectedCourseId,
        testService: testService,
        onStartTest: (config) => _startTest(config),
      ),
    );
  }

  Future<void> _startTest(MockConfigModel config) async {
    setState(() {
      _isStartingTest = true;
    });

    final auth = context.read<AuthService>();
    final testService = context.read<TestService>();

    try {
      final session = await testService.createTestSession(config, auth.currentUser?.id);
      setState(() {
        _viewingResultAttempt = null;
        _activeSession = session;
        _activeTabIndex = 1; // Tests tab
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error starting test: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isStartingTest = false;
        });
      }
    }
  }

  void _retryWrong(MockAttemptModel attempt) {
    final auth = context.read<AuthService>();
    final testService = context.read<TestService>();
    final session = testService.createRetryWrongSession(attempt, auth.currentUser?.id);

    if (session == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No incorrect questions to re-attempt in this test.')),
      );
      return;
    }

    setState(() {
      _viewingResultAttempt = null;
      _activeSession = session;
      _activeTabIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final testService = context.watch<TestService>();
    final pwa = context.watch<PwaService>();

    if (auth.isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.primaryLight, AppColors.primary]),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 20),
                  ],
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 18),
              const Text(
                'PREP STUDY LAB',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2.5, color: AppColors.primary),
              ),
              const SizedBox(height: 6),
              const Text(
                'RESTORING VERIFIED SESSION...',
                style: TextStyle(fontSize: 11, color: AppColors.textMuted, letterSpacing: 1.0),
              ),
            ],
          ),
        ),
      );
    }

    if (_isStartingTest) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: AppColors.primary),
              const SizedBox(height: 20),
              const Text(
                'PREPARING TEST INTERFACE...',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: AppColors.primary),
              ),
            ],
          ),
        ),
      );
    }

    // Active test simulation running
    if (_activeSession != null) {
      return MockTestView(
        session: _activeSession!,
        currentUser: auth.currentUser,
        testService: testService,
        onFinishTest: (attempt) {
          setState(() {
            _activeSession = null;
            _viewingResultAttempt = attempt;
          });
        },
        onExitTest: () {
          setState(() {
            _activeSession = null;
          });
        },
      );
    }

    // Viewing results
    if (_viewingResultAttempt != null) {
      return TestResultView(
        attempt: _viewingResultAttempt!,
        onRetryWrong: (att) => _retryWrong(att),
        onBackToDashboard: () {
          setState(() {
            _viewingResultAttempt = null;
          });
        },
      );
    }

    // Normal application shell
    return Scaffold(
      body: Stack(
        children: [
          // Main Body Tabs
          IndexedStack(
            index: _activeTabIndex,
            children: [
              HeroView(
                onStartPracticing: () => _openConfigModal(),
                onViewTests: () => setState(() => _activeTabIndex = 1),
                totalCourses: testService.courses.length,
                totalQuestions: testService.questions.length,
                canInstallApp: pwa.canInstall,
                onInstallApp: () => pwa.markInstalled(),
                onDownloadApk: () => pwa.downloadApk(),
              ),
              TestsView(
                currentUser: auth.currentUser,
                attempts: testService.attempts,
                activeSession: testService.activeSession,
                progress: testService.calculateProgress(),
                onOpenConfig: () => _openConfigModal(),
                onOpenAuth: () => _showAuthModal(reasonMessage: 'Sign in with your Registration Number to view tests.'),
                onResumeTest: (session) {
                  setState(() {
                    _activeSession = session;
                  });
                },
                onViewAttemptResult: (att) {
                  setState(() {
                    _viewingResultAttempt = att;
                  });
                },
                onRetryAttemptWrong: (att) => _retryWrong(att),
              ),
              CoursesView(
                courses: testService.courses,
                testService: testService,
                onStartCourseTest: (courseId) => _openConfigModal(preselectedCourseId: courseId),
              ),
              ProgressView(
                currentUser: auth.currentUser,
                progress: testService.calculateProgress(),
                onStartPracticing: () => _openConfigModal(),
                onOpenAuth: () => _showAuthModal(reasonMessage: 'Sign in with your Registration Number to view progress analytics.'),
              ),
            ],
          ),

          // Floating Glass Navigation Dock at Top
          FloatingDockNavigation(
            activeIndex: _activeTabIndex,
            currentUser: auth.currentUser,
            onTabSelected: (idx) {
              if ((idx == 1 || idx == 3) && !auth.isAuthenticated) {
                _showAuthModal(
                  reasonMessage: 'Sign in with your Registration Number to access your tests and analytics.',
                  onAuthenticatedAction: () => setState(() => _activeTabIndex = idx),
                );
                return;
              }
              setState(() => _activeTabIndex = idx);
            },
            onOpenAuth: () => _showAuthModal(reasonMessage: 'Sign in with your Registration Number to continue.'),
            onLogout: () async {
              await auth.logout();
              setState(() {
                _activeTabIndex = 0;
              });
            },
            onNameClick: () {
              if (auth.isAuthenticated) {
                setState(() => _activeTabIndex = 3);
              }
            },
          ),
        ],
      ),
    );
  }
}
