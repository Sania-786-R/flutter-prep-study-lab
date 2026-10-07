import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';

class PwaService extends ChangeNotifier {
  bool _canInstall = false;
  bool _isStandalone = false;

  bool get canInstall => _canInstall && !_isStandalone;
  bool get isStandalone => _isStandalone;

  PwaService() {
    _detectEnvironment();
  }

  void _detectEnvironment() {
    if (kIsWeb) {
      // In web browser environment, we offer install prompt / APK download options
      _canInstall = true;
    } else {
      // Running as native Android/iOS app
      _isStandalone = true;
      _canInstall = false;
    }
    notifyListeners();
  }

  void markInstalled() {
    _isStandalone = true;
    _canInstall = false;
    notifyListeners();
  }

  Future<void> downloadApk() async {
    final uri = Uri.parse(AppConstants.apkDownloadUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
