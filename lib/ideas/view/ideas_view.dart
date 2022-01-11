import 'package:app_ideas/ideas/view/idea_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/ideas_cubit.dart';

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
        BlocBuilder<IdeasCubit, IdeasState>(
          builder: (context, state) {
            switch (state.status) {
              case IdeasStatus.initial:
                return const SliverFillRemaining();

              case IdeasStatus.loading:
                return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()));

              case IdeasStatus.success:
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final idea = state.ideas[index];
                      return IdeaCard(
                        title: idea.title,
                        description: idea.description,
                      );
                    },
                    childCount: state.ideas.length,
                  ),
                );

              case IdeasStatus.failure:
                return const SliverFillRemaining(
                  child: Center(child: Text('Something went wrong')),
                );
            }
          },
        ),
      ],
    );
  }
}
