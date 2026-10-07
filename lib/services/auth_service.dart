import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';
import 'package:prep_study_lab/models/models.dart';

class AuthService extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = true;

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  bool get isAdmin => _currentUser?.isAdmin ?? false;

  SupabaseClient get _supabase => Supabase.instance.client;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      // 1. Check Supabase active session
      final session = _supabase.auth.currentSession;
      if (session != null) {
        final user = session.user;
        String role = 'student';
        try {
          final roleRow = await _supabase
              .from('user_roles')
              .select('role')
              .eq('user_id', user.id)
              .maybeSingle();
          if (roleRow != null && roleRow['role'] == 'admin') {
            role = 'admin';
          } else if (user.userMetadata?['role'] == 'admin' || user.appMetadata['role'] == 'admin') {
            role = 'admin';
          }
        } catch (_) {
          if (user.userMetadata?['role'] == 'admin' || user.appMetadata['role'] == 'admin') {
            role = 'admin';
          }
        }

        final identifier = user.userMetadata?['regNumber'] ??
            user.userMetadata?['name'] ??
            (user.email != null ? user.email!.split('@').first : 'Student');

        _currentUser = UserModel(
          id: user.id,
          name: identifier.toString(),
          regNumber: user.userMetadata?['regNumber']?.toString() ?? (role == 'student' ? identifier.toString() : null),
          email: user.email,
          role: role,
          status: 'active',
          createdAt: user.createdAt,
        );

        await _saveUserToPrefs(_currentUser!);
        _isLoading = false;
        notifyListeners();
        _listenToAuthChanges();
        return;
      }

      // 2. Fallback to cached preferences session
      final prefs = await SharedPreferences.getInstance();
      final userJsonStr = prefs.getString(AppConstants.keyUserSession);
      if (userJsonStr != null) {
        final userMap = jsonDecode(userJsonStr);
        final user = UserModel.fromJson(userMap);
        if (user.status != 'deactivated') {
          _currentUser = user;
        }
      }
    } catch (e) {
      debugPrint('AuthService initialize notice: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
      _listenToAuthChanges();
    }
  }

  void _listenToAuthChanges() {
    _supabase.auth.onAuthStateChange.listen((data) async {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn ||
          event == AuthChangeEvent.tokenRefreshed ||
          event == AuthChangeEvent.userUpdated) {
        if (session != null) {
          final user = session.user;
          String role = 'student';
          try {
            final roleRow = await _supabase
                .from('user_roles')
                .select('role')
                .eq('user_id', user.id)
                .maybeSingle();
            if (roleRow != null && roleRow['role'] == 'admin') {
              role = 'admin';
            }
          } catch (_) {}

          final identifier = user.userMetadata?['regNumber'] ??
              user.userMetadata?['name'] ??
              (user.email != null ? user.email!.split('@').first : 'Student');

          _currentUser = UserModel(
            id: user.id,
            name: identifier.toString(),
            regNumber: user.userMetadata?['regNumber']?.toString() ?? (role == 'student' ? identifier.toString() : null),
            email: user.email,
            role: role,
            status: 'active',
            createdAt: user.createdAt,
          );
          await _saveUserToPrefs(_currentUser!);
          notifyListeners();
        }
      } else if (event == AuthChangeEvent.signedOut) {
        _currentUser = null;
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(AppConstants.keyUserSession);
        notifyListeners();
      }
    });
  }

  static String hashPassword(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    return sha256.convert(bytes).toString();
  }

  Future<void> _saveUserToPrefs(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.keyUserSession, jsonEncode(user.toJson()));
    } catch (_) {}
  }

  // Student registration with Registration Number and Password
  Future<Map<String, dynamic>> register(
      String regNumber, String password, String confirmPassword) async {
    final cleanReg = regNumber.trim().toUpperCase();

    if (cleanReg.isEmpty) {
      return {'success': false, 'error': 'Please enter your registration number.'};
    }
    if (cleanReg.length < 3) {
      return {'success': false, 'error': 'Registration number must be at least 3 characters.'};
    }
    if (password.length < 6) {
      return {'success': false, 'error': 'Password must be at least 6 characters.'};
    }
    if (password != confirmPassword) {
      return {'success': false, 'error': 'Passwords do not match.'};
    }

    final sanitizedEmail =
        '${cleanReg.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '')}@prepstudylab.com';

    try {
      final response = await _supabase.auth.signUp(
        email: sanitizedEmail,
        password: password,
        data: {'regNumber': cleanReg, 'name': cleanReg, 'role': 'student'},
      );

      if (response.user != null) {
        final newUser = UserModel(
          id: response.user!.id,
          name: cleanReg,
          regNumber: cleanReg,
          email: sanitizedEmail,
          role: 'student',
          status: 'active',
          createdAt: response.user!.createdAt,
        );

        try {
          await _supabase.from('user_roles').insert({'user_id': response.user!.id, 'role': 'student'});
        } catch (_) {}

        if (response.session == null) {
          await _supabase.auth.signInWithPassword(email: sanitizedEmail, password: password);
        }

        _currentUser = newUser;
        await _saveUserToPrefs(newUser);
        notifyListeners();
        return {'success': true, 'user': newUser};
      }
    } on AuthException catch (e) {
      if (e.message.contains('User already registered') || e.statusCode == '422') {
        // If already registered, attempt login
        final loginRes = await login(cleanReg, password);
        if (loginRes['success'] == true) {
          return loginRes;
        }
        return {
          'success': false,
          'error': 'An account for registration number $cleanReg already exists. Please sign in with your password.'
        };
      }
      return {'success': false, 'error': e.message};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }

    return {'success': false, 'error': 'Failed to complete registration.'};
  }

  // Unified login by Registration Number or Email
  Future<Map<String, dynamic>> login(String regNumberOrEmail, String password) async {
    final cleanInput = regNumberOrEmail.trim();
    if (cleanInput.isEmpty || password.isEmpty) {
      return {'success': false, 'error': 'Please enter your registration number and password.'};
    }
    if (password.length < 6) {
      return {'success': false, 'error': 'Password must be at least 6 characters.'};
    }

    final isEmail = cleanInput.contains('@');
    final cleanReg = isEmail ? cleanInput : cleanInput.toUpperCase();
    final emailToUse = isEmail
        ? cleanInput.toLowerCase()
        : '${cleanInput.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '')}@prepstudylab.com';

    try {
      final response = await _supabase.auth.signInWithPassword(
        email: emailToUse,
        password: password,
      );

      if (response.user != null) {
        final isAdminLogin = cleanReg == 'ADMIN' ||
            cleanInput.toLowerCase().contains('admin') ||
            (response.user!.email?.toLowerCase().contains('admin') ?? false);
        String role = isAdminLogin ? 'admin' : 'student';

        try {
          final roleRow = await _supabase
              .from('user_roles')
              .select('role')
              .eq('user_id', response.user!.id)
              .maybeSingle();

          if (roleRow != null && roleRow['role'] == 'admin') {
            role = 'admin';
          } else if (isAdminLogin) {
            await _supabase.from('user_roles').upsert({'user_id': response.user!.id, 'role': 'admin'});
          }
        } catch (_) {}

        final identifier = response.user!.userMetadata?['regNumber'] ??
            response.user!.userMetadata?['name'] ??
            cleanReg;

        final authUser = UserModel(
          id: response.user!.id,
          name: identifier.toString(),
          regNumber: response.user!.userMetadata?['regNumber']?.toString() ?? (role == 'student' ? identifier.toString() : null),
          email: response.user!.email,
          role: role,
          status: 'active',
          createdAt: response.user!.createdAt,
        );

        _currentUser = authUser;
        await _saveUserToPrefs(authUser);
        notifyListeners();
        return {'success': true, 'user': authUser};
      }
    } on AuthException catch (e) {
      if (!isEmail) {
        // Auto sign-up if first time logging in
        try {
          final signUpRes = await _supabase.auth.signUp(
            email: emailToUse,
            password: password,
            data: {'regNumber': cleanReg, 'name': cleanReg, 'role': 'student'},
          );
          if (signUpRes.user != null) {
            final newUser = UserModel(
              id: signUpRes.user!.id,
              name: cleanReg,
              regNumber: cleanReg,
              email: emailToUse,
              role: 'student',
              status: 'active',
              createdAt: signUpRes.user!.createdAt,
            );
            _currentUser = newUser;
            await _saveUserToPrefs(newUser);
            notifyListeners();
            return {'success': true, 'user': newUser};
          }
        } catch (_) {
          return {'success': false, 'error': 'Incorrect password for registration number $cleanReg. Please check your credentials.'};
        }
      }
      return {'success': false, 'error': e.message};
    } catch (e) {
      return {'success': false, 'error': 'Authentication error: ${e.toString()}'};
    }

    return {'success': false, 'error': 'Account not found. Please check your credentials.'};
  }

  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
    } catch (_) {}
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.keyUserSession);
    notifyListeners();
  }
}
