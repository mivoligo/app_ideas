import 'package:app_ideas/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    Key? key,
    this.iconData = Icons.cloud_off,
    this.iconColor = const Color(0xFFBDBDBD),
    this.iconSize = 80,
    required this.errorMessage,
    required this.onReloadTap,
    this.optionalText = '',
    this.optionalIconData = Icons.launch,
    this.onOptionalTap,
  }) : super(key: key);

  final IconData iconData;
  final Color iconColor;
  final double iconSize;
  final String errorMessage;
  final VoidCallback? onReloadTap;
  final String optionalText;
  final IconData? optionalIconData;
  final VoidCallback? onOptionalTap;

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      children: [
        const SizedBox(height: 12),
        Icon(
          iconData,
          size: iconSize,
          color: iconColor,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: onOptionalTap != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                label: const Text('Reload'),
                icon: const Icon(Icons.refresh),
                onPressed: onReloadTap,
              ),
              if (onOptionalTap != null)
                ElevatedButton.icon(
                  label: Text(optionalText),
                  icon: Icon(optionalIconData),
                  onPressed: onOptionalTap,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
