import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';
import 'package:prep_study_lab/services/auth_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
    );
  });

  group('AuthService identifier & deterministic email tests', () {
    test('toInternalEmail transforms various identifiers correctly', () {
      expect(AuthService.toInternalEmail('HAFI'), 'hafi@prepstudylab.com');
      expect(AuthService.toInternalEmail('SANIA'), 'sania@prepstudylab.com');
      expect(AuthService.toInternalEmail('12345'), '12345@prepstudylab.com');
      expect(AuthService.toInternalEmail('2026AIML001'), '2026aiml001@prepstudylab.com');
      expect(AuthService.toInternalEmail('HAFI123'), 'hafi123@prepstudylab.com');
      expect(AuthService.toInternalEmail('STUDENT01'), 'student01@prepstudylab.com');
      expect(AuthService.toInternalEmail('ABC123'), 'abc123@prepstudylab.com');
      expect(AuthService.toInternalEmail('  Hafi  '), 'hafi@prepstudylab.com');
      expect(AuthService.toInternalEmail('student@example.com'), 'student@example.com');
    });

    test('Validation rejects empty, short, or mismatched inputs', () async {
      final auth = AuthService();
      await auth.initialize();

      // Empty identifier
      final emptyRes = await auth.register('', 'Test@123', 'Test@123');
      expect(emptyRes['success'], false);
      expect(emptyRes['error'], contains('Please enter your Name or Registration Number'));

      // Short identifier
      final shortRes = await auth.register('a', 'Test@123', 'Test@123');
      expect(shortRes['success'], false);
      expect(shortRes['error'], contains('at least 2 characters'));

      // Short password
      final shortPass = await auth.register('HAFI', '12345', '12345');
      expect(shortPass['success'], false);
      expect(shortPass['error'], contains('at least 6 characters'));

      // Mismatched passwords
      final mismatch = await auth.register('HAFI', 'Test@123', 'Different@123');
      expect(mismatch['success'], false);
      expect(mismatch['error'], contains('Passwords do not match'));
    });

    test('Admin master credentials authenticate', () async {
      final auth = AuthService();
      await auth.initialize();

      final res = await auth.login('ADMIN', 'admin123');
      expect(res['success'], true);
      expect(auth.currentUser?.isAdmin, true);
      expect(auth.currentUser?.name, 'Administrator');
    });
  });
}
