import '../utils/utils.dart';

const githubLink = 'github.com';
const githubSearchLink = 'search';
const projectLink = 'mivoligo/app_ideas';
const issuesLink = 'mivoligo/app_ideas/issues/new';
const newIdeaIssueParams = {
  'template': 'new-app-idea.md',
  'title': '[NEW APP IDEA]',
  'labels': 'enhancement',
};

const newBugIssueParams = {
  'template': 'bug_report.md',
  'title': '[BUG]',
};

const newFeatureIssueParams = {
  'template': 'feature_request.md',
  'title': '[FEATURE REQUEST]',
  'labels': 'enhancement',
};

const dribbbleLink = 'dribbble.com';

const dribbbleSearchLink = 'search';

Future<void> launchProjectHomeGithubLink() => openLink(githubLink, projectLink);

Future<void> launchNewIdeaGithubLink() =>
    openLink(githubLink, issuesLink, queryParams: newIdeaIssueParams);

Future<void> launchNewBugGithubLink() =>
    openLink(githubLink, issuesLink, queryParams: newBugIssueParams);

Future<void> launchNewFeatureGithubLink() =>
    openLink(githubLink, issuesLink, queryParams: newFeatureIssueParams);

Future<void> launchDribbbleSearchLink(String searchValue) =>
    openLink(dribbbleLink, dribbbleSearchLink, queryParams: {'q': searchValue});

Future<void> launchExampleCodeGithubLink(String link) => openSimpleLink(link);

Future<void> launchMoreExamplesGithubLink(
    {required List<String> searchKeywords}) {
  final query = searchKeywords.join(' ');
  return openLink(
    githubLink,
    githubSearchLink,
    queryParams: {'q': query},
  );
}
