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
        ),
      ),
    );
  }
}
