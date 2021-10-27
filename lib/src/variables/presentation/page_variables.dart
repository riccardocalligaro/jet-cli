import 'dart:convert';

import 'package:jet_cli/src/variables/feature_variables.dart';

class PageVariables {
  String? pageFilename;
  String? pageLoadedFilename;
  String? loadedImports;
  String? imports;

  PageVariables({
    this.pageFilename,
    this.pageLoadedFilename,
    this.loadedImports,
    this.imports,
  });

  PageVariables copyWith({
    String? pageFilename,
    String? pageLoadedFilename,
    String? loadedImports,
    String? imports,
  }) {
    return PageVariables(
      pageFilename: pageFilename ?? this.pageFilename,
      pageLoadedFilename: pageLoadedFilename ?? this.pageLoadedFilename,
      loadedImports: loadedImports ?? this.loadedImports,
      imports: imports ?? this.imports,
    );
  }

  Map<String, dynamic> toMap(FeatureVariables featureVariables) {
    return {
      'pageFilename': pageFilename,
      'pageLoadedFilename': pageLoadedFilename,
      'loadedImports': loadedImports,
      'imports': imports,
    }..addAll(featureVariables.toMap());
  }

  factory PageVariables.fromMap(Map<String, dynamic> map) {
    return PageVariables(
      pageFilename: map['pageFilename'] != null ? map['pageFilename'] : null,
      pageLoadedFilename:
          map['pageLoadedFilename'] != null ? map['pageLoadedFilename'] : null,
      loadedImports: map['loadedImports'] != null ? map['loadedImports'] : null,
      imports: map['imports'] != null ? map['imports'] : null,
    );
  }

  factory PageVariables.fromJson(String source) =>
      PageVariables.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PageVariables(pageFilename: $pageFilename, pageLoadedFilename: $pageLoadedFilename, loadedImports: $loadedImports, imports: $imports)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PageVariables &&
        other.pageFilename == pageFilename &&
        other.pageLoadedFilename == pageLoadedFilename &&
        other.loadedImports == loadedImports &&
        other.imports == imports;
  }

  @override
  int get hashCode {
    return pageFilename.hashCode ^
        pageLoadedFilename.hashCode ^
        loadedImports.hashCode ^
        imports.hashCode;
  }
}
