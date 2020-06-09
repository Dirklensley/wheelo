import 'dart:html';

import 'package:Wheelo/contactform.dart';
import 'package:Wheelo/submissionform.dart';

void main() {
  new ContactForm("#frmContact", "#btnContactSubmit");
  new SubmissionForm("#frmSubmission", "#btnSubmissionSubmit");
}
