import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';
import 'package:prep_study_lab/services/auth_service.dart';
import 'package:prep_study_lab/services/test_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = null;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
    );
  });

  group('User Specification Tests', () {
    test('TEST 2 & TEST 4: Login with 2026AIML001 and Test@123', () async {
      final auth = AuthService();
      await auth.initialize();

      final loginRes = await auth.login('2026AIML001', 'Test@123');
      expect(loginRes['success'], true, reason: 'Login should succeed for 2026AIML001');
      expect(auth.currentUser != null, true);
      expect(auth.currentUser!.name, contains('2026AIML001'));
      expect(auth.currentUser!.role, 'student');

      // Verify TestService loads courses and questions for this user
      final testService = TestService();
      await testService.initialize(auth.currentUser!.id);
      expect(testService.courses.isNotEmpty, true, reason: 'Courses should load from Supabase');
      expect(testService.questions.isNotEmpty, true, reason: 'Questions should load from Supabase');
      expect(testService.questions.length, greaterThanOrEqualTo(100));

      await auth.logout();
      expect(auth.currentUser, isNull);
    });

    test('TEST 3: Login with SANIA123 and Test@123', () async {
      final auth = AuthService();
      await auth.initialize();

      final loginRes = await auth.login('SANIA123', 'Test@123');
      expect(loginRes['success'], true, reason: 'Login should succeed for SANIA123');
      expect(auth.currentUser != null, true);
      expect(auth.currentUser!.role, 'student');

      await auth.logout();
    });

    test('TEST 5: Duplicate registration returns expected message', () async {
      final auth = AuthService();
      await auth.initialize();

      // Attempting to register SANIA123 again should report duplicate account
      final dupRes = await auth.register('SANIA123', 'Test@123', 'Test@123');
      expect(dupRes['success'], false);
      expect(dupRes['error'], 'Account already exists. Please sign in.');
    });

    test('TEST 6: Session persistence and restoration', () async {
      final auth1 = AuthService();
      await auth1.initialize();
      final loginRes = await auth1.login('2026AIML001', 'Test@123');
      expect(loginRes['success'], true);

      // Simulate closing and reopening app by initializing a fresh AuthService instance
      final auth2 = AuthService();
      await auth2.initialize();
      expect(auth2.isAuthenticated, true);
      expect(auth2.currentUser?.id, auth1.currentUser?.id);

      await auth2.logout();
    });

    test('TEST 7: Verify ADMIN credentials still log in', () async {
      final auth = AuthService();
      await auth.initialize();

      final res = await auth.login('ADMIN', 'admin123');
      expect(res['success'], true);
      expect(auth.currentUser?.role, 'admin');

      await auth.logout();
    });
  });
}
