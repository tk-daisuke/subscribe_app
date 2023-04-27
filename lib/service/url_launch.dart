import 'package:url_launcher/url_launcher.dart';

class UrlLaunch {
  void launchURL(String _url) async {
    final Error error = ArgumentError('開けませんでした$_url');
    await canLaunch(_url) ? await launch(_url) : throw error;
  }
}
