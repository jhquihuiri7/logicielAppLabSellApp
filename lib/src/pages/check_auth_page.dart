import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellersapp/src/pages/login_page.dart';
import 'package:sellersapp/src/pages/main_seller.dart';
import 'package:sellersapp/src/providers/firebase_auth.dart';
import 'package:sellersapp/src/providers/user_provider.dart';
import 'package:sellersapp/src/utils/get_firebase_data.dart';

///Check if user is logged in
class CheckAuthPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    calculateEarnings(context);
    return Scaffold(
      backgroundColor: const Color(0xff55408a),
      body: Center(
        child: FutureBuilder<List<String>>(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot){
            if (!snapshot.hasData){

              return const CircularProgressIndicator();
            }
            if (snapshot.data[0] == ''){
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_,__,___)=>LoginPage(),
                  transitionDuration: const Duration(),
                ));
              });
            }else{
              Future.microtask(() {
                userProvider.user = snapshot.data[1];
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_,__,___)=>MainSeller(),
                  transitionDuration: const Duration(),
                ));
              });
            }
            return Container();
          },
        ),
      ),
    ) ;
  }
}
