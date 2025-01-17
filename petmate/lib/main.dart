import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petmate/pages/HomePage.dart';
import 'package:petmate/providers/LocalVariableProvider.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:petmate/providers/LocalFunctionProvider.dart';
import 'package:petmate/providers/chat_provider.dart';
import 'package:provider/provider.dart';

//  general color .
Color color1 = HexColor("#1c3a44");
Color color2 = HexColor("#d5d5d5");
Color color3 = HexColor("#85bc9c");
Color color4 = HexColor("#51cdd7");

void main() async {
  // initializtion widget
  WidgetsFlutterBinding.ensureInitialized();
  // //  initialization for firebase .
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      //  Firebase Provider
      ChangeNotifierProvider<FirebaseProvider>(
        create: (context) => FirebaseProvider(),
      ),

      //  Local Function  Provider .
      ChangeNotifierProvider<LocalFunctionProvider>(
        create: (context) => LocalFunctionProvider(),
      ),

      //  Local Variable  Provider .
      ChangeNotifierProvider<LocalVariableProvider>(
        create: (context) => LocalVariableProvider(),
      ),

      //  chat provider  .
      ChangeNotifierProvider<ChatProvider>(
        create: (context) => ChatProvider(),
      ),
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            headlineLarge: GoogleFonts.notoSerif(
              color: HexColor("#1c3a44"),
              fontSize: 20,
            ),
            headlineMedium: GoogleFonts.mukta(
              color: color1,
              fontSize: 20,
            ),
          ),
        ),
        home: HomePage()),
  ));
}
