import 'package:http/http.dart' as http;
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;

import 'package:untitled2/youthcenter/policyCodes.dart';

void requestPolicyCode() async {
  for (int a = 0; a < 10000; a++) {
    try {
      List<String?> requestedCodes = await getPolicyCodes(a + 100);

      for (String? code in requestedCodes) {
        print('"$code",');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

Future<List<String?>> getPolicyCodes(int count) async {
  List<String?> policyCodes = [];

  Document document = await reqDOM('https://www.youthcenter.go.kr/youngPlcyUnif/youngPlcyUnifList.do?srchTermMm=6&pageUnit=${count}');

  List<Element> elements = document.querySelectorAll('.checkbox input');
  policyCodes = elements.map((e) => e.attributes['value']).toList();

  return policyCodes;
}

Future<Document> reqDOM(String address) async {
  Uri url = Uri.parse(address);
  http.Response response = await http.get(url);
  Document document = parser.parse(response.body);

  return document;
}

void requestPolicyDetail() async {
  for (String code in policyCodes) {
    print('{');

    print('"정책번호": "$code",');

    try {
      Document document = await reqDOM('https://www.youthcenter.go.kr/youngPlcyUnif/youngPlcyUnifDtl.do?bizId=$code');

      Element? eleTitle = document.querySelector('.doc_tit02 div');
      String title = eleTitle == null ? '' : eleTitle.text.trim();

      print('"정책명": "$title",');

      Element? eleDescription = document.querySelector('.view-txt');
      List<Element> tableRows = eleDescription == null ? [] : eleDescription.querySelectorAll('li');

      for (int a = 0; a < tableRows.length; a++) {
        Element? eleKey = tableRows[a].querySelector('.list_tit');
        String key = eleKey == null ? '' : eleKey.text.trim();

        Element? eleValue = tableRows[a].querySelector('.list_cont');
        String value = eleValue == null ? '' : eleValue.text.trim();

        value = value.replaceAll('"', '').replaceAll('\n', '\\n');
        print('"$key": "$value"');

        if (a < tableRows.length - 1) {
          print(',');
        }
      }
    } catch (e) {
      print(e.toString());
    }

    print('},');

    await Future.delayed(Duration(milliseconds: 1100));
  }
}
