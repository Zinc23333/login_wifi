import 'dart:io';

import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final netInfo = NetworkInfo();
final dio = Dio();

Future<LoginRes> tryLogin(AccPwd accPwd) async {
  final ip = await netInfo.getWifiIP();
  try {
    final response = await dio.get(
        // "http://10.50.255.12:801/eportal/portal/login?callback=dr1003&login_method=1&user_account=%2C0%2C202221156017%40telecom&user_password=Zn233njtech&wlan_user_ip=$ip&wlan_user_ipv6=&wlan_user_mac=000000000000&wlan_ac_ip=&wlan_ac_name=&jsVersion=4.1.3&terminal_type=1&lang=zh-cn&v=660&lang=zh");
        "http://10.50.255.12:801/eportal/portal/login?callback=dr1003&login_method=1&user_account=%2C0%2C${accPwd.acc}%40telecom&user_password=${accPwd.pwd}&wlan_user_ip=$ip&wlan_user_ipv6=&wlan_user_mac=000000000000&wlan_ac_ip=&wlan_ac_name=&jsVersion=4.1.3&terminal_type=1&lang=zh-cn&v=660&lang=zh");
    return LoginRes.fromInfo(response.toString());
  } catch (e) {
    if (e is DioException && e.type == DioExceptionType.connectionError) return LoginRes.fromInfo("连接失败，请检查是否连接了校园网");
    return LoginRes.fromInfo(e.toString());
  }
}

Future<void> saveInfo(String acc, String pwd, bool auto) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("acc", acc);
  prefs.setString("pwd", pwd);
  prefs.setBool("auto", auto);
}

Future<AccPwd?> getInfo() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final acc = prefs.getString("acc");
  final pwd = prefs.getString("pwd");
  final auto = prefs.getBool("auto") ?? false;
  if (acc == null || pwd == null) return null;
  return AccPwd(acc, pwd, auto);
}

void exitApp() async {
  await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  exit(0);
}

enum LoginState { success, failure }

class LoginRes {
  late final bool state;
  late final String info;

  LoginRes(this.state, this.info);
  LoginRes.fromInfo(this.info) {
    state = info.contains("认证成功") || info.contains("已经在线");
  }
}

class AccPwd {
  final String acc;
  final String pwd;
  final bool auto;

  const AccPwd(this.acc, this.pwd, [this.auto = false]);
}
