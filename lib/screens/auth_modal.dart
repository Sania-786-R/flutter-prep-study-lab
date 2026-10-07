import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    setState(() {
      _error = null;
      _isLoading = true;
    });

    final reg = _regController.text.trim();
    final pass = _passController.text;

    Map<String, dynamic> res;
    if (_mode == 'signup') {
      res = await widget.authService.register(reg, pass, _confirmPassController.text);
    } else {
      res = await widget.authService.login(reg, pass);
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      if (res['success'] == true && res['user'] != null) {
        Navigator.of(context).pop();
        widget.onAuthenticated(res['user'] as UserModel);
      } else {
        setState(() {
          _error = res['error']?.toString() ?? 'Authentication failed.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _mode == 'login' ? 'SIGN IN' : 'CREATE ACCOUNT',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            _mode == 'login' ? 'Welcome Back' : 'Student Registration',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textMuted),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              if (widget.reasonMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    widget.reasonMessage!,
                    style: const TextStyle(fontSize: 12, color: AppColors.primaryDark, height: 1.3),
                  ),
                ),
                const SizedBox(height: 14),
              ],

              if (_error != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.errorSoft,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    _error!,
                    style: const TextStyle(fontSize: 12, color: AppColors.error, height: 1.3),
                  ),
                ),
                const SizedBox(height: 14),
              ],

              // Registration number field
              TextField(
                controller: _regController,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: 'Registration Number',
                  hintText: 'e.g. 21BCE1001 or Student ID',
                  prefixIcon: const Icon(Icons.badge_outlined, size: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  filled: true,
                  fillColor: AppColors.background,
                ),
              ),
              const SizedBox(height: 14),

              // Password field
              TextField(
                controller: _passController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: _mode == 'signup' ? 'New Password' : 'Password',
                  hintText: 'At least 6 characters',
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  filled: true,
                  fillColor: AppColors.background,
                ),
              ),
              const SizedBox(height: 14),

              // Confirm password field (signup only)
              if (_mode == 'signup') ...[
                TextField(
                  controller: _confirmPassController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    prefixIcon: const Icon(Icons.lock_reset, size: 20),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    filled: true,
                    fillColor: AppColors.background,
                  ),
                ),
                const SizedBox(height: 14),
              ],

              // Submit button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isLoading ? null : _handleSubmit,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    _isLoading
                        ? 'PROCESSING...'
                        : (_mode == 'signup' ? 'CREATE ACCOUNT' : 'SIGN IN & CONTINUE'),
                    style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0),
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
    );
  }
}
