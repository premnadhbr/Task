part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class NotesAdded extends HomeState {
  final List<Note> notes;

  NotesAdded({required this.notes});
}
