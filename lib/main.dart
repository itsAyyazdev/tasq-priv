import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:tasq/providers/chat_provider.dart';
import 'package:tasq/ui/widgets/shared/loader.dart';
import 'package:tasq/utils/constants/config.dart';
import 'package:tasq/utils/globals/import_hub.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],

      builder: (context, _) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TASQ',
        theme: ThemeData(
          fontFamily: "monts",
          buttonColor: AppConfig.colors.themeBlue,
          appBarTheme: AppBarTheme(shadowColor: AppConfig.colors.themeBlue),
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: Provider.of<AuthProvider>(context).getInitialPage(),
          builder: (context, AsyncSnapshot<Widget> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: MyLoader(
                isFullScreen: true,
                bgColor: Colors.white,
              ));
            } else {
              ResponsiveWidgets.init(
                context,
                allowFontScaling: true,
              );
              return ResponsiveWidgets.builder(child: snapshot.data);
            }
          },
        ),
      ),
      // child: ,
    );
  }
}
