import 'package:app_ideas/home/view/widgets/widgets.dart';
import 'package:app_ideas/ideas/ideas.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        child: Column(
          children: [
            const Expanded(flex: 2, child: SizedBox()),
            Expanded(
              child: ClickableCard(
                title: 'Browse Ideas',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const IdeasPage(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: ClickableCard(
                      title: 'Random Idea',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ClickableCard(
                      title: 'Propose Your Idea',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
