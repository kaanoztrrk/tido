import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final int currentPageIndex;
  final bool isFirstTime;

  const MainState({
    required this.currentPageIndex,
    required this.isFirstTime,
  });

  factory MainState.initial() {
    return const MainState(
      currentPageIndex: 0,
      isFirstTime: true,
    );
  }

  MainState copyWith({
    int? currentPageIndex,
    bool? isFirstTime,
  }) {
    return MainState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      isFirstTime: isFirstTime ?? this.isFirstTime,
    );
  }

  @override
  List<Object> get props => [currentPageIndex, isFirstTime];
}
