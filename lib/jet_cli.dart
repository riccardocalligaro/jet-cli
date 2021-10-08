class JetCLI {
  static final JetCLI _singleton = JetCLI._internal();
  JetCLI._internal();
  static JetCLI get instance => _singleton;

  int currentLevel = 0;
}

JetCLI get cli => JetCLI.instance;
