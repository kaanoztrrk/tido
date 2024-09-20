import 'package:equatable/equatable.dart';
import '../../data/models/note_model/note_model.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class UpdateTab extends NoteEvent {
  final int index;

  const UpdateTab(this.index);

  @override
  List<Object> get props => [index];
}

class AddNoteEvent extends NoteEvent {
  final String title;
  final String? content;
  final List<String>? labels;

  const AddNoteEvent({
    required this.title,
    this.content,
    this.labels,
  });

  @override
  List<Object> get props => [
        title,
        content ?? '',
        labels ?? [],
      ];
}

class DeleteNoteEvent extends NoteEvent {
  final NoteModel note;

  const DeleteNoteEvent({required this.note});

  @override
  List<Object> get props => [note];
}

class UpdateNoteEvent extends NoteEvent {
  final NoteModel oldNote;
  final NoteModel newNote;

  const UpdateNoteEvent({
    required this.oldNote,
    required this.newNote,
  });

  @override
  List<Object> get props => [oldNote, newNote];
}

class LoadNotesEvent extends NoteEvent {}

class SearchNotesEvent extends NoteEvent {
  final String query;

  const SearchNotesEvent(this.query);

  @override
  List<Object> get props => [query];
}

class DeleteAllNotesEvent extends NoteEvent {}

class LoadLabelsEvent extends NoteEvent {}

class UpdateLabelsEvent extends NoteEvent {
  final List<String> labels;

  const UpdateLabelsEvent(this.labels);

  @override
  List<Object> get props => [labels];
}
