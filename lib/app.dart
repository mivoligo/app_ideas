import 'package:app_ideas/ideas/repository/ideas_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/home.dart';

class App extends StatelessWidget {
  const App({Key? key, required IdeasRepository ideasRepository})
      : _ideasRepository = ideasRepository,
        super(key: key);

  final IdeasRepository _ideasRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _ideasRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
