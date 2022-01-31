import 'package:flutter/material.dart';

import '../../about_app/about_app.dart';
import '../../ideas/ideas.dart';
import '../../new_idea/new_idea.dart';
import '../../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: const [
              Expanded(
                child: _Header(),
              ),
              _Navigation(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppName(),
        const SizedBox(height: 12.0),
        Text(
          'Collection of app ideas for your portfolio',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white60),
        ),
      ],
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ClickableCard(
                title: 'Browse Ideas',
                iconData: Icons.category,
                backgroundColorInt: 0xFF610094,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const IdeasPage(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: ClickableCard(
                title: 'Random',
                iconData: Icons.casino,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RandomIdeaPage(),
                )),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: ClickableCard(
                title: 'About this app',
                iconData: Icons.info,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AboutAppPage(),
                )),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 4,
              child: ClickableCard(
                title: 'Propose your idea',
                iconData: Icons.add,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NewIdeaPage(),
                )),
              ),
            ),
          ],
        )
      ],
    );
  }
}
