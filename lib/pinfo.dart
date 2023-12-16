import 'package:flutter/material.dart';
import 'package:login_wifi/home.dart';
import 'package:login_wifi/login.dart';

class PInfo extends StatefulWidget {
  const PInfo({super.key});

  @override
  State<PInfo> createState() => _PInfoState();
}

class _PInfoState extends State<PInfo> {
  TextEditingController tecAcc = TextEditingController();
  TextEditingController tecPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: getInfo(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                tecAcc.text = snapshot.data!.acc;
                tecPwd.text = snapshot.data!.pwd;
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(controller: tecAcc, decoration: const InputDecoration(labelText: "账号")),
                  TextField(controller: tecPwd, decoration: const InputDecoration(labelText: "密码")),
                  ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("保存成功")));
                        saveInfo(tecAcc.text, tecPwd.text);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(accPwd: AccPwd(tecAcc.text, tecPwd.text))));
                      },
                      child: const Text("完成"))
                ],
              );
            }),
      ),
    );
  }
}
