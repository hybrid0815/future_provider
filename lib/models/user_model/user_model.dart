import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/*
"id": 1,
"name": "Leanne Graham",
"username": "Bret",
"email": "Sincere@april.biz",
"phone": "1-770-736-8031 x56442",
"website": "hildegard.org",
*/

@freezed
class User with _$User {
  const User._();

  const factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    required String phone,
    required String website,
  }) = _User;

  factory User.empty() => const User(
      id: -99999,
      name: 'Nan',
      username: 'Nan',
      email: 'Nan',
      phone: 'Nan',
      website: 'Nan');

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  String toString() => 'User(id: $id)';
}
