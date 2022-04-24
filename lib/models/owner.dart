import 'package:json_annotation/json_annotation.dart';
part 'owner.g.dart';

@JsonSerializable(explicitToJson: true)
class Owner {
  String name;
  String password;
  Owner(this.name, this.password);

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
