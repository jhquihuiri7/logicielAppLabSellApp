import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:sellersapp/src/pages/form_client_page.dart';
import 'package:sellersapp/src/providers/user_provider.dart';

///Card for each seller task include a map and a form
class CardWidget extends StatelessWidget {
  final String restaurant;
  final String direction;
  final String coordinates;
  final int index;
  final bool complete;
  ///
  CardWidget({@required this.restaurant, @required this.direction, @required this.coordinates, @required this.index, @required this.complete});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final int lockForm = userProvider.estimatedEarning;
    bool validateForm(){
      if (this.complete){
        return true;
      }else if(lockForm < userProvider.estimatedEarning){
        return true;
      }else{
        return false;
      }
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(this.restaurant),
              subtitle: Text(this.direction),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(onPressed: ()async{
                  final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;

                  await availableMaps.first.showMarker(
                    coords: Coords(37.759392, -122.5107336),
                    title: "Ocean Beach",
                  );
                }, child: const Text('Mapa')),
                const SizedBox(width: 20,),
                TextButton(onPressed: (validateForm())
                    ?null
                    :(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FormClientPage(index: index),));
                }, child: const Text('Formulario')),
                const SizedBox(width: 20,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
