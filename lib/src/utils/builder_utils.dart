importSameDirectory(String filename) => "import '$filename';";
importPackage(String filename) => "import 'package$filename';";

manyImports(List<String> imports) => imports.join('\n');
