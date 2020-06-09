import 'dart:convert';
import 'dart:html';

import 'package:Wheelo/query.dart';
import 'package:dart_toast/dart_toast.dart';
import 'package:mango_leads/bodies/vehicle.dart';

class VehicleForm {
  SelectElement ddlYear;
  SelectElement ddlMake;
  SelectElement ddlModel;
  SelectElement ddlTrim;
  NumberInputElement numMileage;
  NumberInputElement numPrice;
  SelectElement ddlCondition;
  TextAreaElement txtIssues;

  VehicleForm() {
    ddlYear = querySelector("#ddlYear");
    ddlMake = querySelector("#ddlMake");
    ddlModel = querySelector("#ddlModel");
    ddlTrim = querySelector("#ddlTrim");
    numMileage = querySelector("#numMileage");
    numPrice = querySelector("#numPrice");
    ddlCondition = querySelector("#ddlCondition");
    txtIssues = querySelector("#txtIssues");

    ddlYear.onChange.listen(getMakes);
    ddlMake.onChange.listen(getModels);
    ddlModel.onChange.listen(getTrims);
  }

  Future<void> getMakes(Event e) async {
    var req = await fetchCarMakes(year);
    var content = jsonDecode(req.response);

    if (req.status == 200) {
      print(content);
    } else {
      new Toast.error(
          title: "Error!",
          message: content['Error'],
          position: ToastPos.bottomLeft);
    }
  }

  void getModels(Event e) {}

  void getTrims(Event e) {}

  num get year {
    return num.parse(ddlYear.value);
  }

  String get make {
    return ddlMake.value;
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
    return new Vehicle(year, make, makeCountry, model, trim, drive,
        transmission, body, enginePos, mileage, price, condition, issues);
  }
}
