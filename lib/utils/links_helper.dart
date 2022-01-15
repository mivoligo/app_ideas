import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(
  String authority,
  String path, {
  Map<String, dynamic>? queryParams,
  VoidCallback? onError,
}) async {
  final Uri launchUri = Uri.https(
    authority,
    path,
    queryParams,
  );
  if (await canLaunch(launchUri.toString())) {
    await launch(launchUri.toString());
  } else if (onError != null) {
    onError();
  }
}
