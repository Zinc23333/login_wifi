import 'package:flutter/material.dart';
import 'package:login_wifi/home.dart';
import 'package:login_wifi/login.dart';
import 'package:login_wifi/notify.dart';
import 'package:login_wifi/pinfo.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final notify = Notify();
    notify.initialize();

    bool res = false;
    for (int i = 0; i < 10; i++) {
      if ((await tryLogin(AccPwd(inputData!["a"], inputData["p"]))).state) res = true;
    }

    await notify.showNotification(title: "登陆宿舍校园网", body: res ? "登陆成功 /ᐠ｡▿｡ᐟ\\ᵖᵘʳʳ" : "登陆失败 /ᐠ –ꞈ –ᐟ\\");
    return res;
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final info = await getInfo();
  if (info?.auto == true) {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    Workmanager().registerOneOffTask("task-try_login", "tryLogin", inputData: {"a": info!.acc, "p": info.pwd});
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    final notify = Notify();
    notify.initialize();

    notify.getNotificationAppLaunchDetails().then((notifyDetail) {
      if (notifyDetail?.didNotificationLaunchApp == true) return;

      getInfo().then((ap) async {
        if (ap?.auto == false) return;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '登陆校园网',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: const MyMainPage(),
    );
  }
}

class MyMainPage extends StatelessWidget {
  const MyMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getInfo(), builder: (context, snapshot) => snapshot.data == null ? const PInfo() : MyHomePage(accPwd: snapshot.data!));
  }
}
