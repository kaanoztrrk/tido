import 'package:TiDo/blocs/home_bloc/home_state.dart';
import 'package:TiDo/data/models/note_model/note_model.dart';
import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/models/category_model/category_model.dart';
import '../../data/models/task_model/task_model.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final Box<NoteModel> noteBox = Hive.box<NoteModel>('allNotesBox');

  NoteBloc() : super(NoteState.initial()) {
    on<UpdateTab>(_onUpdateTab);
    on<AddNoteEvent>(_createNote);
    on<DeleteNoteEvent>(_deleteNote);
    on<UpdateNoteEvent>(_updateNote);
    on<LoadNotesEvent>(_loadNotes);
    on<SearchNotesEvent>(_searchNotes);
    on<DeleteAllNotesEvent>(_deleteAllNotes);

    // Initial Events
    add(LoadNotesEvent());
  }

  void _onUpdateTab(UpdateTab event, Emitter<NoteState> emit) {
    emit(state.copyWith(initialIndex: event.index));
  }

  void _deleteAllNotes(DeleteAllNotesEvent event, Emitter<NoteState> emit) {
    noteBox.clear();
    emit(state.copyWith(allNotesList: []));
  }

  void _deleteNote(DeleteNoteEvent event, Emitter<NoteState> emit) async {
    List<NoteModel> updatedNotesList = List.of(state.allNotesList);
    int noteIndex = updatedNotesList.indexOf(event.note);

    if (noteIndex != -1) {
      updatedNotesList.removeAt(noteIndex);
      await noteBox.deleteAt(noteIndex);
    }

    emit(state.copyWith(allNotesList: updatedNotesList));
  }

  void _createNote(AddNoteEvent event, Emitter<NoteState> emit) {
    List<NoteModel> newNotesList = List.of(state.allNotesList);

    NoteModel newNote = NoteModel(
      title: event.title,
      content: event.content,
      labels: event.labels,
    );

    newNotesList.add(newNote);
    noteBox.add(newNote);

    emit(state.copyWith(allNotesList: newNotesList));
  }

  void _updateNote(UpdateNoteEvent event, Emitter<NoteState> emit) async {
    List<NoteModel> updatedNotesList = List.of(state.allNotesList);
    int index = updatedNotesList.indexOf(event.oldNote);

    if (index != -1) {
      updatedNotesList[index] = event.newNote;
      await noteBox.putAt(index, event.newNote); // Update note
    }

    emit(state.copyWith(allNotesList: updatedNotesList));
  }

  void _loadNotes(LoadNotesEvent event, Emitter<NoteState> emit) {
    List<NoteModel> notes = noteBox.values.toList();
    emit(state.copyWith(allNotesList: notes));
  }

  void _searchNotes(SearchNotesEvent event, Emitter<NoteState> emit) {
    List<NoteModel> searchResults = state.allNotesList
        .where((note) =>
            note.title.toLowerCase().contains(event.query.toLowerCase()))
        .toList();

    emit(state.copyWith(searchResults: searchResults));
  }
}
