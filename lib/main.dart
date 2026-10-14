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
  List<String> numbers = [];
  List<num> intNumbers = [];
  List<String> operations = [];
  String stringNum = "";
  num result = 0;
  List<String> history = [];
  List<num> results = [];
  List<String> dataHistory = [];
  String historyData = "";
  String calcWay = "";
  List<String> result1 = [];

  void onButtonPressed(int whichButton) {
    setState(() {
      if (whichButton >= 7) {
        numbers.add(buttonsIcons[whichButton]);
        stringNum = stringNum + buttonsIcons[whichButton];
      }
      if (whichButton <= 3) {
        numbers.add(buttonsIcons[whichButton]);
        intNumbers.add(num.parse(stringNum));
        if (numbers[0] == buttonsIcons[1]) {
          intNumbers[0] = intNumbers[0] * -1;
          stringNum = "-" + stringNum;
        }
        operations.add(buttonsIcons[whichButton]);
        dataHistory.add(stringNum);
        stringNum = "";
        dataHistory.add(buttonsIcons[whichButton]);
      }
      if (whichButton == 4) {
        numbers.removeLast();
      }
      if (whichButton == 6) {
        numbers.clear();
        intNumbers.clear();
        operations.clear();
        stringNum = "";
      }
      if (whichButton == 5) {
        intNumbers.add(int.parse(stringNum));
        dataHistory.add(stringNum);
        if (operations.contains("÷") || operations.contains("*")) {
          for (int i = 0; i < operations.length; i++) {
            if (operations[i] == "÷") {
              result = intNumbers[i] / intNumbers[i + 1];
              results.add(result);
              intNumbers[i] = result;
              intNumbers.removeAt(i + 1);
              operations.removeAt(i);
              i--;
            }
            if (operations[i] == "*") {
              result = intNumbers[i] * intNumbers[i + 1];
              results.add(result);
              intNumbers[i] = result;
              intNumbers.removeAt(i + 1);
              operations.removeAt(i);
              i--;
            }
          }
        }
        for (int i = 0; i < operations.length; i++) {
          if (operations[i] == "+") {
            result = intNumbers[i] + intNumbers[i + 1];
            results.add(result);
            intNumbers[i] = result;
            intNumbers.removeAt(i + 1);
            operations.removeAt(i);
            i--;
          }
          if (operations[i] == "-") {
            result = intNumbers[i] - intNumbers[i + 1];
            results.add(result);
            intNumbers[i] = result;
            intNumbers.removeAt(i + 1);
            operations.removeAt(i);
            i--;
          }
        }
        historyData = numbers.join();
        numbers.clear();
        numbers.add(results.last.toString());
        if (numbers[0] == "Infinity") {
          numbers = ["error"];
          history.add(numbers.toString());
        } else {
          history.add(numbers.toString());
        }
        result1.add(historyData + "=" + history[0]);
        dataHistory.clear();
        history.clear();
        results.clear();
        intNumbers.clear();
        operations.clear();
      }
    });
  }

  void historyDelete() {
    setState(() {
      result1.clear();
    });
  }

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
            Container(
              child: Text(
                numbers.join(),
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            SizedBox(
              width: 300,
              height: 500,
              child: GridView.builder(
                itemCount: buttonsIcons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GridTile(
                    child: ElevatedButton(
                      onPressed: () {
                        onButtonPressed(index);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.blueGrey,
                      ),
                      child: Text(
                        '${buttonsIcons[index]}',
                        style: TextStyle(color: Colors.white, fontSize: 30),
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