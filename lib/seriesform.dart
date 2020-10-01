import 'dart:convert';
import 'dart:html';

import 'package:dart_toast/dart_toast.dart';
import 'package:mango_vehicle/bodies/series.dart';
import 'package:mango_vehicle/lookupapi.dart';

class SeriesForm {
  SelectElement ddlYear;
  SelectElement ddlTrim;
  SelectElement ddlModel;
  SelectElement ddlManufacturer;
  TextInputElement txtAssemblyPlant;

  SeriesForm() {
    ddlYear = querySelector("#ddlYear");
    ddlTrim = querySelector("#ddlTrim");
    ddlManufacturer = querySelector("#ddlMake");
    ddlModel = querySelector("#ddlModel");

    ddlYear.onChange.listen(getManufacturers);
    ddlManufacturer.onChange.listen(getModels);
    ddlModel.onChange.listen(getTrims);
  }

  Future<void> getManufacturers(Event e) async {
    var req = await fetchManufacturers(year);

    var content = jsonDecode(req.response);
    print("Manufacturer: ${req.status}");
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

  String get month {
    return "";
  }

  String get trim {
    return ddlTrim.value;
  }

  String get manufacturer {
    return ddlManufacturer.value;
  }

  String get model {
    return ddlModel.value;
  }

  String get assemblyPlant {
    return "unknown";
  }

  Series get object {
    return new Series(num.parse(year), num.parse(month), manufacturer, model,
        trim, assemblyPlant);
  }
}
