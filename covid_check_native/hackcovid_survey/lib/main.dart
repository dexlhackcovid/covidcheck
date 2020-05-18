import 'package:async/async.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hackcovid',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tag = 1;
  List<String> tags = [];

  List<String> options = [
    'Hipertensão',
    'Diabetes',
    'Asma',
    'Câncer',
    'Tosse',
    'Nariz escorrendo',
    'Falta de ar',
    'Dor de cabeça'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hackcovid'),
        actions: <Widget>[],
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
          Content(
            title: 'Qual sua idade?',
            child: buildAgePicker(context),
          ),

          Content(
            title: 'Qual sua temperatura atual?',
            child: buildTemperaturePicker(context),
          ),

          Content(
            title: 'Qual sua pulsação nesse momento?',
            child: buildHeartbeatPicker(context),
          ),

          Content(
            title: 'Selecione todos que se apliquem',
            child: ChipsChoice<String>.multiple(
              value: tags,
              options: ChipsChoiceOption.listFrom<String, String>(
                source: options,
                value: (i, v) => v,
                label: (i, v) => v,
              ),
              onChanged: (val) => setState(() => tags = val),
              isWrapped: true,
            ),
          ),
          Content(
            title: 'AAA',
            child: Text(''),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CustomChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Function(bool selected) onSelect;

  CustomChip(this.label, this.selected, this.onSelect, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 100,
      width: 70,
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 5,
      ),
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: selected ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: selected ? Colors.green : Colors.grey,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => onSelect(!selected),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Visibility(
                visible: selected,
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 32,
                )),
            Positioned(
              left: 9,
              right: 9,
              bottom: 7,
              child: Container(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black45,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final String title;
  final Widget child;

  Content({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            color: Colors.blueGrey[50],
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w500),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

Row buildAgePicker(BuildContext context) {
  int age = 0;
  return Row(
    children: <Widget>[
      Container(
        width: 150.0,
        child: OutlineButton(
          child: Text("Selecione aqui"),
          onPressed: () => showMaterialNumberPicker(
            context: context,
            title: "Qual sua idade?",
            maxNumber: 100,
            minNumber: 14,
            selectedNumber: age,
//            onChanged: (value) => setState(() => age = value),
          ),
        ),
      ),
      Expanded(
        child: Text(
          age.toString(),
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}

Row buildTemperaturePicker(BuildContext context) {
  int temperature = 0;
  return Row(
    children: <Widget>[
      Container(
        width: 150.0,
        child: OutlineButton(
          child: Text("Selecione aqui"),
          onPressed: () => showMaterialNumberPicker(
            context: context,
            title: "Qual sua temperatura atual?",
            maxNumber: 41,
            minNumber: 30,
            selectedNumber: temperature,
//            onChanged: (value) => setState(() => age = value),
          ),
        ),
      ),
      Expanded(
        child: Text(
          temperature.toString(),
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}

Row buildHeartbeatPicker(BuildContext context) {
  int heartbeat = 0;
  return Row(
    children: <Widget>[
      Container(
        width: 150.0,
        child: OutlineButton(
          child: Text("Selecione aqui"),
          onPressed: () => showMaterialNumberPicker(
            context: context,
            title: "Qual sua pulsação atual?",
            maxNumber: 200,
            minNumber: 60,
            selectedNumber: heartbeat,
//            onChanged: (value) => setState(() => age = value),
          ),
        ),
      ),
      Expanded(
        child: Text(
          heartbeat.toString(),
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}
