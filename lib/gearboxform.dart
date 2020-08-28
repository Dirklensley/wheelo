import 'dart:html';

import 'package:mango_vehicle/bodies/gearbox.dart';

class GearboxForm {
  TextInputElement txtCode;
  TextInputElement txtSerialNo;
  NumberInputElement numGears;
  SelectElement ddlBody;

  String get code {
    return txtCode.text;
  }

  String get serialNo {
    return txtSerialNo.text;
  }

  num get gears {
    return numGears.valueAsNumber;
  }

  String get type {
    return ddlBody.value;
  }

  Gearbox get object {
    return new Gearbox(code, serialNo, gears, type);
  }
}
