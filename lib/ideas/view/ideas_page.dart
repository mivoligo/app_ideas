import 'package:app_ideas/ideas/view/ideas_view.dart';
import 'package:flutter/material.dart';

class IdeasPage extends StatelessWidget {
  const IdeasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: const IdeasView(),
      ),
    );
  }
}
