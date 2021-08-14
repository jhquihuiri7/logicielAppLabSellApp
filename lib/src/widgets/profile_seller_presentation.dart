import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellersapp/src/providers/user_provider.dart';

class ProfileSellerPresentation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.6;
    final userProvider = Provider.of<UserProvider>(context);
    return Container(
        height: size * 1.3,
        width: size,
        decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(200),
              bottomRight: Radius.circular(200),
            )
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: size * 0.95,
                child: Container(
                  width: size,
                  child: Center(
                    child: Text('Jhonatan Quihuiri', style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),),
                  ),
                ),
            ),
            Positioned(
              bottom: size * 0.1,
              left: size * 0.1,
              child: Container(
                height: size * 0.8,
                width: size * 0.8,
                decoration: const BoxDecoration(
                    gradient: RadialGradient(
                        center: Alignment.bottomLeft,
                        colors: [
                          Colors.blue,
                          Colors.white,
                          Colors.deepPurple,
                          Colors.purple,
                          Colors.pink,
                          Colors.red,
                          Colors.white,
                        ],

                        radius: 1.3
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(100))
                ),
                child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: Container(
                        height: size * 0.6,
                        width: size * 0.6,
                        child: Hero(
                          tag: 'hero',
                          child: Image(
                            image: NetworkImage(userProvider.userImg),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )
                ),
              ),
            )
          ],
        )
    );
  }
}
