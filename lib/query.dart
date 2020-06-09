
import 'dart:html';

import 'package:mango_ui/requester.dart';

Future<HttpRequest> fetchCarMakes(num year) {
  return invokeService("GET", "https://www.carqueryapi.com/api/0.3/?&cmd=getMakes&year=${year}", []);
}

