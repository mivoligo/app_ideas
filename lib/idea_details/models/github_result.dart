import 'package:equatable/equatable.dart';

class GithubResult extends Equatable {
  const GithubResult({
    required this.projectName,
    required this.projectLanguage,
  });

  factory GithubResult.fromJson(Map<String, dynamic> json) {
    return GithubResult(
      projectName: json['projectName'] as String,
      projectLanguage: json['projectLanguage'] as String,
    );
  }

  final String projectName;

  final String projectLanguage;

  @override
  List<Object?> get props => [projectName, projectLanguage];
}
