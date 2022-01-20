import 'package:app_ideas/external_links/external_links.dart';
import 'package:app_ideas/idea_details/view/code_examples_view.dart';
import 'package:app_ideas/ideas/model/idea_model.dart';
import 'package:app_ideas/widgets/widgets.dart';
import 'package:flutter/material.dart';

class IdeaDetailsPage extends StatelessWidget {
  const IdeaDetailsPage({
    Key? key,
    required this.idea,
  }) : super(key: key);

  final Idea idea;

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      appBar: AppBar(
        title: Text(idea.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClickableCard(
              title: 'See UI ideas for this app',
              iconData: Icons.image,
              onTap: () => launchDribbbleSearchLink(idea.title),
            ),
            const Expanded(child: CodeExamplesView()),
          ],
        ),
      ),
    );
  }
}
