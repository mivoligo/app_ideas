import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../external_links/external_links.dart';
import '../../ideas/models/models.dart';
import '../../widgets/widgets.dart';
import '../idea_details.dart';

class IdeaDetailsPage extends StatelessWidget {
  const IdeaDetailsPage({
    Key? key,
    required this.idea,
  }) : super(key: key);

  final Idea idea;

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Hero(
                tag: '${idea.id}text',
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    idea.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              collapseMode: CollapseMode.parallax,
              background: _AnimatedDecoratedBox(idea: idea),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                idea.attributes.description,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: const Color(0xFFBDBDBD)),
              ),
            ),
          ),
          if (idea.attributes.features.isNotEmpty)
            const _TextHeader(label: 'Typical features'),
          _Features(features: idea.attributes.features),
          const _TextHeader(label: 'Code examples'),
          CodeExamplesView(searchKeywords: idea.attributes.searchKeywords),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 12.0,
                bottom: 12.0,
              ),
              child: _DribleButton(
                idea: idea,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedDecoratedBox extends StatelessWidget {
  const _AnimatedDecoratedBox({
    Key? key,
    required this.idea,
  }) : super(key: key);

  final Idea idea;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        duration: const Duration(milliseconds: 500),
        tween: Tween<double>(begin: 0.0, end: 1.0),
        curve: Curves.easeIn,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Hero(
            tag: idea.id,
            child: CachedNetworkImage(
              imageUrl: idea.attributes.imageLink,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Image(
                image: AssetImage('assets/images/terminal.jpg'),
              ),
              errorWidget: (context, url, error) => const Image(
                image: AssetImage('assets/images/terminal.jpg'),
              ),
            ),
          ),
        ),
        builder: (context, double value, child) {
          return DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.75, 1],
                colors: [
                  const Color(0x003F0071),
                  const Color(0xBB3F0071).withOpacity(value),
                  const Color(0xFF3F0071).withOpacity(value),
                ],
              ),
            ),
            child: child,
          );
        });
  }
}

class _TextHeader extends StatelessWidget {
  const _TextHeader({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          top: 12.0,
          right: 12.0,
        ),
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: const Color(0xFFBDBDBD)),
        ),
      ),
    );
  }
}

class _Features extends StatelessWidget {
  const _Features({Key? key, required this.features}) : super(key: key);

  final List<String> features;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        features
            .map((feature) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.remove,
                        color: Color(0xFFBDBDBD),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          feature,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: const Color(0xFFBDBDBD)),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _DribleButton extends StatelessWidget {
  const _DribleButton({Key? key, required this.idea}) : super(key: key);

  final Idea idea;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Color(0xFF610094),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => launchDribbbleSearchLink(idea.title),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Image.asset(
                      'assets/images/drible.jpg',
                      width: 50,
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'See UI ideas for a ${idea.title} app on Dribble',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: const Color(0xFFBDBDBD)),
                    ),
                  ),
                ),
                const Icon(
                  Icons.launch,
                  color: Color(0xFFBDBDBD),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
