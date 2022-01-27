import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../idea_details/idea_details.dart';
import '../../widgets/widgets.dart';
import '../ideas.dart';

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
              case IdeasStatus.loading:
                return const _Loading();

              case IdeasStatus.success:
                return _IdeasPopulated(ideas: state.ideas);

              case IdeasStatus.failure:
                return const _Error();
            }
          },
        ),
      ],
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _IdeasPopulated extends StatelessWidget {
  const _IdeasPopulated({
    Key? key,
    required this.ideas,
  }) : super(key: key);

  final List<Idea> ideas;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final idea = ideas[index];
          return _IdeaCard(idea: idea);
        },
        childCount: ideas.length,
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ErrorCard(
        errorMessage: 'Something went wrong when fetching ideas.\n'
            'Please check your internet connection and try again',
        onReloadTap: () => context.read<IdeasCubit>().fetchIdeas(),
      ),
    );
  }
}

class _IdeaCard extends StatelessWidget {
  const _IdeaCard({
    Key? key,
    required this.idea,
  }) : super(key: key);

  final Idea idea;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 6.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: const Color(0xFF3F0071),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Hero(
                  tag: idea.id,
                  child: CachedNetworkImage(
                    imageUrl: idea.attributes.imageLink,
                    placeholder: (context, url) => const Image(
                      image: AssetImage('assets/images/terminal.jpg'),
                    ),
                    errorWidget: (context, url, error) => const Image(
                      image: AssetImage('assets/images/terminal.jpg'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Hero(
                          tag: '${idea.id}text',
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              idea.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: const Color(0xFF949ED3)),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        idea.attributes.summary,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: const Color(0xFFBDBDBD)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => IdeaDetailsPage(idea: idea),
            ),
          ),
        ),
      ),
    );
  }
}
