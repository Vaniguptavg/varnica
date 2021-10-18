import 'package:equatable/equatable.dart';

class User extends Equatable{

  final String? name;
  final String? token;

  User({
     this.name,
     this.token,
  });
  
  @override
  List<Object?> get props => [];

}