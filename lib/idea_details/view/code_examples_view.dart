import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../external_links/external_links.dart';
import '../../widgets/widgets.dart';
import '../idea_details.dart';

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
            return const _Loading();
          case CodeExamplesStatus.success:
            return _Populated(
              results: state.examples,
              searchKeywords: searchKeywords,
            );
          case CodeExamplesStatus.failure:
            return _Error(
              searchKeywords: searchKeywords,
            );
        }
      },
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SizedBox(
        height: kExamplesRowHeight,
        child: DialogCard(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('Fetching examples from GitHub'),
            ),
            Expanded(child: Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }
}

class _Populated extends StatelessWidget {
  const _Populated({
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
              return _CodeExampleCard(result: result);
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

class _Error extends StatelessWidget {
  const _Error({
    Key? key,
    required this.searchKeywords,
  }) : super(key: key);

  final List<String> searchKeywords;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: kExamplesRowHeight,
        child: ErrorCard(
          iconData: Icons.cloud_off,
          iconSize: 32,
          errorMessage: 'Something went wrong when fetching examples.\n'
              'Please check your connection and try again.',
          onReloadTap: () => context
              .read<CodeExamplesCubit>()
              .fetchCodeExamples(searchKeywords: searchKeywords),
          optionalText: 'Open in browser',
          onOptionalTap: () =>
              launchMoreExamplesGithubLink(searchKeywords: searchKeywords),
        ),
      ),
    );
  }
}

class _CodeExampleCard extends StatelessWidget {
  const _CodeExampleCard({
    Key? key,
    required this.result,
  }) : super(key: key);

  final GithubResult result;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: 210,
        decoration: BoxDecoration(
          color: const Color(0xFF3F0071),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Material(
          type: MaterialType.transparency,
          textStyle: const TextStyle(color: Color(0xFFBDBDBD)),
          child: InkWell(
            onTap: () => launchExampleCodeGithubLink(result.projectUrl),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${result.owner.name}/',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: const Color(0xFFBDBDBD)),
                            ),
                            Text(
                              result.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: const Color(0xFFBDBDBD),
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      CircleAvatar(
                        foregroundImage: NetworkImage(result.owner.avatarUrl),
                      ),
                    ],
                  ),
                  result.description != null
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              result.description!,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        )
                      : const Spacer(),
                  Row(
                    children: [
                      result.language != null
                          ? Expanded(
                              child: Text(
                                result.language!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                          : const Spacer(),
                      const Icon(
                        Icons.star_border,
                        size: 16,
                        color: Color(0xFFBDBDBD),
                      ),
                      Text('${result.stars}'),
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
