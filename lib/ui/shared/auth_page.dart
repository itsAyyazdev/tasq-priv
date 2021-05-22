import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tasq/utils/constants/config.dart';
import 'package:tasq/utils/constants/text_styles.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, p, _) => LoadingOverlay(
              isLoading: p.isLoading,
              child: Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "get Started",
                        style: MyTextStyles.montsSemiBold16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
                      child: MaterialButton(
                        onPressed: p.signInWithGoogle,
                        child: Image.asset(AppConfig.images.googleSignIn),
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "terms and conditions",
                          style: MyTextStyles.montsSemiBold16
                              .copyWith(color: Theme.of(context).buttonColor),
                        )),
                    SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            ));
  }
}
