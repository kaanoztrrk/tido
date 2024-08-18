abstract class MainEvent {}

class UpdatePageIndicator extends MainEvent {
  final int index;

  UpdatePageIndicator(this.index);
}

class DoNavigationClick extends MainEvent {
  final int index;

  DoNavigationClick(this.index);
}

class NextPage extends MainEvent {}

class CompleteOnBoarding extends MainEvent {}

class SkipPage extends MainEvent {}
