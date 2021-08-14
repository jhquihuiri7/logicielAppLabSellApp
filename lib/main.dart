import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sellersapp/src/pages/check_auth_page.dart';
import 'package:sellersapp/src/pages/form_client_page.dart';
import 'package:sellersapp/src/pages/login_page.dart';
import 'package:sellersapp/src/pages/main_seller.dart';
import 'package:sellersapp/src/pages/profile_seller.dart';
import 'package:sellersapp/src/providers/user_provider.dart';
import 'package:sellersapp/src/providers/firebase_auth.dart';
import 'package:sellersapp/src/providers/utils_provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyRestoApp()));
}

class MyRestoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationService()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UtilsProvider()),
      ],
      child: MaterialApp(
        title: 'Sellers App Manager',
        debugShowCheckedModeBanner: false,
        initialRoute: 'checking',
        routes: <String, WidgetBuilder>{
          'login' : (_) => LoginPage(),
          'main': (_) => MainSeller(),
          'profile': (_) => ProfileSeller(),
          'form': (_)=> FormClientPage(),
          'checking': (_) => CheckAuthPage(),
        },
      ),
    );
  }
}
