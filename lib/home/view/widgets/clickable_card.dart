import 'package:flutter/material.dart';

class ClickableCard extends StatelessWidget {
  const ClickableCard({
    Key? key,
    required this.onTap,
    this.title = '',
    required this.icon,
    this.backgroundColorInt = 0xFF212A35,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final int backgroundColorInt;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(backgroundColorInt),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFF949ED3),
              size: 36,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.grey.shade200),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
