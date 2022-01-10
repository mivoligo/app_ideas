import 'package:app_ideas/ideas/view/idea_card.dart';
import 'package:app_ideas/ideas/view/idea_filter.dart';
import 'package:flutter/material.dart';

class IdeasView extends StatelessWidget {
  const IdeasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IdeaFilter(),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const IdeaCard();
            },
          ),
        ),
      ],
    );
  }
}
