import 'package:app_ideas/idea_details/idea_details.dart';
import 'package:app_ideas/ideas/cubit/random_idea_cubit.dart';
import 'package:app_ideas/ideas/repository/ideas_repository.dart';
import 'package:app_ideas/widgets/page_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomIdeaPage extends StatelessWidget {
  const RandomIdeaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      body: BlocProvider(
        create: (context) => RandomIdeaCubit(
          context.read<IdeasRepository>(),
        )..fetchRandomIdea(),
        child: const RandomIdeaView(),
      ),
    );
  }
}

class RandomIdeaView extends StatelessWidget {
  const RandomIdeaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RandomIdeaCubit, RandomIdeaState>(
        builder: (context, state) {
      if (state.status == RandomIdeaStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return const SizedBox();
    }, listener: (context, state) {
      if (state.status == RandomIdeaStatus.success) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => IdeaDetailsPage(idea: state.idea),
        ));
      }
    });
  }
}
