import 'package:flutter/material.dart';

class IdeaCard extends StatelessWidget {
  const IdeaCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        color: Colors.green,
        child: Column(
          children: const [
            Expanded(
              child: Placeholder(),
            ),
            Text('some text'),
            Text('some text which is longer much'),
            Text('some text'),
          ],
        ),
      ),
    );
  }
}
