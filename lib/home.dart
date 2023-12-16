import 'package:flutter/material.dart';
import 'package:login_wifi/login.dart';
import 'package:login_wifi/pinfo.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.accPwd});
  final AccPwd accPwd;

  @override
  Widget build(BuildContext context) {
    tryLogin(accPwd).then(
      (res) {
        if (res.state) {
          exitApp();
        }
      },
    );

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.login, size: 64),
              onPressed: () async {
                final sm = ScaffoldMessenger.of(context);
                final res = await tryLogin(accPwd);
                if (res.state) {
                  sm.showSnackBar(const SnackBar(content: Text("登陆成功")));
                  exitApp();
                } else {
                  if (!context.mounted) return;
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("错误"),
                      content: Text(
                        res.info,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PInfo()));
            },
            child: const Text("设置登陆信息"),
          )
        ],
      ),
    );
  }
}
