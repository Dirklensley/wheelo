import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'dart:svg';

import 'package:dart_toast/dart_toast.dart';
import 'package:mango_leads/bodies/vehicle.dart';
import 'package:mango_vin/lookupapi.dart';

class AdditionalForm {
  NumberInputElement numMileage;
  NumberInputElement numPrice;
  SelectElement ddlCondition;
  TextAreaElement txtIssues;
  CheckboxInputElement chkService;
  CheckboxInputElement chkSpare;


  AdditionalForm() {
    numMileage = querySelector("#numMileage");
    numPrice = querySelector("#numPrice");
    ddlCondition = querySelector("#ddlCondition");
    txtIssues = querySelector("#txtIssues");
    chkService = querySelector("#chkService");
    chkSpare = querySelector("#chkSpare");
  }

  int get mileage {
    return numMileage.valueAsNumber;
  }

  double get price {
    return numPrice.valueAsNumber;
  }

  String get condition {
    return ddlCondition.value;
  }

  String get issues {
    return txtIssues.value;
  }

  bool get servicehistory {
    return chkService.checked;
  }

  bool get sparekey {
    return chkSpare.checked;
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
