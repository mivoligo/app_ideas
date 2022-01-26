import 'package:app_ideas/idea_details/idea_details.dart';
import 'package:app_ideas/ideas/cubit/random_idea_cubit.dart';
import 'package:app_ideas/ideas/repository/ideas_repository.dart';
import 'package:app_ideas/widgets/widgets.dart';
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
        return const _Loading();
      }
      if (state.status == RandomIdeaStatus.failure) {
        return const _Error();
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

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DialogCard(
      children: [
        Icon(
          Icons.casino,
          size: 80,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Fetching random idea...',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorCard(
      errorMessage: 'Something went wrong when fetching random idea.\n'
          'Please check your connection and try again',
      onReloadTap: () => context.read<RandomIdeaCubit>().fetchRandomIdea(),
    );
  }
}
