import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sms_sender/data/network/base_url.dart';

class Get {
  Future getData(String route) async {
    final response = await http.get(
      Uri.parse('${BaseUrl.url}$route'),
    );
    return jsonDecode(utf8.decode(response.bodyBytes));
  }
}
