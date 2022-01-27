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
            Color(0xFF000000),
            Color(0xFF150050),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: body,
        appBar: appBar,
      ),
    );
  }
}
