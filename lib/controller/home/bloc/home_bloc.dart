import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/notes/notes.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<Note> _notes = [];

  HomeBloc() : super(HomeInitial()) {
    on<AddNote>(addNote);
    on<RemoveNote>(removeNote);

    emit(NotesAdded(notes: List.from(_notes)));
  }

  FutureOr<void> addNote(AddNote event, Emitter<HomeState> emit) {
    _notes.add(event.note);
    emit(NotesAdded(notes: List.from(_notes)));
  }

  FutureOr<void> removeNote(RemoveNote event, Emitter<HomeState> emit) {
    _notes.removeAt(event.index);
    emit(NotesAdded(notes: List.from(_notes)));
  }
}
