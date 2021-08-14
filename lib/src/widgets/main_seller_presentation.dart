import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sellersapp/src/providers/user_provider.dart';

class MainSellerPresentation extends StatelessWidget {

  ///
  final String img = 'assets/main_background_img.png';

  ///
  final String sellerImg = 'assets/seller_img.png';

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width;
    final userProvider = Provider.of<UserProvider>(context);
    return Stack(
        children: [
          Image(
            image: AssetImage(img),
            fit: BoxFit.fitWidth,
          ),
          Column(
            children: [
              SizedBox(width: double.infinity, height: size * 0.2,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, 'profile');
                },
                child: Container(
                  height: size * 0.2,
                  width: size * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.deepPurple, width: 2)
                  ),
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: userProvider.readUser(userProvider.user),
                    builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
                      if (snapshot.hasData){
                        userProvider.userImg = snapshot.data['Image'].toString();
                        return Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: size * 0.18,
                                width: size * 0.18,
                                child: Hero(
                                  tag: 'hero',
                                  child: Image(
                                    image: NetworkImage(snapshot.data['Image'].toString()),
                                  ),
                                ),
                              ),
                            )
                        );
                      }else {
                        return Container(
                          height: 30,
                          width: 30,
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballClipRotateMultiple, /// Required, The loading type of the widget
                            colors: const [Colors.white],       /// Optional, The color collections
                          ),
                        );;
                      }
                    },
                  ),
                ),
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: userProvider.readUser(userProvider.user),
                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
                  if (snapshot.hasData){
                    return Text(snapshot.data['Name'].toString(),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    );
                  }else{
                    return Container(
                      height: 50,
                      width: 50,
                      child: LoadingIndicator(
                          indicatorType: Indicator.ballBeat, /// Required, The loading type of the widget
                          colors: const [Colors.deepOrange, Colors.cyanAccent, Colors.deepPurple],       /// Optional, The color collections
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ]
    );
  }
}
