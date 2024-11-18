import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quadb_tv/data/models/season_model.dart';

import '../../core/constants/api_constants.dart';
import '../../core/errors/failures.dart';
import '../models/cast_model.dart';
import '../models/episode_model.dart';
import '../models/show_model.dart';

abstract interface class ShowRemoteDataSource {
  Future<List<ShowModel>> getAllShows();
  Future<List<ShowModel>> searchShows(String query);
  Future<List<EpisodeModel>> getShowEpisodes(int showId,
      {bool includeSpecials = false});
  Future<List<SeasonModel>> getShowSeasons(int showId);
  Future<List<EpisodeModel>> getSeasonEpisodes(int seasonId);
  Future<List<CastModel>> getShowCast(int showId);
}

class ShowRemoteDataSourceImpl implements ShowRemoteDataSource {
  final http.Client client;

  ShowRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ShowModel>> getAllShows() async {
    try {
      final response = await client.get(
        Uri.parse(ApiConstants.getAllShowsUrl()),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((showJson) => ShowModel.fromJson(showJson))
            .toList();
      } else {
        throw ServerFailure(
          message: 'Failed to fetch shows: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<ShowModel>> searchShows(String query) async {
    try {
      final response = await client.get(
        Uri.parse(ApiConstants.getSearchUrl(query)),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((showJson) => ShowModel.fromJson(showJson))
            .toList();
      } else {
        throw ServerFailure(
          message: 'Failed to search shows: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<SeasonModel>> getShowSeasons(int showId) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConstants.baseUrl}/shows/$showId/seasons'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((season) => SeasonModel.fromJson(season)).toList();
      } else {
        throw ServerFailure(
          message: 'Failed to fetch seasons: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<EpisodeModel>> getShowEpisodes(
    int showId, {
    bool includeSpecials = false,
  }) async {
    try {
      final response = await client.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getShowEpisodes(showId, includeSpecials: includeSpecials)}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((episode) => EpisodeModel.fromJson(episode))
            .toList();
      } else {
        throw ServerFailure(
            message: 'Failed to fetch episodes: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<EpisodeModel>> getSeasonEpisodes(int seasonId) async {
    try {
      final response = await client.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getSeasonEpisodes(seasonId)}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((episode) => EpisodeModel.fromJson(episode))
            .toList();
      } else {
        throw ServerFailure(
            message: 'Failed to fetch season episodes: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<CastModel>> getShowCast(int showId) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getShowCast(showId)}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((cast) => CastModel.fromJson(cast)).toList();
      } else {
        throw ServerFailure(
            message: 'Failed to fetch cast: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}
