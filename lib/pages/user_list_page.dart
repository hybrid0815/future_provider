import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_provider.dart';
import 'user_detail_page.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userListProvider);
    print(userList);

    print(
        'Loading Properties - isLoading: ${userList.isLoading}, isRefreshing: ${userList.isRefreshing}, isReloading: ${userList.isReloading}');
    print(
        'Value Properties - hasValue: ${userList.hasValue}, hasError: ${userList.hasError}');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Future Provider',
        ),
        actions: [
          IconButton(
              onPressed: () {
                ref.invalidate(userListProvider);
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: userList.when(
        skipLoadingOnRefresh: false,
        data: (users) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(userListProvider),
            color: Colors.blue,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: users.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserDetailPage(
                          userId: user.id,
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    child: Text(user.id.toString()),
                  ),
                  title: Text(user.name),
                );
              },
            ),
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
    );
  }
}
