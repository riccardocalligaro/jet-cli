import 'package:dartz/dartz.dart';
import 'package:todos_app/feature/requests/domain/model/request_domain_model.dart';
import 'package:todos_app/feature/requests/data/remote/request_remote_model.dart';
import 'package:todos_app/feature/requests/data/remote/requests_remote_datasource.dart';
import 'package:todos_app/feature/requests/domain/repository/requests_repository.dart';

class RequestsRepositoryImpl implements RequestsRepository {
  final RequestsRemoteDatasource requestsRemoteDatasource;

  RequestsRepositoryImpl({
    required this.requestsRemoteDatasource,
  });

  Future<Either<Failure, RequestDomainModel>> sendRequest({
    required RequestDomainModel request,
  }) async {
    try {
      final remoteRequest =
          await requestRemoteDatasource.getRequest(request: request);

      final domainRequest = remoteRequest
          .map((r) => RequestDomainModel.fromRemoteModel(r))
          .toList();

      return Right(domainRequest);
    } catch (e, s) {
      return Left(handleError(e, s));
    }
  }
}
