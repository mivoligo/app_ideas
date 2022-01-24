import 'dart:ui';

import 'package:app_ideas/external_links/external_links.dart';
import 'package:app_ideas/idea_details/view/code_examples_view.dart';
import 'package:app_ideas/ideas/model/idea_model.dart';
import 'package:app_ideas/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
              title: Text(idea.title),
              collapseMode: CollapseMode.parallax,
              background: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Theme.of(context).primaryColor.withOpacity(0.8)
                    ],
                  ),
                ),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
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
