import 'package:flutter/material.dart';

class PageBackground extends StatelessWidget {
  const PageBackground({
    Key? key,
    this.body,
    this.appBar,
  }) : super(key: key);

  final Widget? body;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1B2234),
            Color(0xFF131823),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        body: body,
        appBar: appBar,
      ),
    );
  }
}
