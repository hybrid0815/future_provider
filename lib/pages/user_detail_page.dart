import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_provider.dart';

class UserDetailPage extends ConsumerWidget {
  const UserDetailPage({
    super.key,
    required this.userId,
  });

  final int userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetail = ref.watch(userDetailProvider(userId: userId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: RefreshIndicator(
        //
        // ref.refresh
        // ref.invalidate
        //
        onRefresh: () async =>
            ref.invalidate(userDetailProvider(userId: userId)),
        child: userDetail.when(
          data: (user) {
            return ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 20,
              ),
              children: [
                ListTile(title: Text(user.name)),
                const Divider(),
                UserInfo(
                    iconData: Icons.account_circle, userInfo: user.username),
                UserInfo(iconData: Icons.phone, userInfo: user.phone),
                UserInfo(iconData: Icons.web, userInfo: user.website),
              ],
            );
          },
          error: (e, st) => Center(
            child: Text(
              e.toString(),
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.userInfo,
    required this.iconData,
  });
  final String userInfo;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(width: 20),
        Text(userInfo),
      ],
    );
  }
}
