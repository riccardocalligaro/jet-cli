import 'package:flutter/material.dart';

import 'package:todos_app/feature/requests/domain/model/request_domain_model.dart';

class RequestLoaded extends StatelessWidget {
  final RequestDomainModel request;

  const RequestLoaded({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(request.toString());
  }
}
