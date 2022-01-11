import 'package:flutter/material.dart';

class IdeasError extends StatelessWidget {
  const IdeasError({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '🤔',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'Something went wrong',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: const Color(0xFF949ED3)),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text('Reload'),
            ),
          ],
        ),
      ),
    );
  }
}
