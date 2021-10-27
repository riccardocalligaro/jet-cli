import 'dart:convert';

import 'package:jet_cli/src/variables/feature_variables.dart';

class BlocVariables {
  String? eventsFilename;
  String? statesFilename;
  String? blocFilename;
  String? blocImports;

  BlocVariables({
    this.eventsFilename,
    this.statesFilename,
    this.blocFilename,
    this.blocImports,
  });

  BlocVariables copyWith({
    String? eventsFilename,
    String? statesFilename,
    String? blocFilename,
    String? blocImports,
  }) {
    return BlocVariables(
      eventsFilename: eventsFilename ?? this.eventsFilename,
      statesFilename: statesFilename ?? this.statesFilename,
      blocFilename: blocFilename ?? this.blocFilename,
      blocImports: blocImports ?? this.blocImports,
    );
  }

  Map<String, dynamic> toMap(FeatureVariables featureVariables) {
    return {
      'eventsFilename': eventsFilename,
      'statesFilename': statesFilename,
      'blocFilename': blocFilename,
      'blocImports': blocImports,
    }..addAll(featureVariables.toMap());
  }

  factory BlocVariables.fromMap(Map<String, dynamic> map) {
    return BlocVariables(
      eventsFilename: map['eventsFilename'],
      statesFilename: map['statesFilename'],
      blocFilename: map['blocFilename'],
      blocImports: map['blocImports'],
    );
  }

  factory BlocVariables.fromJson(String source) =>
      BlocVariables.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BlocVariables(eventsFilename: $eventsFilename, statesFilename: $statesFilename, blocFilename: $blocFilename, blocImports: $blocImports)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BlocVariables &&
        other.eventsFilename == eventsFilename &&
        other.statesFilename == statesFilename &&
        other.blocFilename == blocFilename &&
        other.blocImports == blocImports;
  }

  @override
  int get hashCode {
    return eventsFilename.hashCode ^
        statesFilename.hashCode ^
        blocFilename.hashCode ^
        blocImports.hashCode;
  }
}
