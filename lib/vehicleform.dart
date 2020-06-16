import 'dart:convert';
import 'dart:html';

import 'package:dart_toast/dart_toast.dart';
import 'package:mango_leads/bodies/vehicle.dart';
import 'package:mango_vin/lookupapi.dart';

class VehicleForm {
  SelectElement ddlYear;
  SelectElement ddlManufacturer;
  SelectElement ddlModel;
  SelectElement ddlTrim;
  NumberInputElement numMileage;
  NumberInputElement numPrice;
  SelectElement ddlCondition;
  TextAreaElement txtIssues;

  VehicleForm() {
    ddlYear = querySelector("#ddlYear");
    ddlManufacturer = querySelector("#ddlMake");
    ddlModel = querySelector("#ddlModel");
    ddlTrim = querySelector("#ddlTrim");
    numMileage = querySelector("#numMileage");
    numPrice = querySelector("#numPrice");
    ddlCondition = querySelector("#ddlCondition");
    txtIssues = querySelector("#txtIssues");

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

  String get year {
    return ddlYear.value;
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

  Vehicle get object {
    return new Vehicle(
        num.parse(year),
        manufacturer,
        makeCountry,
        model,
        trim,
        drive,
        transmission,
        body,
        enginePos,
        mileage,
        price,
        condition,
        issues);
  }
}
