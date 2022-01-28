import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/home.dart';
import 'ideas/repository/repositories.dart';

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
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF150050))),
      home: const HomePage(),
    );
  }
}
