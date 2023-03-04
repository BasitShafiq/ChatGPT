import 'package:flutter/material.dart';
import './screens/chat_screen.dart';
import './constants/constants.dart';
import './provider/models_provider.dart';
import 'package:provider/provider.dart';
import './models/models_model.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ModelProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                scaffoldBackgroundColor: ScaffoldBackgroundColor,
                appBarTheme: AppBarTheme(
                  color: CardColor,
                )),
            home: SplashScreen(),
            routes: {
              SplashScreen.routeName: (ctx) => SplashScreen(),
              ChatScreen.routeName: (ctx) => ChatScreen(),
            }));
  }
}
