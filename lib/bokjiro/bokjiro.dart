import 'package:http/http.dart' as http;
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;

import 'package:untitled2/bokjiro/wlfareCodes.dart';

void requestWlfareDetail() async {
  for(String address in wlfareCodes) {
    Uri url = Uri.parse('https://www.bokjiro.go.kr/ssis-teu/twataa/wlfareInfo/moveTWAT52011M.do?wlfareInfoId=$address&wlfareInfoReldBztpCd=02');
    http.Response response = await http.get(url);
    Document document = parser.parse(response.body);

    print('{');
    print('"code": "$address",');

    Element? eleTitle = document.querySelector('.card-lg-tit .cl-text');
    String title = eleTitle == null ? '' : eleTitle.text;
    print('"title":"$title",');

    Element? eleSubTitle = document.querySelector('.card-subtit > div > div');
    String subTitle = eleSubTitle == null ? '' : eleSubTitle.text;
    print('"sub_title":"$subTitle"');

    List<Element> eleTags = document.querySelectorAll('.badge .cl-text');
    List<String> tags = eleTags.map((e) => e.text).toList();
    print('"tags":[');

    for (int a = 0; a < tags.length; a++) {
      print('"${tags[a]}"');

      if (a < tags.length - 1) {
        print(',');
      }
    }

    List<Element> eleCircleTexts = document.querySelectorAll('.card-circle .cl-text');
    List<String> circleTexts = eleCircleTexts.map((e) => e.text).toList();

    for (int a = 0; a < circleTexts.length; a += 2) {
      print('"${circleTexts[a]}": "${circleTexts[a + 1]}"');

      if (a < circleTexts.length - 2) {
        print(',');
      }
    }

    print('"],"');

    print('},');

    await Future.delayed(Duration(milliseconds: 1100));
  }
}
