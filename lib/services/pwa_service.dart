import 'package:flutter/foundation.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';
import 'package:prep_study_lab/services/download_helper.dart';

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
      final standalone = isStandaloneMode();
      _isStandalone = standalone;
      _canInstall = !standalone;
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
    String url = AppConstants.apkFallbackUrl;
    if (kIsWeb) {
      try {
        final origin = Uri.base.origin;
        if (origin.isNotEmpty && !origin.startsWith('file:') && !origin.contains('null')) {
          url = '$origin/prep-study-lab.apk';
        }
      } catch (_) {}
    }
    downloadFile(url, 'prep-study-lab.apk');
  }
}
