import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  // Initialize Supabase with the production Supabase database
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
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.stylus,
        },
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      ),
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
  bool _isAuthModalOpen = false;

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
    test.initialize(auth.currentUser?.id);
  }

  void _showAuthModal({String? reasonMessage, VoidCallback? onAuthenticatedAction}) {
    if (_isAuthModalOpen) return;
    _isAuthModalOpen = true;

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.54),
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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onAuthenticatedAction();
            });
          }
        },
      ),
    ).whenComplete(() {
      _isAuthModalOpen = false;
    });
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
        _activeTabIndex = 2; // Tests tab
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
      _activeTabIndex = 2; // Tests tab
    });
  }

  Future<void> _handleLogout() async {
    final auth = context.read<AuthService>();
    final testService = context.read<TestService>();
    await auth.logout();
    testService.clearUserData();
    if (!mounted) return;
    setState(() {
      _activeTabIndex = 0;
      _activeSession = null;
      _viewingResultAttempt = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully signed out.'),
        backgroundColor: AppColors.primary,
        duration: Duration(seconds: 2),
      ),
    );
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

    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 768;

    void handleTabSelect(int idx) {
      if ((idx == 2 || idx == 3) && !auth.isAuthenticated) {
        _showAuthModal(
          reasonMessage: 'Sign in with your Registration Number to access your tests and analytics.',
          onAuthenticatedAction: () => setState(() => _activeTabIndex = idx),
        );
        return;
      }
      setState(() => _activeTabIndex = idx);
    }

    final tabViews = [
      HeroView(
        onStartPracticing: () => _openConfigModal(),
        onViewTests: () => setState(() => _activeTabIndex = 2),
        totalCourses: testService.courses.length,
        totalQuestions: testService.questions.length,
        canInstallApp: pwa.canInstall,
        onInstallApp: () => pwa.markInstalled(),
        onDownloadApk: () => pwa.downloadApk(),
      ),
      CoursesView(
        courses: testService.courses,
        testService: testService,
        onStartCourseTest: (courseId) => _openConfigModal(preselectedCourseId: courseId),
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
        onLogout: _handleLogout,
      ),
      ProgressView(
        currentUser: auth.currentUser,
        progress: testService.calculateProgress(),
        onStartPracticing: () => _openConfigModal(),
        onOpenAuth: () => _showAuthModal(reasonMessage: 'Sign in with your Registration Number to view progress analytics.'),
      ),
    ];

    if (!isDesktop) {
      // Mobile Shell with Top AppBar and Bottom NavigationBar
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 52,
          titleSpacing: 12,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.school_outlined, size: 20, color: AppColors.primary),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Prep Study Lab',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (testService.isOffline) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.warningSoft,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.wifi_off, size: 10, color: AppColors.warning),
                      SizedBox(width: 3),
                      Text('OFFLINE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.warning)),
                    ],
                  ),
                ),
              ],
            ],
          ),
          actions: [
            if (auth.currentUser != null)
              PopupMenuButton<String>(
                tooltip: 'Account',
                offset: const Offset(0, 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.person_outline, size: 16, color: AppColors.primary),
                      const SizedBox(width: 4),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 80),
                        child: Text(
                          auth.currentUser!.name,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'progress',
                    child: Row(
                      children: const [
                        Icon(Icons.bar_chart, size: 18, color: AppColors.primary),
                        SizedBox(width: 8),
                        Text('My Analytics'),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: const [
                        Icon(Icons.logout, size: 18, color: AppColors.error),
                        SizedBox(width: 8),
                        Text('Sign Out', style: TextStyle(color: AppColors.error)),
                      ],
                    ),
                  ),
                ],
                onSelected: (val) async {
                  if (val == 'progress') {
                    setState(() => _activeTabIndex = 3);
                  } else if (val == 'logout') {
                    await _handleLogout();
                  }
                },
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: FilledButton.icon(
                  onPressed: () => _showAuthModal(reasonMessage: 'Sign in with your Registration Number to continue.'),
                  icon: const Icon(Icons.login, size: 14),
                  label: const Text('Sign In', style: TextStyle(fontSize: 11)),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
          ],
        ),
        body: IndexedStack(
          index: _activeTabIndex,
          children: tabViews,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _activeTabIndex,
          onDestinationSelected: handleTabSelect,
          backgroundColor: Colors.white,
          elevation: 8,
          indicatorColor: AppColors.primarySoft,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: AppColors.primary),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book, color: AppColors.primary),
              label: 'Courses',
            ),
            NavigationDestination(
              icon: Icon(Icons.description_outlined),
              selectedIcon: Icon(Icons.description, color: AppColors.primary),
              label: 'Tests',
            ),
            NavigationDestination(
              icon: Icon(Icons.bar_chart_outlined),
              selectedIcon: Icon(Icons.bar_chart, color: AppColors.primary),
              label: 'Progress',
            ),
          ],
        ),
      );
    }

    // Desktop/Tablet Shell with floating dock navigation
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _activeTabIndex,
            children: tabViews,
          ),
          FloatingDockNavigation(
            activeIndex: _activeTabIndex,
            currentUser: auth.currentUser,
            onTabSelected: handleTabSelect,
            onOpenAuth: () => _showAuthModal(reasonMessage: 'Sign in with your Registration Number to continue.'),
            onLogout: _handleLogout,
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
