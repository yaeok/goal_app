import 'package:fill/firebase/apis/goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final finishController = TextEditingController();
    final firstController = TextEditingController();
    final secondController = TextEditingController();
    final thirdController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Setting Goals'),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Form(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FormBuilderTextField(
                  name: 'finish',
                  controller: finishController,
                  decoration: const InputDecoration(
                      labelText: '最終目標', helperText: '例）1ヶ月で3キロ痩せる'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FormBuilderTextField(
                  name: 'first',
                  controller: firstController,
                  decoration: const InputDecoration(
                      labelText: '第1目標', helperText: '例）3日間ジムに通う'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FormBuilderTextField(
                  name: 'second',
                  controller: secondController,
                  decoration: const InputDecoration(
                      labelText: '第2目標', helperText: '例）1週間ジムに通う'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FormBuilderTextField(
                  name: 'third',
                  controller: thirdController,
                  decoration: const InputDecoration(
                      labelText: '第3目標', helperText: '例）1ヶ月間ジムに通う'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (firstController.text == '' &&
                        secondController.text == '' &&
                        thirdController.text == '' &&
                        finishController.text == '') {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: const Text(
                              '入力されていない項目があります',
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('戻る')),
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      await GoalRepository().registerGoal(
                          firstController.text,
                          secondController.text,
                          thirdController.text,
                          finishController.text);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('登録する'),
                ),
              )
            ],
          )),
        ));
  }
}
