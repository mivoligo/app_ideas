import 'package:flutter/material.dart';

class DialogCard extends StatelessWidget {
  const DialogCard({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: SizedBox(
          width: 600,
          height: 400,
          child: Card(
            color: const Color(0xFF3F0071),
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: DefaultTextStyle(
              style: const TextStyle(color: Color(0xFFBDBDBD)),
              child: Column(
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
