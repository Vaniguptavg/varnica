library user_model;
import 'package:json_annotation/json_annotation.dart';
import 'package:loginapp_demo/domain/entities/User.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {

  static final String className = 'UserModel';

  @JsonKey(name: 'access_token')
  final String token;
  @JsonKey(name: 'first_name')
  final String name;
  @JsonKey(name: 'id')
  final int id;

  UserModel(this.id, this.token, this.name) : super();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

}

