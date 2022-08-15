import 'package:flutter/material.dart';

import '../models/placeSwitch.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  int selectedPlace = 14;
  int liczbaPrzejsc = 0;
  List<placeSwitch> placeSwitchList = [];
  List<int> stanowisko = [
    14,
    12,
    11,
    10,
    21,
    6,
    45,
    1,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Park App')),
      body: Container(
        padding: EdgeInsets.all(25),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                    child: TextField(
                  controller: startController,
                  decoration: InputDecoration(labelText: 'Kiedy zaczynasz?'),
                )),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: TextField(
                  controller: endController,
                  decoration: InputDecoration(labelText: 'Kiedy kończysz?'),
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButton(
                value: selectedPlace,
                items: stanowisko.map((int e) {
                  return DropdownMenuItem(child: Text(e.toString()), value: e);
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedPlace = int.parse(newValue.toString());
                  });
                }),
            Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                child: ElevatedButton(onPressed: () {
                  placeSwitchList = [];
                  double sum = double.parse(endController.text) - double.parse(startController.text);
                  if(sum % 1 != 0){
                    setState(() {
                      liczbaPrzejsc = sum.ceil() * 2 - 1;
                    });
                     
                  }else{
                    setState(() {
                      liczbaPrzejsc =sum.toInt() * 2;
                    });
                  
                  }
                  double _switchTime = double.parse(startController.text);
                  int stanowiskoIndex = stanowisko.indexWhere((element) => element == selectedPlace);
                  int _changeFrequency = 3;
                  for(int i = 0; i < liczbaPrzejsc; i++){
                    placeSwitchList.add(placeSwitch(workPlace: stanowisko[stanowiskoIndex], changeFrequency: _changeFrequency, switchTime: _switchTime));
                    _switchTime =  _switchTime + 0.5;
                    stanowiskoIndex = stanowiskoIndex + 3;
                    if(stanowiskoIndex >= stanowisko.length){
                      stanowiskoIndex = stanowiskoIndex - stanowisko.length;
                    }
                  }
                }, child: Text('Oblicz'))),

            Expanded(
              child: ListView.builder(
                //scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: liczbaPrzejsc,
                itemBuilder: ((context, index) {
                  return Container(
                    child: Card(child: Row(children: [Text('Stanowisko: ${placeSwitchList[index].workPlace} '),
                    Text('Przejscie co: ${placeSwitchList[index].changeFrequency} '),
                    Text('Godzina przejścia: ${placeSwitchList[index].switchTime}' ),
                    ],)),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
