import 'package:flutter/material.dart';

void main() {
  runApp(const StateLessCalc());
}

class StateLessCalc extends StatelessWidget {
  const StateLessCalc({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'calc application',
      home: StateFulCalc(),
    );
  }
}

class StateFulCalc extends StatefulWidget {
  const StateFulCalc({super.key});

  @override
  CalcButtons createState() => CalcButtons();
}

class CalcButtons extends State<StateFulCalc> {
  List<String> buttonsIcons = [
    "÷",
    "-",
    "*",
    "+",
    "⌫",
    "=",
    "C",
    ".",
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
  ];
  List<String> view = [];
  List<num> intNumbers = [];
  List<String> operations = [];
  String stringNum = "";
  num calculation = 0;
  List<String> historyResult = [];
  List<num> results = [];
  List<String> dataHistory= [];
  String historyData = "";
  String calcWay = "";
  List<String> result1 = [];

  void onButtonPressed(int whichButton) {
    setState(() {
      if (whichButton >= 7) {
        view.add(buttonsIcons[whichButton]);
        stringNum = stringNum + buttonsIcons[whichButton];
      }
      if (whichButton <= 3) {
        view.add(buttonsIcons[whichButton]);
        intNumbers.add(num.parse(stringNum));
        if (view[0] == buttonsIcons[1]) {
          intNumbers[0] = intNumbers[0] * -1;
          stringNum = "-$stringNum";
        }
        operations.add(buttonsIcons[whichButton]);
        dataHistory.add(stringNum);
        stringNum = "";
        dataHistory.add(buttonsIcons[whichButton]);
      }
      if (whichButton == 4) {
        if (view.isNotEmpty) {
          if(view.length==1){
            operations.clear();
            stringNum="";
            intNumbers.clear();
            
          }
          
          if (stringNum.isNotEmpty && ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'].contains(view.last)) {
            stringNum = stringNum.substring(0, stringNum.length - 1);
          } else if (operations.isNotEmpty && ["+", "-", "*", "÷"].contains(view.last)) {
            operations.removeLast();
            stringNum = intNumbers.last.toString();
            intNumbers.removeLast();
          }
          view.removeLast();
        }
      }
      if (whichButton == 6) {
        view.clear();
        intNumbers.clear();
        operations.clear();
        stringNum = "";
      }
      if (whichButton == 5) {
        historyData = view.join();
        intNumbers.add(num.parse(stringNum));
        dataHistory.add(stringNum);
        if (operations.contains("÷") || operations.contains("*")) {
          for (int i = 0; i < operations.length; i++) {
            if (operations[i] == "÷") {
              calculation = intNumbers[i] / intNumbers[i + 1];
              results.add(calculation);
              intNumbers[i] = calculation;
              intNumbers.removeAt(i + 1);
              operations.removeAt(i);
              i--;
            }
            if (operations[i] == "*") {
              calculation = intNumbers[i] * intNumbers[i + 1];
              results.add(calculation);
              intNumbers[i] = calculation;
              intNumbers.removeAt(i + 1);
              operations.removeAt(i);
              i--;
            }
          }

        }
        for (int i = 0; i < operations.length; i++) {
          if (operations[i] == "+") {
            calculation = intNumbers[i] + intNumbers[i + 1];
            results.add(calculation);
            intNumbers[i] = calculation;
            intNumbers.removeAt(i + 1);
            operations.removeAt(i);
            i--;
          }
          if (operations[i] == "-") {
            calculation = intNumbers[i] - intNumbers[i + 1];
            results.add(calculation);
            intNumbers[i] = calculation;
            intNumbers.removeAt(i + 1);
            operations.removeAt(i);
            i--;
          }
        }

        view.clear();
        view.add(results.last.toString());
        if (view[0] == "Infinity") {
          view = ["error"];
          historyResult.add(view.join());
        } else {
          historyResult.add(view.join());
        }
        result1.add("$historyData=${historyResult[0]}");
        dataHistory.clear();

        
        intNumbers.clear();
        operations.clear();
        stringNum =historyResult[0];
        historyResult.clear();
      
      }

    });
  }

  void historyDelete() {
    setState(() {
      result1.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: result1.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      result1[index],
                      textDirection: TextDirection.ltr,
                    ),
                  );
                },
              ),
            ),
            FloatingActionButton(
              onPressed: historyDelete,
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.delete),
            ),
          ],
        ),
      ),
      appBar: AppBar(title: const Text("calculator")),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(0, 20, 0, 50),
              child: Text(
                view.join(),
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            SizedBox(
              width: 300,
              height: 600,
              child: GridView.builder(
                itemCount: buttonsIcons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GridTile(
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          onButtonPressed(index);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.blueGrey,
                        ),
                        child: Center(
                          child: Text(
                            buttonsIcons[index],
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
