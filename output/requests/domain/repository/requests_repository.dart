import 'package:dartz/dartz.dart';

import 'package:todos_app/feature/requests/domain/model/request_domain_model.dart';

mixin RequestsRepository {
  Future<Either<Failure, RequestDomainModel>> sendRequest({
    required RequestDomainModel request,
  });
}
