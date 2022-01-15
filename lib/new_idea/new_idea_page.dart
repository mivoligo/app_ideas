import 'package:app_ideas/external_links/external_links.dart';
import 'package:flutter/material.dart';

class NewIdeaPage extends StatelessWidget {
  const NewIdeaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your idea'),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1B2234),
              Color(0xFF131823),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Do you have an idea for an app?\n\n'
                  ' Do you want to share it with others?\n\n'
                  ' You can do that by reporting a new issue in this project'
                  ' repository on GitHub.\n If you ready to do that, just click'
                  ' the button below and you should land on the page where you'
                  ' can submit your idea',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: const Color(0xFF949ED3)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: launchNewIdeaGithubLink,
                child: const Text('Submit your idea'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
