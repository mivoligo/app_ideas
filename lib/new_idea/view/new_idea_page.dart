import 'package:flutter/material.dart';
import '../../external_links/external_links.dart';
import '../../widgets/widgets.dart';

class NewIdeaPage extends StatelessWidget {
  const NewIdeaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      appBar: AppBar(
        title: const Text('Your idea'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  'Do you have an idea for an app?\n\n'
                  ' Do you want to share it with others?\n\n'
                  ' You can do that by reporting a new issue in this project'
                  ' repositories on GitHub.\n\n If you\'re ready, just click'
                  ' the button below and you should land on the page where you'
                  ' can submit your idea.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: const Color(0xFF949ED3)),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: ClickableCard(
              title: 'Submit your idea',
              iconData: Icons.add,
              onTap: launchNewIdeaGithubLink,
            ),
          ),
        ],
      ),
    );
  }
}
