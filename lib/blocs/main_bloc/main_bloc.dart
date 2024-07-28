import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/core/routes/routes.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final PageController pageController;

  MainBloc(this.pageController)
      : super(const MainState(currentPageIndex: 0, isFirstTime: true)) {
    on<UpdatePageIndicator>((event, emit) {
      emit(state.copyWith(currentPageIndex: event.index));
    });

    on<DoNavigationClick>((event, emit) {
      pageController.jumpToPage(event.index);
      emit(state.copyWith(currentPageIndex: event.index));
    });

    on<NextPage>((event, emit) {
      if (state.currentPageIndex < 2) {
        int nextPage = state.currentPageIndex + 1;
        pageController.jumpToPage(nextPage);
        emit(state.copyWith(currentPageIndex: nextPage));
      } else {
        add(CompleteOnBoarding(event.context));
      }
    });

    on<CompleteOnBoarding>((event, emit) {
      _completeOnBoarding(event.context, emit);
    });

    on<SkipPage>((event, emit) {
      pageController.jumpToPage(2);
      emit(state.copyWith(currentPageIndex: 2));
      add(CompleteOnBoarding(event.context));
    });
  }

  void _completeOnBoarding(BuildContext context, Emitter<MainState> emit) {
    emit(state.copyWith(isFirstTime: false));
    context.push(ViRoutes.login);
  }
}
