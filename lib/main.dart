import 'package:flutter/material.dart';

import 'app.dart';
import 'ideas/ideas.dart';

void main() {
  runApp(
    App(ideasRepository: IdeasRepository()),
  );
}
