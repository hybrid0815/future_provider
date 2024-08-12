import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user_model/user_model.dart';
import 'dio_provider.dart';

part 'user_provider.g.dart';

@riverpod
FutureOr<List<User>> userList(UserListRef ref) async {
  ref.onDispose(() {
    print('[userListProvider] dispose');
  });

  final response = await ref.watch(dioProvider).get('/users');

  final userList = [for (final user in response.data) User.fromJson(user)];

  return userList;
}

@riverpod
FutureOr<User> userDetail(UserDetailRef ref, {required int userId}) async {
  ref.onDispose(() {
    print('[userDetailProvider] dispose $userId');
  });

  final response = await ref.watch(dioProvider).get('/users/$userId');

  final user = User.fromJson(response.data);

  return user;
}
