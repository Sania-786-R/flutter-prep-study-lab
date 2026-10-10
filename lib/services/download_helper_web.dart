// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

void downloadFile(String url, String fileName) {
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..style.display = 'none';
  html.document.body?.children.add(anchor);
  anchor.click();
  anchor.remove();
}

bool isStandaloneMode() {
  try {
    final isMatchMedia = html.window.matchMedia('(display-mode: standalone)').matches;
    final isNavStandalone = (html.window.navigator as dynamic).standalone == true;
    final isAndroidAppReferrer = html.document.referrer.startsWith('android-app://');
    return isMatchMedia || isNavStandalone || isAndroidAppReferrer;
  } catch (_) {
    return false;
  }
}
