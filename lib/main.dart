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
List<String> buttonsIcons = ["÷",".", "=", "C", "⌫", "+", "-", "*", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("calculator"),
        ),
        body: Center(
          child: SizedBox(
            width: 100,
            height: 200,
            child: GridView.builder(
            itemCount: buttonsIcons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              ),
              itemBuilder: (
                BuildContext context,int index){
                  return GridTile(
                  child: FloatingActionButton(
                  onPressed: (){},
                  tooltip: '${buttonsIcons[index]}',
                  child: Text('${buttonsIcons[index]}')
                  ),
                  );
                }
                )
          )
        ),
          );
          
          
                

          
          
          
          
          
        
      
    
  }
}


