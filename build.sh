#!/bin/bash
git clone https://github.com/flutter/flutter.git --depth 1 -b stable _flutter
export PATH="$PATH:`pwd`/_flutter/bin"
flutter config --enable-web
flutter pub get
flutter build web --release
