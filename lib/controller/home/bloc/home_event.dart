// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class AddNote extends HomeEvent {
  final Note note;

  AddNote({required this.note});
}

class RemoveNote extends HomeEvent {
  final int index;
  RemoveNote({
    required this.index,
  });
}
