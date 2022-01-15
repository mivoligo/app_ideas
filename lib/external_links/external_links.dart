import 'package:app_ideas/utils/utils.dart';

const githubLink = 'github.com';
const issuesLink = 'mivoligo/app_ideas_page/issues/new';
const newIdeaIssueParams = {
  'template': 'new-app-idea.md',
  'title': '[NEW APP IDEA]',
  'labels': 'enhancement',
};

Future<void> launchNewIdeaGithubLink() =>
    openLink(githubLink, issuesLink, queryParams: newIdeaIssueParams);
