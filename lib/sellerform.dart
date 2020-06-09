import 'dart:html';

import 'package:mango_leads/bodies/seller.dart';

class SellerForm {
  TextInputElement txtName;
  TelephoneInputElement txtContact;
  EmailInputElement txtEmail;
  SelectElement ddlProvince;
  TextInputElement txtTown;
  TextInputElement txtSuburb;

  SellerForm() {
    txtName = querySelector("#txtName");
    txtContact = querySelector("#txtContactNo");
    txtEmail = querySelector("#txtEmail");
    ddlProvince = querySelector("#ddlProvince");
    txtTown = querySelector("#txtTown");
    txtSuburb = querySelector("#txtSuburb");
  }

  String get name {
    return txtName.text;
  }

  String get contactNo {
    return txtContact.text;
  }

  String get email {
    return txtEmail.text;
  }

  String get province {
    return ddlProvince.value;
  }

  String get town {
    return txtTown.text;
  }

  String get suburb {
    return txtSuburb.text;
  }

  Seller get object {
    return new Seller(name, contactNo, email, province, town, suburb);
  }
}
