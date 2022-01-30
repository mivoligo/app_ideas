import 'package:flutter/material.dart';

class ClickableCard extends StatelessWidget {
  const ClickableCard({
    Key? key,
    required this.title,
    required this.iconData,
    this.backgroundColorInt = 0xFF3F0071,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final IconData iconData;
  final int backgroundColorInt;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Color(backgroundColorInt),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Icon(
                  iconData,
                  color: const Color(0xFFBDBDBD),
                  size: 36,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: const Color(0xFFBDBDBD)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
