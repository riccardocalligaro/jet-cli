importSameDirectory(String filename) => "import '$filename';";
importPackage(String filename, String packageName) =>
    "import 'package:$packageName/feature/$filename';";

manyImports(List<String> imports) => imports.join('\n');

importFilenames(List<String?> filenames, String packageName) => filenames
    .map(
        (e) => (e != null && e.isNotEmpty) ? importPackage(e, packageName) : '')
    .join('\n');
