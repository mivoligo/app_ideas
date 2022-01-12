import 'package:flutter/material.dart';

class IdeaCard extends StatelessWidget {
  const IdeaCard({
    Key? key,
    required this.title,
    required this.description,
    this.image,
  }) : super(key: key);

  final String title;
  final String description;
  final Image? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: const Color(0xFF212A35),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: image ??
                  Image.asset(
                    'assets/images/terminal.jpg',
                    fit: BoxFit.cover,
                  ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: const Color(0xFF949ED3)),
                      ),
                    ),
                    Text(
                      description,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}