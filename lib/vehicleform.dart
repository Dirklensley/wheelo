import 'dart:html';

import 'package:Wheelo/engineform.dart';
import 'package:Wheelo/gearboxform.dart';
import 'package:Wheelo/seriesform.dart';
import 'package:mango_ui/formstate.dart';
import 'package:mango_ui/keys.dart';
import 'package:mango_vehicle/bodies/engine.dart';
import 'package:mango_vehicle/bodies/gearbox.dart';
import 'package:mango_vehicle/bodies/series.dart';
import 'package:mango_vehicle/bodies/vehicle.dart';

class VehicleForm extends FormState {
  HiddenInputElement hdnVinKey;
  TextInputElement txtVin;

  NumberInputElement numMileage;
  NumberInputElement numPrice;
  SelectElement ddlCondition;
  TextAreaElement txtIssues;
  CheckboxInputElement chkService;
  CheckboxInputElement chkSpare;
  SelectElement ddlBodyType;
  SelectElement ddlDoors;
  SeriesForm frmSeries;
  EngineForm frmEngine;
  GearboxForm frmGearbox;
  TextInputElement txtColour;
  UListElement liExtra;

  VehicleForm(String idElem, String submitBtn) : super(idElem, submitBtn) {
    numMileage = querySelector("#numMileage");
    numPrice = querySelector("#numPrice");
    ddlCondition = querySelector("#ddlCondition");
    txtIssues = querySelector("#txtIssues");
    chkService = querySelector("#chkService");
    chkSpare = querySelector("#chkSpare");
    ddlBodyType = querySelector("#ddlBodyType");
    ddlDoors = querySelector("#ddlDoors");
    txtColour = querySelector("#txtColour");

    frmSeries = new SeriesForm();
    frmEngine = new EngineForm();
    frmGearbox = new GearboxForm();
  }

  Key get vinKey {
    return new Key(hdnVinKey.value);
  }

  String get vin {
    return txtVin.text;
  }

  Series get series {
    return frmSeries.object;
  }

  String get makeCountry {
    return "Unknown";
  }

  String get drive {
    return "RHD";
  }

  String get transmission {
    return "Unknown";
  }

  String get body {
    return "Unknown";
  }

  String get enginePos {
    return "Unknown";
  }

  num get mileage {
    return numMileage.valueAsNumber;
  }

  double get price {
    return double.parse(numPrice.value);
  }

  String get condition {
    return ddlCondition.value;
  }

  String get issues {
    return txtIssues.text;
  }

  String get colour {
    return txtColour.text;
  }

  bool get spare {
    return chkSpare.checked;
  }

  bool get service {
    return chkService.checked;
  }

  String get bodytype {
    return ddlBodyType.value;
  }

  String get doors {
    return ddlDoors.value;
  }

  String get paintNo {
    return "unknown";
  }

  Engine get engine {
    return frmEngine.object;
  }

  Gearbox get gearbox {
    return frmGearbox.object;
  }

  List<String> get extra {
    return liExtra.children.map((e) => e.text);
  }

  Vehicle get object {
    return new Vehicle(
        vinKey,
        vin,
        series,
        colour,
        paintNo,
        engine,
        gearbox,
        bodytype,
        num.parse(doors),
        extra,
        spare,
        service,
        condition,
        issues,
        mileage);
  }
}
