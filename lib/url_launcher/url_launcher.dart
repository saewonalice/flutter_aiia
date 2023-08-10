import 'dart:core';

import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  late final Uri _url;
  String url;
  UrlLauncher({required this.url}){
    _url = Uri.parse(url);
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  Future<void> launch() async {
    await _launchUrl();
  }
}
