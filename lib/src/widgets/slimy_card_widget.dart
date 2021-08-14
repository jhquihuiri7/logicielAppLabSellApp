import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sellersapp/src/providers/user_provider.dart';
import 'package:slimy_card/slimy_card.dart';
///
class SlimyCardWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SlimyCard(
      color: Colors.black26,
      width: size.width * 0.7,
      topCardHeight: 220,
      bottomCardHeight: 150,
      borderRadius: 15,
      topCardWidget: _SlimyCardUno(),
      bottomCardWidget: _SlimyCardDos(),
      slimeEnabled: true,
    );
  }
}
class _SlimyCardUno extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/slimy_plus.svg',
          height: 60,
        ),
        SizedBox(height: 10,),
        Text('Mis ingresos estimados', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),),
        SizedBox(height: 10,),
        Text('\$${userProvider.estimatedEarning * 50}', style: TextStyle(color: Colors.lightGreenAccent, fontSize: 40),),
      ],
    );
  }
}

class _SlimyCardDos extends StatelessWidget {
  int logicMeta (int ventas){
    if (ventas < 15){
      return 15;
    }else if (ventas >= 15 && ventas < 20){
      return 20;
    }else if (ventas >= 20 && ventas < 25){
      return 25;
    }else if (ventas >= 25 && ventas < 30){
      return 30;
    } else {
      return 35;
    }
  }
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Bravo! Registras un total de ${userProvider.estimatedEarning} ventas.', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),),
        Text('Tu meta son ${logicMeta(userProvider.estimatedEarning)}!', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),),
        Text('Conviertete en un super vendedor! Logra ${logicMeta(userProvider.estimatedEarning)+5} ventas', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),),
      ],
    );
  }
}
