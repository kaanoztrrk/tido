import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final PageController pageController;

  MainBloc({required this.pageController})
      : super(const MainState(currentPageIndex: 0, isFirstTime: true)) {
    on<UpdatePageIndicator>(_onUpdatePageIndicator);
    on<DoNavigationClick>(_onDoNavigationClick);
    on<NextPage>(_onNextPage);
    on<CompleteOnBoarding>(_onCompleteOnBoarding);
    on<SkipPage>(_onSkipPage);
  }

  void _onUpdatePageIndicator(
      UpdatePageIndicator event, Emitter<MainState> emit) {
    emit(state.copyWith(currentPageIndex: event.index));
  }

  void _onDoNavigationClick(DoNavigationClick event, Emitter<MainState> emit) {
    if (pageController.hasClients) {
      pageController.jumpToPage(event.index);
      emit(state.copyWith(currentPageIndex: event.index));
    }
  }

  void _onNextPage(NextPage event, Emitter<MainState> emit) {
    if (state.currentPageIndex < 2) {
      final nextPage = state.currentPageIndex + 1;

      // Delaying the navigation to the next frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (pageController.hasClients) {
          pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          emit(state.copyWith(currentPageIndex: nextPage));
        }
      });
    } else {
      // Indicate that onboarding is completed
      emit(state.copyWith(isFirstTime: false));
    }
  }

  void _onCompleteOnBoarding(
      CompleteOnBoarding event, Emitter<MainState> emit) {
    emit(state.copyWith(isFirstTime: false));

    // Notify view to navigate to login page
    // We need to handle navigation in the view
  }

  void _onSkipPage(SkipPage event, Emitter<MainState> emit) {
    if (pageController.hasClients) {
      pageController.jumpToPage(2);
      emit(state.copyWith(currentPageIndex: 2));

      // Indicate that onboarding is completed
      emit(state.copyWith(isFirstTime: false));

      // Notify view to navigate to login page
      // We need to handle navigation in the view
    }
  }
}
