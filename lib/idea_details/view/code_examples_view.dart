import 'package:app_ideas/idea_details/cubit/code_examples_cubit.dart';
import 'package:app_ideas/idea_details/repository/github_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CodeExamplesView extends StatelessWidget {
  const CodeExamplesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CodeExamplesCubit(GithubRepository())..fetchCodeExamples(),
      child: const CodeExamplesList(),
    );
  }
}

class CodeExamplesList extends StatelessWidget {
  const CodeExamplesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeExamplesCubit, CodeExamplesState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.examples.length,
          itemBuilder: (context, index) {
            final example = state.examples[index];
            return Card(
              child: ListTile(
                title: Text(
                    '${example.name}, ${example.language}, ${example.score}, ${example.forks}'),
              ),
            );
          },
        );
      },
    );
  }
}
