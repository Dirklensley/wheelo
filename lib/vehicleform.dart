import 'dart:convert';
import 'dart:html';

import 'package:dart_toast/dart_toast.dart';
import 'package:mango_ui/keys.dart';
import 'package:mango_vehicle/bodies/vehicle.dart';
import 'package:mango_vin/lookupapi.dart';

class VehicleForm {
  HiddenInputElement hdnVinKey;
  TextInputElement txtVin;
  SelectElement ddlYear;
  SelectElement ddlManufacturer;
  SelectElement ddlModel;
  SelectElement ddlTrim;
  NumberInputElement numMileage;
  NumberInputElement numPrice;
  SelectElement ddlCondition;
  TextAreaElement txtIssues;
  CheckboxInputElement chkService;
  CheckboxInputElement chkSpare;
  SelectElement ddlBodyType;
  SelectElement ddlDoors;
  NumberInputElement numPaintNo;
  TextInputElement txtColour;
  TextInputElement txtEngine;
  TextInputElement txtGearbox;
  TextInputElement txtExtra;

  VehicleForm() {
    ddlYear = querySelector("#ddlYear");
    ddlManufacturer = querySelector("#ddlMake");
    ddlModel = querySelector("#ddlModel");
    ddlTrim = querySelector("#ddlTrim");
    numMileage = querySelector("#numMileage");
    numPrice = querySelector("#numPrice");
    ddlCondition = querySelector("#ddlCondition");
    txtIssues = querySelector("#txtIssues");
    chkService = querySelector("#chkService");
    chkSpare = querySelector("#chkSpare");
    ddlBodyType = querySelector("#ddlBodyType");
    ddlDoors = querySelector("#ddlDoors");
    txtColour = querySelector("#txtColour");
    txtEngine = querySelector("#txtEngine");
    txtExtra = querySelector("#txtExtra");
    txtGearbox = querySelector("#txtGearbox");
    numPaintNo = querySelector("numPaintNo");
    

    ddlYear.onChange.listen(getManufacturers);
    ddlManufacturer.onChange.listen(getModels);
    ddlModel.onChange.listen(getTrims);
  }

  Future<void> getManufacturers(Event e) async {
    var req = await fetchManufacturers(year);

    var content = jsonDecode(req.response);

    if (req.status == 200) {
      if (ddlManufacturer.hasChildNodes()) {
        ddlManufacturer.children.clear();
      }

      for (final name in content) {
        ddlManufacturer.children
            .add(new OptionElement(data: name, value: name));
      }
    } else {
      new Toast.error(
          title: "Error!",
          message: content['Error'],
          position: ToastPos.bottomLeft);
    }
  }

  void getModels(Event e) async {
    var req = await fetchModels(year, manufacturer);

    var content = jsonDecode(req.response);

    if (req.status == 200) {
      if (ddlModel.hasChildNodes()) {
        ddlModel.children.clear();
      }

      for (final name in content) {
        ddlModel.children.add(new OptionElement(data: name, value: name));
      }
    } else {
      new Toast.error(
          title: "Error!",
          message: content['Error'],
          position: ToastPos.bottomLeft);
    }
  }

  void getTrims(Event e) async {
    var req = await fetchTrims(year, manufacturer, model);

    var content = jsonDecode(req.response);

    if (req.status == 200) {
      if (ddlTrim.hasChildNodes()) {
        ddlTrim.children.clear();
      }

      for (final name in content) {
        ddlTrim.children.add(new OptionElement(data: name, value: name));
      }
    } else {
      new Toast.error(
          title: "Error!",
          message: content['Error'],
          position: ToastPos.bottomLeft);
    }
  }

  Key get vinKey {
    return new Key(hdnVinKey.value);
  }

  String get vin {
    return txtVin.text;
  }

  String get year {
    return ddlYear.value;
  }

  String get month {
    return "";
  }

  String get manufacturer {
    return ddlManufacturer.value;
  }

  String get makeCountry {
    return "Unknown";
  }

  String get model {
    return ddlModel.value;
  }

  String get trim {
    return ddlTrim.value;
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

  num get condition {
    return num.parse(ddlCondition.value);
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

  num get doors {
    return num.parse (ddlDoors.value);
  }

  num get paintNo {
    return num.parse(numPaintNo.value);
  }

  String get engine {
    return txtEngine.value;
  }

  String get gearbox {
    return txtGearbox.value;
  }

  String get extra {
    return txtExtra.value;
  }

  Vehicle get object {
    return new Vehicle(
      vinKey,
      vin,
      series,
      colour,
      paintNo,
      num.parse(month),
      num.parse(year),
      engine,
      gearbox,
      bodytype,
      doors,
      service,
      spare,
      trim,
      extra,
    );
    /*,
        spare,
        service,
        bodytype,
        doors);*/
  }
}
