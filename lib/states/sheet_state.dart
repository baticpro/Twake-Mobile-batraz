part of '../blocs/sheet_bloc.dart';

abstract class SheetState extends Equatable {
  const SheetState();
}

class SheetInitial extends SheetState {
  final SheetFlow flow;

  SheetInitial({@required this.flow});

  @override
  List<Object> get props => [flow];
}

class SheetShouldOpen extends SheetState {
  SheetShouldOpen();
  @override
  List<Object> get props => [];
}

class SheetShouldClose extends SheetState {
  SheetShouldClose();
  @override
  List<Object> get props => [];
}

class SheetShouldClear extends SheetState {
  SheetShouldClear();
  @override
  List<Object> get props => [];
}