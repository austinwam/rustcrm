import 'dart:convert';

import 'package:frontend/util/util.dart';
import 'package:http/http.dart' as http;

class Apirequest {
  void getwithtoken(url) async {
    var url = Uri.https('example.com', 'whatsit/create');
    var response =
        await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
  }

  void get(params) {}
  void postwithtoken(params) {}
  void putwithtoken(params) {}

  Future<void> refresh(serverurl, data) async {
    var url = Uri.https(serverurl);
    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Some token"
    };
    var response = await http.post(url, body: data, headers: headers);
    if (response.statusCode <= 250) {
      var jresp = json.decode(response.body);
      var message = jresp["message"];
      var data = jresp["data"];
      Notify().showmessage(message, const Duration(seconds: 3), 1);
      return data;
    } else if (response.statusCode >= 400) {
      var jresp = json.decode(response.body);
      var message = jresp["message"];
      Notify().showmessage(message, const Duration(seconds: 3), 1);
    } else {
      var message = "an error occorred";
      Notify().showmessage(message, const Duration(seconds: 3), 1);
    }
  }
}
