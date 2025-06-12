part of 'example_cubit.dart';

class ExampleCubitState extends Equatable {
  // Context
  final BuildContext? context;

  const ExampleCubitState({this.context});

  @override
  List<Object?> get props => [context];

  ExampleCubitState copyWith({BuildContext? context}) {
    return ExampleCubitState(
      context: context ?? this.context,
    );
  }
}
