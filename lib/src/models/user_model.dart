// To parse this JSON data, do
//
//     final task = taskFromMap(jsonString);

import 'dart:convert';
///Alow to generate list of Task
class Tasks {
  final List<Task> list = [];
  List<Task> generateTask (List<dynamic> data){
    for (var i = 0 ; i < data.length ; i ++){
      final user = Task.fromMap(data[i] as Map<String, dynamic>);
      list.add(user);
    }
    return list;
  }
}
///Class Task save each task information
class Task {
  ///Task information
  Task({
    this.coordenadas,
    this.dir,
    this.res,
    this.form,
  });

  String coordenadas;
  String dir;
  String res;
  String form;

  factory Task.fromJson(String str) => Task.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory Task.fromMap(Map<String, dynamic> json) => Task(
    coordenadas: json["Coordenadas"].toString(),
    dir: json["Dir"].toString(),
    res: json["Res"].toString(),
    form: json["Form"].toString(),
  );

  Map<String, dynamic> toMap() => {
    "Coordenadas": coordenadas,
    "Dir": dir,
    "Res": res,
    "Form": form,
  };
}

///
class FormClient {
  FormClient({
    this.coordenadas,
    this.interes,
    this.tiempo,
    this.calidad,
    this.tipo,
    this.compra,
    this.motivos,
    this.dudas,
    this.complete

  });

  String coordenadas;
  String interes;
  String tiempo;
  String calidad;
  String tipo;
  String compra;
  String motivos;
  String dudas;
  String complete;

  factory FormClient.fromJson(String str) => FormClient.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory FormClient.fromMap(Map<String, dynamic> json) => FormClient(
    coordenadas: json["Coordenadas"].toString(),
    interes: json["Interes"].toString(),
    tiempo: json["Tiempo"].toString(),
    calidad: json["Calidad"].toString(),
    tipo: json["Tipo"].toString(),
    compra: json["Compra"].toString(),
    motivos: json["Motivos"].toString(),
    dudas: json["Dudas"].toString(),
    complete: json["Complete"].toString(),
  );

  Map<String, dynamic> toMap() => {
    "Coordenadas": coordenadas,
    "Interes": interes,
    "Tiempo": tiempo,
    "Calidad": calidad,
    "Tipo": tipo,
    "Compra": compra,
    "Motivos": motivos,
    "Dudas": dudas,
    "Complete":complete,
  };
}
