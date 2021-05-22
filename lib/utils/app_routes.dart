import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class AppRoutes {
  static void push(BuildContext context, Widget page) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 400),
            child: page));
  }

  static void pushEaseOutSine(BuildContext context, Widget page) {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 700),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secanimation, Widget child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.easeOutSine);
          return ScaleTransition(
            alignment: Alignment.center,
            scale: animation,
            child: child,
          );
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secanimation) {
          return page;
        }));
  }

  static void toast(BuildContext context, String title) {
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static void replace(BuildContext context, Widget page) {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 1),
            child: page));
  }

  static void popUntil(BuildContext context, int remove) {
    int count = 0;
    Navigator.popUntil(context, (route) {
      return count++ == remove;
    });
  }

  static void makeFirst(BuildContext context, Widget page) {
    Navigator.of(context).popUntil((predicate) => predicate.isFirst);
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 1),
            child: page));
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
