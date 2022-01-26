import 'package:app_ideas/external_links/external_links.dart';
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
            const AppName(),
            Text(
              'v 0.0.1',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white60),
            ),
            const Spacer(),
            const ClickableCard(
              title: 'Visit project page',
              onTap: launchProjectHomeGithubLink,
              iconData: Icons.code,
            ),
            const SizedBox(height: 12),
            const ClickableCard(
              title: 'Report problems',
              onTap: launchNewBugGithubLink,
              iconData: Icons.bug_report,
            ),
            const SizedBox(height: 12),
            const ClickableCard(
              title: 'Suggest improvements',
              onTap: launchNewFeatureGithubLink,
              iconData: Icons.auto_fix_high,
            ),
          ],
        ),
      ),
    );
  }
}
