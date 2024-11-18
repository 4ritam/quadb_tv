class ApiConstants {
  static const String baseUrl = 'https://api.tvmaze.com';

  // Helper method to create search URL
  static String getSearchUrl(String query) => '$baseUrl/search/shows?q=$query';

  // Helper method to get all shows URL
  static String getAllShowsUrl() => getSearchUrl('all');

  // Show specific endpoints
  static String getShowEpisodes(int showId, {bool includeSpecials = false}) =>
      '/shows/$showId/episodes${includeSpecials ? '?specials=1' : ''}';

  static String getShowSeasons(int showId) => '/shows/$showId/seasons';

  static String getSeasonEpisodes(int seasonId) =>
      '/seasons/$seasonId/episodes';

  static String getShowCast(int showId) => '/shows/$showId/cast';
}
