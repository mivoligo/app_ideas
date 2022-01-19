import 'package:app_ideas/idea_details/idea_details.dart';
import 'package:app_ideas/ideas/model/idea_model.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class IdeasPopulated extends StatelessWidget {
  const IdeasPopulated({Key? key, required this.ideas}) : super(key: key);

  final List<Idea> ideas;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final idea = ideas[index];
          return IdeaCard(
            title: idea.title,
            description: idea.description,
            image: idea.imageLink,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const IdeaDetailsPage(),
              ),
            ),
          );
        },
        childCount: ideas.length,
      ),
    );
  }
}
