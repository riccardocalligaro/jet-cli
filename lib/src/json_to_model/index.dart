import 'dart:convert';

import 'package:jet_cli/src/json_to_model/core/json_model.dart';
import 'package:jet_cli/src/json_to_model/core/model_template.dart';

import 'models/json_options.dart';

class JsonModelGenerator {
  static String run(JSONOptions options) {
    final jsonMap = json.decode(options.content) as Map<String, dynamic>;

    final jsonModel = JsonModel.fromMap(
      options.name,
      jsonMap,
      relativePath: null,
      packageName: '',
      indexPath: '',
      remoteModelName: options.remoteModel,
    );

    final model = modelFromJsonModel(jsonModel);
    return model;
  }
}
