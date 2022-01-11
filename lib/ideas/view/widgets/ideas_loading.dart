import 'package:flutter/material.dart';

class IdeasLoading extends StatelessWidget {
  const IdeasLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
