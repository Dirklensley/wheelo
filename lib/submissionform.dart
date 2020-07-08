import 'dart:convert';
import 'dart:html';

import 'package:Wheelo/photosform.dart';
import 'package:Wheelo/sellerform.dart';
import 'package:Wheelo/vehicleform.dart';
import 'package:dart_toast/dart_toast.dart';
import 'package:mango_leads/api.dart';
import 'package:mango_leads/bodies/photos.dart';
import 'package:mango_leads/bodies/seller.dart';
import 'package:mango_leads/bodies/submission.dart';
import 'package:mango_leads/bodies/vehicle.dart';
import 'package:mango_ui/formstate.dart';

class SubmissionForm extends FormState {
  SellerForm frmSeller;
  VehicleForm frmVehicle;
  PhotosForm frmPhotos;

  SubmissionForm(String idElem, String submitBtn) : super(idElem, submitBtn) {
    frmSeller = new SellerForm();
    frmVehicle = new VehicleForm();
    frmPhotos = new PhotosForm();

    var submit = querySelector(submitBtn);
    submit.onClick.listen(onSend);
  }

  Seller get seller {
    return frmSeller.object;
  }

  Vehicle get vehicle {
    return frmVehicle.object;
  }

  Photos get photos {
    return frmPhotos.object;
  }

  void onSend(Event e) {
    if (isFormValid()) {
      disableSubmit(true);
      submitSend();
    }
  }

  submitSend() async {
    var data = new Submission(seller, vehicle, photos);
    var req = await sendSubmission(data);
    var content = jsonDecode(req.response);

    if (req.status == 200) {
      new Toast.success(
          title: "Success!",
          message: content['Data'],
          position: ToastPos.bottomLeft);
    } else {
      new Toast.error(
          title: "Error!",
          message: content['Error'],
          position: ToastPos.bottomLeft);
    }
  }
}
