import 'package:jinja/jinja.dart';
import 'package:jinja/loaders.dart';
import 'package:universal_io/io.dart';

class JetRenderer {
  static final JetRenderer _singleton = JetRenderer._internal();
  JetRenderer._internal();
  static JetRenderer get instance => _singleton;

  Environment env = Environment(
    globals: <String, Object?>{
      'now': () {
        var dt = DateTime.now().toLocal();
        var hour = dt.hour.toString().padLeft(2, '0');
        var minute = dt.minute.toString().padLeft(2, '0');
        return '$hour:$minute';
      },
    },
    autoReload: true,
    loader: FileSystemLoader(
        path: Platform.script.resolve('templates').toFilePath()),
    leftStripBlocks: true,
    trimBlocks: true,
  );
}

Environment get env => JetRenderer.instance.env;
JetRenderer get renderer => JetRenderer.instance;
