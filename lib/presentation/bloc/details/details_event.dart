part of 'details_bloc.dart';

sealed class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

final class LoadShowDetails extends DetailsEvent {
  final Show show;

  const LoadShowDetails(this.show);

  @override
  List<Object> get props => [show];
}
