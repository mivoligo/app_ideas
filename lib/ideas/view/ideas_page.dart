import 'package:app_ideas/ideas/view/ideas_view.dart';
import 'package:flutter/material.dart';

class IdeasPage extends StatelessWidget {
  const IdeasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: IdeasView(),
    );
  }
}
