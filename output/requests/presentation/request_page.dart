import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todos_app/feature/requests/presentation/bloc/requests_bloc.dart';
import 'package:todos_app/feature/requests/presentation/request_loaded.dart';

class RequestPage extends StatefulWidget {
  RequestPage({Key? key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<RequestBloc>(context).add(SendRequest());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestBloc, RequestState>(
      builder: (context, state) {
        if (state is RequestLoading) {
          return Text('Loading');
        } else if (state is RequestFailure) {
          return Text('Failure');
        } else if (state is RequestLoadSuccess) {
          return RequestLoaded(
            request: state.request,
          );
        }

        return Text('Error: $state');
      },
    );
  }
}
