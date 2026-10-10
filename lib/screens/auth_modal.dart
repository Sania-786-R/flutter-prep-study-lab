import 'package:flutter/material.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';
import 'package:prep_study_lab/models/models.dart';
import 'package:prep_study_lab/services/auth_service.dart';

class AuthModal extends StatefulWidget {
  final Function(UserModel) onAuthenticated;
  final String? reasonMessage;
  final AuthService authService;

  const AuthModal({
    super.key,
    required this.onAuthenticated,
    this.reasonMessage,
    required this.authService,
  });

  @override
  State<AuthModal> createState() => _AuthModalState();
}

class _AuthModalState extends State<AuthModal> {
  String _mode = 'login'; // 'login' | 'signup'
  final _regController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  String? _error;
  bool _isLoading = false;

  @override
  void dispose() {
    _regController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_isLoading) return;

    final reg = _regController.text.trim();
    final pass = _passController.text;

    if (reg.isEmpty) {
      setState(() {
        _error = 'Please enter your Name or Registration Number.';
      });
      return;
    }

    if (pass.isEmpty) {
      setState(() {
        _error = 'Please enter your password.';
      });
      return;
    }

    if (pass.length < 6) {
      setState(() {
        _error = 'Password must be at least 6 characters.';
      });
      return;
    }

    if (_mode == 'signup') {
      if (pass != _confirmPassController.text) {
        setState(() {
          _error = 'Passwords do not match.';
        });
        return;
      }
    }

    setState(() {
      _error = null;
      _isLoading = true;
    });

    try {
      Map<String, dynamic> res;
      if (_mode == 'signup') {
        res = await widget.authService.register(reg, pass, _confirmPassController.text);
      } else {
        res = await widget.authService.login(reg, pass);
      }

      if (mounted) {
        if (res['success'] == true && res['user'] != null) {
          Navigator.of(context).pop();
          widget.onAuthenticated(res['user'] as UserModel);
        } else {
          setState(() {
            _error = res['error']?.toString() ?? 'Authentication failed.';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Unable to complete request. Please try again.';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.white,
      elevation: 16,
      clipBehavior: Clip.antiAlias,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 440,
          maxHeight: mediaQuery.size.height * 0.9,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primarySoft,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              _mode == 'login' ? Icons.lock_outline : Icons.person_add_outlined,
                              color: AppColors.primary,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _mode == 'login' ? 'SIGN IN' : 'CREATE ACCOUNT',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _mode == 'login'
                                      ? 'Enter your registration number and password to continue (new students register automatically)'
                                      : 'Register with your student details to track progress across devices',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMuted,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.textMuted),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Info Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, size: 16, color: AppColors.primary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.reasonMessage ??
                              'Sign in or create an account to track your progress and tests.',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryDark,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                if (_error != null) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.errorSoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _error!,
                      style: const TextStyle(fontSize: 12, color: AppColors.error, height: 1.3),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],

                // Registration number / Name field
                const Text(
                  'REGISTRATION NUMBER',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _regController,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    hintText: 'Enter registration number',
                    hintStyle: const TextStyle(fontSize: 13, color: AppColors.textSubtle),
                    prefixIcon: const Icon(Icons.person_outline, size: 20, color: AppColors.textMuted),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                    ),
                    filled: true,
                    fillColor: AppColors.background,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 14),

                // Password field
                Text(
                  _mode == 'signup' ? 'NEW PASSWORD' : 'PASSWORD',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _passController,
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    hintText: 'Enter password',
                    hintStyle: const TextStyle(fontSize: 13, color: AppColors.textSubtle),
                    prefixIcon: const Icon(Icons.lock_outline, size: 20, color: AppColors.textMuted),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                    ),
                    filled: true,
                    fillColor: AppColors.background,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 14),

                // Confirm password field (signup only)
                if (_mode == 'signup') ...[
                  const Text(
                    'CONFIRM PASSWORD',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _confirmPassController,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      hintText: 'Re-enter your password',
                      hintStyle: const TextStyle(fontSize: 13, color: AppColors.textSubtle),
                      prefixIcon: const Icon(Icons.lock_reset, size: 20, color: AppColors.textMuted),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],

                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: _isLoading ? null : _handleSubmit,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: _isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'PROCESSING...',
                                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _mode == 'signup' ? 'CREATE ACCOUNT' : 'SIGN IN & CONTINUE',
                                style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward, size: 16),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 12),

                // Toggle login / signup
                Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _mode = _mode == 'login' ? 'signup' : 'login';
                        _error = null;
                      });
                    },
                    style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 44),
                    ),
                    child: Text(
                      _mode == 'login'
                          ? "Don't have an account? Create Account"
                          : 'Already registered? Sign In',
                      style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
