import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:sellersapp/src/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sellersapp/src/providers/user_provider.dart';
import 'package:sellersapp/src/providers/utils_provider.dart';
import 'package:sellersapp/src/utils/get_firebase_data.dart';

FormClient formClient = new FormClient();
String _question(int question, String response){
  switch (question) {
    case 1:
      formClient.coordenadas = response;
      break;
    case 2:
      formClient.interes = response;
      break;
    case 3:
      formClient.tiempo = response;
      break;
    case 4:
      formClient.calidad = response;
      break;
    case 5:
      formClient.tipo = response;
      break;
    case 6:
      formClient.compra = response;
      break;
    case 7:
      formClient.motivos = response;
      break;
    case 8:
      formClient.dudas = response;
      break;
  }
}
///
class TextFormFieldWidget extends StatelessWidget {
  String method;
  int question;

  TextFormFieldWidget({this.method = '', @required this.question});
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    String _methodUno(String value){
      dynamic parsed = double.tryParse(value);
      if (parsed == null){
        return 'Número Inválido';
      }else{
        return null;
      }
    }

    return Container(
      width: _size.width * 0.9,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 30),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),

        onSaved: (string){
          _question(this.question, string);
          string = '';
        },
        validator: (string){
          return (this.method == 'double') ? _methodUno(string) : null;
        },
      ),
    );
  }
}

///
class TextFormQuestionWidget extends StatelessWidget {
  final String _text;
  TextFormQuestionWidget(this._text);
  final TextStyle _style = TextStyle(
    fontSize: 18,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        Text(this._text, style: _style,),
        SizedBox(height: 10,),
      ],
    );
  }
}

///
class ItemFormSelectorWidget extends StatelessWidget {

  static const List<Map<String, dynamic>> _mapDefault = [
    {
      'value': 'Sí',
      'label': 'Sí',
    },
    {
      'value': 'No',
      'label': 'No',
    }
  ];
  String initialValue;
  List<Map<String, dynamic>> map;
  int question;
  ItemFormSelectorWidget({this.map = _mapDefault, this.initialValue = 'Sí', @required this.question});

  addEarning(BuildContext context, String val){
   final userProvider = Provider.of<UserProvider>(context, listen: false);
    if(this.question == 6){
     if (val == "Sí"){
       userProvider.estimatedEarning++;
     }
   }
  }
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width * 0.9,
      child: SelectFormField(

        type: SelectFormFieldType.dropdown, // or can be dialog
        initialValue: this.initialValue,
        labelText: '',
        items: this.map,
        validator: (val){
          return null;
        },
        onSaved: (val){
          print('aqui');
          _question(this.question, val);
          addEarning(context, val);
      },
      ),
    );
  }
}

class SubmitFormButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  int index;
  SubmitFormButton({this.formKey, this.index});
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final utilsProvider = Provider.of<UtilsProvider>(context);
    return Column(
      children: [
        SizedBox(height: 20,),
        (utilsProvider.formLoading)?CircularProgressIndicator():ElevatedButton(
            onPressed: () async {
              utilsProvider.formLoading = true;
              if (formKey.currentState.validate()){
                formKey.currentState.save();
                formClient.complete = 'ok';
                final url = Uri.https('logicielapplabwebpage-default-rtdb.firebaseio.com', '/${date()}/${userProvider.user}/list/${this.index}/Form.json');
                await http.put(url, body: json.encode(formClient.toMap()));
              }
              utilsProvider.formLoading = false;
              Navigator.pushReplacementNamed(context, 'main');
            },
            child: const Text('Guardar')
        ),
        SizedBox(height: 50,),
      ],
    );
  }
}


