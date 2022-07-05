import 'package:json_annotation/json_annotation.dart';

part 'wlfare.g.dart';

@JsonSerializable()
class Wlfare {
  dynamic dmCount;
  dynamic dmScr;
  dynamic dmSerchParam;
  dynamic dsServiceList0;
  dynamic dsServiceList1;
  dynamic dsServiceList2;
  dynamic dsServiceList3;

  Wlfare(
    this.dmCount,
    this.dmScr,
    this.dmSerchParam,
    this.dsServiceList0,
    this.dsServiceList1,
    this.dsServiceList2,
    this.dsServiceList3,
  );

  factory Wlfare.fromJson(Map<String, dynamic> json) => _$WlfareFromJson(json);

  Map<String, dynamic> toJson() => _$WlfareToJson(this);
}
