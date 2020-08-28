import 'dart:html';

import 'package:mango_vehicle/bodies/engine.dart';

class EngineForm {
  TextInputElement txtCode;
  TextInputElement txtSerialNo;
  NumberInputElement numOutput;

  String get code {
    return txtCode.text;
  }

  String get serialNo {
    return txtSerialNo.text;
  }

  num get output {
    return numOutput.valueAsNumber;
  }

  Engine get object {
    return new Engine(code, serialNo, output);
  }
}
