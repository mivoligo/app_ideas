import 'package:app_ideas/ideas/view/idea_card.dart';
import 'package:flutter/material.dart';

class IdeasView extends StatelessWidget {
  const IdeasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return const IdeaCard();
      },
    );
  }
}
