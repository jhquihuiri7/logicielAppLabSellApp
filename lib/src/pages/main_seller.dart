import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:provider/provider.dart';
import 'package:sellersapp/src/models/user_model.dart';
import 'package:sellersapp/src/providers/user_provider.dart';
import 'package:sellersapp/src/utils/get_firebase_data.dart';

import 'package:sellersapp/src/widgets/export_widgets.dart';

///Main paeg for seller management
class MainSeller extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            MainSellerPresentation(),
            Container(
              height: 60,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 30),
              child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Mis Misiones',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Task>>(
                future: userProvider.loadProducts(),
                builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot){
                  if (snapshot.hasData){
                    final List<Task> tasks = snapshot.data;
                    return CustomScrollView(
                      slivers: <SliverList>[
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index){
                                  return CardWidget(
                                    restaurant: tasks[index].res,
                                    direction: tasks[index].dir,
                                    coordinates: tasks[index].coordenadas,
                                    index: index,
                                    complete: tasks[index].form.contains('Complete'),
                                  );
                                },
                              childCount: tasks.length,
                            ),
                        )
                      ],
                    );
                  }else{
                    return Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          child: LoadingIndicator(
                              indicatorType: Indicator.circleStrokeSpin, /// Required, The loading type of the widget
                              colors: const [Colors.grey],       /// Optional, The color collections
                              ),
                        )
                    );
                  }
                  return Container();
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}


