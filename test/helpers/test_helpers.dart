import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:quadb_tv/core/network/network_info.dart';
import 'package:quadb_tv/data/datasources/show_remote_datasource.dart';
import 'package:quadb_tv/domain/irepositories/show_repository.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockShowRemoteDataSource extends Mock implements ShowRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockShowRepository extends Mock implements ShowRepository {}
