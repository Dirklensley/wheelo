import 'dart:convert';
import 'dart:html';

import 'package:dart_toast/dart_toast.dart';
import 'package:mango_vin/lookupapi.dart';
import 'package:mango_vehicle/bodies/series.dart';

class SeriesForm {
  SelectElement ddlModel;
  SelectElement ddlManufacturer;
  SelectElement ddlAssemblyPlant;
  final String year;

  SeriesForm(this.year) {
    ddlModel = querySelector("ddlModel");
    ddlManufacturer = querySelector("ddlManufacturer");

    ddlModel.onChange.listen(getModels);
    ddlManufacturer.onChange.listen(getManufacturers);
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

  String get manufacturer {
    return ddlManufacturer.value;
  }

  String get model {
    return ddlModel.value;
  }

  String get assemblyplant {
    return "";
  }

  Series get object {
    return new Series(
      model,
      manufacturer,
      assemblyplant,
    );
  }
}
