import 'package:fill/firebase/apis/auth.dart';
import 'package:fill/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Text(
                'Goal',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Center(
              child: Text(
                '小さな達成感を積み上げて大きな達成を•••',
                style: TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthRepository().signInWithGoogle();
                // Home画面を表示する
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Text('Sign in with Google'),
            ),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: () async {
                await AuthRepository().signInWithGoogle();
                // Home画面を表示する
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Text('Sign in with Apple'),
            ),
          ],
        ),
      ),
    );
  }
}
