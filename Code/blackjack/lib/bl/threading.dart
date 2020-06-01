import 'dart:isolate';

class Thread {
  List<Function> _functions = List<Function>();
  Future<Isolate> isolate;

  void addFunction(function) {
    _functions.add(function);
  }

  void runFunctions(SendPort sendPort) {
    for (var function in _functions) {
      function();
      sendPort.send("Excecuted " + function.toString());
    }
  }

  void start() {
    ReceivePort receivePort = ReceivePort();
    isolate = Isolate.spawn(runFunctions, receivePort.sendPort);
    receivePort.listen((message) {
      print(message);
    });
  }

  void stop() {
    if (isolate != null) {
      isolate.then((value) => value.kill());
      isolate = null;
    }
  }
}
