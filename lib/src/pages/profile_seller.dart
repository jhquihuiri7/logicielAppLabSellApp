import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellersapp/src/providers/firebase_auth.dart';
import 'package:sellersapp/src/providers/user_provider.dart';
import 'package:sellersapp/src/widgets/profile_seller_presentation.dart';
import 'package:sellersapp/src/widgets/slimy_card_widget.dart';

///
class ProfileSeller extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity,),
          Stack(
            children: <Widget>[

              Image(
                image: AssetImage('assets/profile_background_img.png'),
                height: size * 0.6 * 1.45,
                width: size,
                fit: BoxFit.cover,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.message_outlined, color: Colors.white,),
                    onPressed: (){
                      final userProvider = Provider.of<UserProvider>(context, listen: false);
                      userProvider.loadProducts();
                    },),
                  ProfileSellerPresentation(),
                  IconButton(icon: Icon(Icons.logout), onPressed: (){
                    final authService = Provider.of<AuthenticationService>(context, listen: false);
                    authService.logoutUser();
                    Navigator.pushReplacementNamed(context, 'checking');
                  }),
                ],
              ),
            ]
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <SliverList>[
                SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        SlimyCardWidget(),
                      ]
                    )
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
