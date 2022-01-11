import 'package:app_ideas/ideas/view/idea_card.dart';
import 'package:flutter/material.dart';

class IdeasView extends StatelessWidget {
  const IdeasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('App ideas'),
          floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => const IdeaCard(),
            childCount: 20,
          ),
        ),
      ],
    );
  }
}
