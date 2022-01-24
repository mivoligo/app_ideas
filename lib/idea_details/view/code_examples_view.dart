import 'package:app_ideas/external_links/external_links.dart';
import 'package:app_ideas/idea_details/cubit/code_examples_cubit.dart';
import 'package:app_ideas/idea_details/models/github_result.dart';
import 'package:app_ideas/idea_details/repository/github_repository.dart';
import 'package:app_ideas/widgets/clickable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double kExamplesRowHeight = 240.0;

class CodeExamplesView extends StatelessWidget {
  const CodeExamplesView({Key? key, required this.searchKeywords})
      : super(key: key);

  final List<String> searchKeywords;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CodeExamplesCubit(
        GithubRepository(),
      )..fetchCodeExamples(searchKeywords: searchKeywords),
      child: CodeExamplesList(searchKeywords: searchKeywords),
    );
  }
}

class CodeExamplesList extends StatelessWidget {
  const CodeExamplesList({
    Key? key,
    required this.searchKeywords,
  }) : super(key: key);

  final List<String> searchKeywords;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeExamplesCubit, CodeExamplesState>(
      builder: (context, state) {
        switch (state.status) {
          case CodeExamplesStatus.initial:
          case CodeExamplesStatus.loading:
            return const _ExamplesLoading();
          case CodeExamplesStatus.success:
            return _ExamplesPopulated(
              results: state.examples,
              searchKeywords: searchKeywords,
            );
          case CodeExamplesStatus.failure:
            return _ExampleError(
              onReloadTap: () => context
                  .read<CodeExamplesCubit>()
                  .fetchCodeExamples(searchKeywords: searchKeywords),
              onGoToGithubTap: () =>
                  launchMoreExamplesGithubLink(searchKeywords: searchKeywords),
            );
        }
      },
    );
  }
}

class _ExamplesLoading extends StatelessWidget {
  const _ExamplesLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: kExamplesRowHeight,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Fetching examples from GitHub'),
              ),
              Expanded(child: Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExamplesPopulated extends StatelessWidget {
  const _ExamplesPopulated({
    Key? key,
    required this.results,
    required this.searchKeywords,
  }) : super(key: key);

  final List<GithubResult> results;
  final List<String> searchKeywords;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: kExamplesRowHeight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: results.length + 1,
          itemBuilder: (context, index) {
            if (index < results.length) {
              final result = results[index];
              return _CodeExampleCard(
                name: result.name,
                summary: result.description,
                language: result.language,
                stars: result.forks,
                onTap: () => launchExampleCodeGithubLink(result.svnUrl),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: ClickableCard(
                  title: 'More examples on GitHub',
                  iconData: Icons.north_east,
                  onTap: () => launchMoreExamplesGithubLink(
                      searchKeywords: searchKeywords),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _ExampleError extends StatelessWidget {
  const _ExampleError({
    Key? key,
    required this.onReloadTap,
    required this.onGoToGithubTap,
  }) : super(key: key);

  final VoidCallback onReloadTap;
  final VoidCallback onGoToGithubTap;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: kExamplesRowHeight,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Icon(
                Icons.cloud_off,
                size: 80,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Something went wrong when fetching examples.\n'
                    'Please check your internet connection and try again.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      label: const Text('Reload'),
                      icon: const Icon(Icons.refresh),
                      onPressed: onReloadTap,
                    ),
                    ElevatedButton.icon(
                      label: const Text('Open in browser'),
                      icon: const Icon(Icons.launch),
                      onPressed: onGoToGithubTap,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CodeExampleCard extends StatelessWidget {
  const _CodeExampleCard({
    Key? key,
    required this.name,
    this.summary,
    required this.stars,
    this.language,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final String? summary;
  final int stars;
  final String? language;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  summary != null
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              summary!,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        )
                      : const Spacer(),
                  Row(
                    children: [
                      language != null
                          ? Expanded(
                              child: Text(
                                language!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                          : const Spacer(),
                      const Icon(
                        Icons.star,
                      ),
                      Text('$stars'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
