import 'package:flutter/material.dart';

abstract class MainEvent {}

class UpdatePageIndicator extends MainEvent {
  final int index;

  UpdatePageIndicator(this.index);
}

class DoNavigationClick extends MainEvent {
  final int index;

  DoNavigationClick(this.index);
}

class NextPage extends MainEvent {
  final BuildContext context;

  NextPage(this.context);
}

class CompleteOnBoarding extends MainEvent {
  final BuildContext context;

  CompleteOnBoarding(this.context);
}

class SkipPage extends MainEvent {
  final BuildContext context;

  SkipPage(this.context);
}
