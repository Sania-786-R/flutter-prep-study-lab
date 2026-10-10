import 'download_helper_stub.dart'
    if (dart.library.html) 'download_helper_web.dart' as helper;

void downloadFile(String url, String fileName) {
  helper.downloadFile(url, fileName);
}

bool isStandaloneMode() => helper.isStandaloneMode();
