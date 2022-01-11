import 'package:app_ideas/ideas/repository/ideas_repository.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(
    App(ideasRepository: SimpleIdeaRepository()),
  );
}
