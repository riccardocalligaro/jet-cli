import 'package:dio/dio.dart';

import 'request_remote_model.dart';

/// [RequestsRemoteDataSource]: Class that handles the remote calls for the requests feature
/// - `baseUrl/request` Sends the requests
class RequestsRemoteDatasource {
  final Dio client;

  RequestsRemoteDatasource({
    required this.client,
  });

  Future<RequestRemoteModel> sendRequest({
    required RequestDomainModel request,
  }) async {
    final response = await client.get('/request');

    return RequestRemoteModel.fromJson(response.data);
  }
}
