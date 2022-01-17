import 'package:app_ideas/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      appBar: AppBar(
        title: const Text('About app'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'App Ideas',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              'v 0.0.1',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: Colors.grey.shade600),
            ),
            const Spacer(),
            ClickableCard(
              title: 'Visit project page',
              onTap: () {},
              icon: Icons.code,
            ),
            const SizedBox(height: 12),
            ClickableCard(
              title: 'Report problems',
              onTap: () {},
              icon: Icons.bug_report,
            ),
            const SizedBox(height: 12),
            ClickableCard(
              title: 'Suggest improvements',
              onTap: () {},
              icon: Icons.auto_fix_high,
            ),
          ],
        ),
      ),
    );
  }
}
