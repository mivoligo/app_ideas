import 'package:app_ideas/ideas/cubit/ideas_cubit.dart';
import 'package:app_ideas/ideas/repository/ideas_repository.dart';
import 'package:app_ideas/ideas/view/ideas_view.dart';
import 'package:app_ideas/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdeasPage extends StatelessWidget {
  const IdeasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      body: BlocProvider(
        create: (context) => IdeasCubit(
          context.read<IdeasRepository>(),
        )..fetchIdeas(),
        child: const IdeasView(),
      ),
    );
  }
}
