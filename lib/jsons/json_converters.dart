import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

class RxStringConverter implements JsonConverter<RxString, String> {
  const RxStringConverter();

  @override
  RxString fromJson(String json) {
    return RxString(json);
  }

  @override
  String toJson(RxString json) => json.value;
}

class RxListConverter implements JsonConverter<RxList, List> {
  const RxListConverter();

  @override
  RxList fromJson(List list) {
    return RxList(list);
  }

  @override
  // ignore: invalid_use_of_protected_member
  List toJson(RxList list) => list.value;
}

class RxIntConverter implements JsonConverter<RxInt, int> {
  const RxIntConverter();

  @override
  RxInt fromJson(int json) {
    return RxInt(json);
  }

  @override
  int toJson(RxInt json) => json.value;
}

class RxBoolConverter implements JsonConverter<RxBool, bool> {
  const RxBoolConverter();

  @override
  RxBool fromJson(bool json) {
    return RxBool(json);
  }

  @override
  bool toJson(RxBool json) => json.value;
}
