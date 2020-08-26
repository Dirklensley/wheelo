import 'dart:convert';
import 'dart:html';

import 'package:Wheelo/sellerform.dart';
import 'package:dart_toast/dart_toast.dart';
import 'package:mango_leads/api.dart';
import 'package:mango_leads/bodies/seller.dart';
import 'package:mango_leads/bodies/submission.dart';
import 'package:mango_ui/formstate.dart';
import 'package:mango_ui/keys.dart';

class SubmissionForm extends FormState {
  SellerForm frmSeller;
  HiddenInputElement hdnVehicleKey;

  SubmissionForm(String idElem, String submitBtn) : super(idElem, submitBtn) {
    frmSeller = new SellerForm();
    hdnVehicleKey = querySelector("#hdnVehicleKey");
    var submit = querySelector(submitBtn);
    submit.onClick.listen(onSend);
  }

  Seller get seller {
    return frmSeller.object;
  }

  Key get vehicleKey {
    return new Key(hdnVehicleKey.value);
  }

  void onSend(Event e) {
    if (isFormValid()) {
      disableSubmit(true);
      submitSend();
    }
  }

  submitSend() async {
    var data = new Submission(seller, vehicleKey);
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
