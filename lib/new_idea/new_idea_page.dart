import 'package:app_ideas/external_links/external_links.dart';
import 'package:app_ideas/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NewIdeaPage extends StatelessWidget {
  const NewIdeaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      appBar: AppBar(
        title: const Text('Your idea'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Do you have an idea for an app?\n\n'
                  ' Do you want to share it with others?\n\n'
                  ' You can do that by reporting a new issue in this project'
                  ' repository on GitHub.\n\n If you\'re ready, just click'
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
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: launchNewIdeaGithubLink,
              child: Text('Submit your idea'),
            ),
          ),
        ],
      ),
    );
  }
}
