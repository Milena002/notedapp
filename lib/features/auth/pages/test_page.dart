import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notedapp/common/utils/constants.dart';
import 'package:notedapp/common/widgets/appstyle.dart';
import 'package:notedapp/common/widgets/reusable_text.dart';
import 'package:notedapp/features/auth/controllers/code_provider.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String code = ref.watch(codeStateProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ReusableText(text: code, 
            style: appstyle(30, AppConst.kZomp, FontWeight.bold)),
            TextButton(onPressed: (){
              ref.read(codeStateProvider.notifier).setStart("Hello Milena");
            }, child: Text("press me")),
               ],
        ),
      ),
    );
  }
}