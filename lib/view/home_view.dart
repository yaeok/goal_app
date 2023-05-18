import 'package:fill/state/goal_state.dart';
import 'package:fill/view/auth/login_page.dart';
import 'package:fill/view/detail_view.dart';
import 'package:fill/view/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final dataListAsyncValue = ref.watch(goalListProvider);
          return dataListAsyncValue.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                const Center(child: Text('データの取得に失敗しました')),
            data: (dataList) {
              if (dataList.isEmpty) {
                return const Center(child: Text('目標を設定しよう！'));
              } else {
                return ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: dataList[index].goals[0].flg == true
                          ? null
                          : Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ListTile(
                          title: Text(dataList[index].goals[0].title ?? ''),
                          subtitle: Text(dataList[index].goals[1].title ?? ''),
                          trailing: const Icon(Icons.more_vert),
                          onTap: () {
                            ref.read(goalProvider.notifier).state =
                                dataList[index];
                            if (dataList[index].goals[0].flg == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DetailPage()),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 75,
        height: 75,
        child: FloatingActionButton(
          child: const Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterPage()),
            )
          },
        ),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(children: <Widget>[
            SwitchListTile(
              title: const Text('過去の栄光'),
              value: true,
              //スイッチが変更された時のイベントを定義する
              onChanged: (bool value) {
                // 変更時のイベントが続く
              },
              secondary: const Icon(Icons.favorite, color: Colors.teal),
            ),
            TextButton(
              child: const Text('ログアウト'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: const Text(
                        'ログアウトしますか？',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextButton(
                            child: const Text('ログアウト'),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return const LoginPage();
                                }),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
