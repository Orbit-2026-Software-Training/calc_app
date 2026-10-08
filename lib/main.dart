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
class StateFulCalc extends StatefulWidget{
  @override
  CalcButtons createState() => CalcButtons();
}
class CalcButtons extends State<StateFulCalc>{

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'calc application',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("calculator"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            Row(
              children: [
                FloatingActionButton(
                  onPressed: (){},
                  tooltip: "C",
                  child: Text("C"),
                  ),
                  FloatingActionButton(
                  onPressed: (){},
                  tooltip: "/",
                  child: Text("/"),
                  
                  ),
                  FloatingActionButton(
                  onPressed: (){},
                  tooltip: "+",
                  child: Text("+"),
                  ),
              ],
            ),
              Row(
                children: [
                  FloatingActionButton(
                  onPressed: (){},
                  tooltip: "-",
                  child: Text("-"),
                  ),
                  FloatingActionButton(
                  onPressed: (){},
                  tooltip: "*",
                  child: Text("*"),
                  ),
                  FloatingActionButton(
                  onPressed: (){},
                  tooltip: "⌫",
                  child: Text("C"),
                  ),
                ],
              ),
          GridView.builder(
            
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              ),
              itemBuilder: (
                BuildContext context,int index){
                  return GridTile(
                    child: FloatingActionButton(
                  onPressed: (){},
                  tooltip: '$index',
                  ),
                  );
                }
                )
                

          ]
          )
          
          )
          
          
        );
      
    
  }
}


