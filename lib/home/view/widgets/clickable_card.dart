import 'package:flutter/material.dart';

class ClickableCard extends StatelessWidget {
  const ClickableCard({
    Key? key,
    required this.onTap,
    this.title = '',
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xBBEEEEEE),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(child: Text(title)),
      ),
    );
  }
}
