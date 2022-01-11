import 'package:equatable/equatable.dart';

class Idea extends Equatable {
  const Idea({
    required this.title,
    required this.description,
    required this.imageLink,
  });

  factory Idea.fromJson(Map<String, dynamic> json) {
    final title = json['name'] as String;
    final description = json['attributes']['summary'] as String;
    final imageLink = json['attributes']['image'] as String?;
    return Idea(title: title, description: description, imageLink: imageLink);
  }

  final String title;
  final String description;
  final String? imageLink;

  @override
  List<Object?> get props => [title, description, imageLink];
}
