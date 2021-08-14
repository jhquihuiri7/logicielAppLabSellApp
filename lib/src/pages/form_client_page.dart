import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellersapp/src/models/user_model.dart';
import 'package:sellersapp/src/providers/user_provider.dart';
import 'package:sellersapp/src/widgets/form_widgets.dart';

///
class FormClientPage extends StatelessWidget {
  int index;
  FormClientPage({@required this.index});
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _calidad = [
    {
      'value': 'Alta',
      'label': 'Alta',
    },
    {
      'value': 'Media',
      'label': 'Media',
    },
    {
      'value': 'Baja',
      'label': 'Baja',
    }
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: 30,),
                    const Text('Formulario de Datos del Cliente',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.grey),
                    ),
                    TextFormQuestionWidget('1) Coordenadas'),
                    TextFormFieldWidget(question: 1,),
                    TextFormQuestionWidget('2) Interés en iniciativa'),
                    ItemFormSelectorWidget(question: 2,),
                    TextFormQuestionWidget('3) Tiempo en el negocio'),
                    TextFormFieldWidget(method: 'double',question: 3,),
                    TextFormQuestionWidget('4) Calidad restaurante'),
                    ItemFormSelectorWidget(map:_calidad, initialValue:'Alta',question: 4,),
                    TextFormQuestionWidget('5) Tipo de menú'),
                    TextFormFieldWidget(question: 5,),
                    TextFormQuestionWidget('6) Compra'),
                    ItemFormSelectorWidget(question: 6,),
                    TextFormQuestionWidget('7) Motivos'),
                    TextFormFieldWidget(question: 7,),
                    TextFormQuestionWidget('8) Dudas'),
                    TextFormFieldWidget(question: 8,),
                    SubmitFormButton(formKey: _formKey, index: this.index,),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
