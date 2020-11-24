import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'misc.dart';

Future<bool> confirm(String text, {String content = ''}) async {
  bool ret = await Get.dialog<bool>(
      AlertDialog(
        title: Text(text),
        content: content.isEmpty ? null : Text(content),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Get.back(result: false);
              },
              textColor: Get.theme.accentColor,
              child: Text('CANCEL')),
          FlatButton(
              onPressed: () {
                Get.back(result: true);
              },
              textColor: Get.theme.accentColor,
              child: Text('OK'))
        ],
      ),
      useRootNavigator: false,
      barrierDismissible: false);
  return ret ?? false;
}

void toast(String msg) {
  debugPrint(msg);
  BotToast.showCustomText(
      align: Alignment.bottomCenter,
      ignoreContentClick: true,
      toastBuilder: (c) {
        delay(1800).then((value) => c());
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Card(
              color: Get.theme.backgroundColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  msg,
                  style: TextStyle(
                      fontSize: 16,
                      color: Get.isDarkMode ? Colors.green : Colors.yellow),
                ),
              )),
        );
      });
}

CancelFunc loader() {
  return BotToast.showCustomText(
      backgroundColor: Colors.black12,
      align: Alignment.center,
      toastBuilder: (void Function() cancelFunc) {
        return Card(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 45,
                child: SpinKitDualRing(
                  lineWidth: 4.0,
                  size: 40.0,
                  color: Get.theme.accentColor,
                ),
              ),
              SizedBox(width: 20),
              Text('loading..')
            ],
          ),
        ));
      });
}
