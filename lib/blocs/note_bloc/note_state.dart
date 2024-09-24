import 'package:equatable/equatable.dart';

import '../../data/models/category_model/category_model.dart';
import '../../data/models/note_model/note_model.dart';

class NoteState extends Equatable {
  final int initialIndex;
  final List<CategoryModel> allCategoryList;
  final List<NoteModel> allNotesList;
  final List<NoteModel> filteredNotes;
  final int noteCategoryIndex;
  final List<NoteModel> searchResults;
  final NoteModel? currentNote;

  const NoteState({
    required this.searchResults,
    required this.allCategoryList,
    required this.noteCategoryIndex,
    required this.initialIndex,
    required this.allNotesList,
    required this.filteredNotes,
    required this.currentNote,
  });

  factory NoteState.initial() {
    return NoteState(
      searchResults: const [],
      initialIndex: 0,
      noteCategoryIndex: 0,
      allCategoryList: [
        CategoryModel(
          id: 'all',
          name: "All",
        ),
      ],
      allNotesList: const [],
      filteredNotes: const [],
      currentNote: null,
    );
  }

  NoteState copyWith({
    int? initialIndex,
    int? noteCategoryIndex,
    List<CategoryModel>? allCategoryList,
    List<NoteModel>? allNotesList,
    List<NoteModel>? filteredNotes,
    List<NoteModel>? searchResults,
    NoteModel? currentNote,
  }) {
    return NoteState(
      initialIndex: initialIndex ?? this.initialIndex,
      noteCategoryIndex: noteCategoryIndex ?? this.noteCategoryIndex,
      allCategoryList: allCategoryList ?? this.allCategoryList,
      allNotesList: allNotesList ?? this.allNotesList,
      filteredNotes: filteredNotes ?? this.filteredNotes,
      searchResults: searchResults ?? this.searchResults,
      currentNote: currentNote ?? this.currentNote,
    );
  }

  int getNoteCount(int index) {
    return allNotesList.length;
  }

  @override
  List<Object?> get props => [
        initialIndex,
        allCategoryList,
        noteCategoryIndex,
        allNotesList,
        filteredNotes,
        searchResults,
        currentNote,
      ];
}
