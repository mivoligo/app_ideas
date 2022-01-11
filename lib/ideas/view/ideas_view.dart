import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/ideas_cubit.dart';
import 'widgets/widgets.dart';

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
                return const IdeasInitial();

              case IdeasStatus.loading:
                return const IdeasLoading();

              case IdeasStatus.success:
                return IdeasPopulated(ideas: state.ideas);

              case IdeasStatus.failure:
                return IdeasError(
                  onPressed: context.read<IdeasCubit>().fetchIdeas,
                );
            }
          },
        ),
      ],
    );
  }
}
