import 'package:app_ideas/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      appBar: AppBar(
        title: const Text('About app'),
      ),
    );
  }
}
