import 'dart:html';

import 'package:mango_artifact/uploadapi.dart';
import 'package:mango_ui/keys.dart';

class PhotosForm {
  FileUploadInputElement uplFront;
  FileUploadInputElement uplLeft;
  FileUploadInputElement uplRight;
  FileUploadInputElement uplRear;
  FileUploadInputElement uplInterior;
  FileUploadInputElement uplEngine;

  PhotosForm() {
    uplFront = querySelector("#uplFront");
    uplFront.onChange.listen(uploadFile);

    uplLeft = querySelector("#uplLeft");
    uplLeft.onChange.listen(uploadFile);

    uplRight = querySelector("#uplRight");
    uplRight.onChange.listen(uploadFile);

    uplRear = querySelector("#uplRear");
    uplRear.onChange.listen(uploadFile);

    uplInterior = querySelector("#uplInterior");
    uplInterior.onChange.listen(uploadFile);

    uplEngine = querySelector("#uplEngine");
    uplEngine.onChange.listen(uploadFile);
  }

  Key get frontKey {
    return new Key(uplFront.dataset['id']);
  }

  Key get leftKey {
    return new Key(uplLeft.dataset['id']);
  }

  Key get rightKey {
    return new Key(uplRight.dataset['id']);
  }

  Key get rearKey {
    return new Key(uplRear.dataset['id']);
  }

  Key get interiorKey {
    return new Key(uplInterior.dataset['id']);
  }

  Key get engineKey {
    return new Key(uplEngine.dataset['id']);
  }
}
