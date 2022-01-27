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
              padding: const EdgeInsets.only(left: 12.0, top: 12.0),
              child: Text(
                'Code examples',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          CodeExamplesView(searchKeywords: idea.attributes.searchKeywords),
          SliverToBoxAdapter(
            child: ClickableCard(
              title: 'See UI ideas for this app',
              iconData: Icons.image,
              onTap: () => launchDribbbleSearchLink(idea.title),
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
                colors: [Colors.transparent, Colors.black.withOpacity(value)],
              ),
            ),
            child: child,
          );
        });
  }
}
