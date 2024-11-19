import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadb_tv/domain/usecases/get_seasons.dart';
import 'package:quadb_tv/domain/usecases/get_show_cast.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/cast.dart';
import '../../../domain/entities/season.dart';
import '../../../domain/entities/show.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetShowCast getShowCast;
  final GetShowSeasons getShowSeasons;

  DetailsBloc({
    required this.getShowCast,
    required this.getShowSeasons,
  }) : super(DetailsInitial()) {
    on<LoadShowDetails>(_onLoadShowDetails);
  }

  void _onLoadShowDetails(
    LoadShowDetails event,
    Emitter<DetailsState> emit,
  ) async {
    emit(const DetailsLoading());

    final castResults = await getShowCast(
      ShowCastParams(showId: event.show.id),
    );

    await castResults.fold(
      (failure) {
        emit(DetailsFailure(failure));
      },
      (cast) async {
        final seasonResults = await getShowSeasons(
          ShowSeasonsParams(showId: event.show.id),
        );

        seasonResults.fold(
          (failure) {
            emit(DetailsFailure(failure));
          },
          (seasons) {
            emit(DetailsSuccess(
              show: event.show,
              cast: cast,
              seasons: seasons,
            ));
          },
        );
      },
    );
  }
}
