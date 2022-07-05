import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:untitled2/bokjiro/request/wlfare.dart';

Future<List<String>> getWlfareCode() async {
  List<String> wlfareCodes = [];

  Uri url = Uri.parse('https://www.bokjiro.go.kr/ssis-teu/TWAT52005M/twataa/wlfareInfo/selectWlfareInfo.do');
  Map<String, String> header = {'JSESSIONID': ''};
  Map<String, Map<String, String>> body = {
    "dmSearchParam": {"page": "1", "onlineYn": "", "searchTerm": "", "tabId": "1", "orderBy": "date", "bkjrLftmCycCd": "", "daesang": "", "period": "청년", "age": "", "region": "", "jjim": "", "subject": "", "favoriteKeyword": "Y", "sido": "", "gungu": "", "endYn": ""},
    "dmScr": {"curScrId": "teu/app/twat/twata/twataa/TWAT52005M", "befScrId": ""}
  };

  http.Response response = await http.post(url, headers: header, body: json.encode(body));

  print(response.body);
  print(response.statusCode);

  // Wlfare wlfare = Wlfare.fromJson(jsonDecode(response.body));
  // print(wlfare.dsServiceList0);
  // print(wlfare.dsServiceList1);
  // print(wlfare.dsServiceList2);
  // print(wlfare.dsServiceList3);

  return wlfareCodes;
}
