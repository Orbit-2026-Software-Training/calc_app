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
List<String> buttonsIcons = ["÷", "-", "*", "+", "⌫", "=", "C", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
List<String>numbers=[];
List<num>intNumbers=[];
List<String>operations=[];
String stringNum="";
num result=0;
List<String>history=[];
List<num>results=[];
void onButtonPressed(int whichButton){
  setState(() {
  if(whichButton>=7){
    numbers.add(buttonsIcons[whichButton]);
    stringNum=stringNum+buttonsIcons[whichButton];
  }
  if(whichButton<=3){
    numbers.add(buttonsIcons[whichButton]);
    intNumbers.add(int.parse(stringNum));
    stringNum="";
    operations.add(buttonsIcons[whichButton]);
  }
  if(whichButton==4){
    numbers.removeLast();
  }
  if(whichButton==6){
    numbers.clear();
    intNumbers.clear();
    operations.clear();
    stringNum="";
  }
  if(whichButton==5){
    operations.add("=");
    intNumbers.add(int.parse(stringNum));
    if(operations.contains("÷")||operations.contains("*")){
      for(int i=0;i<operations.length;i++){
        if(operations[i]=="÷"){
          result=intNumbers[i]/intNumbers[i+1];
          results.add(result);
          intNumbers[i]=result;
          intNumbers.removeAt(i+1);
          operations.removeAt(i);
          i--;
        }
        if(operations[i]=="*"){
          result=intNumbers[i]*intNumbers[i+1];
          results.add(result);
          intNumbers[i]=result;
          intNumbers.removeAt(i+1);
          operations.removeAt(i);
          i--;
        }
      }
    }
    for(int i=0;i<operations.length;i++){
        if(operations[i]=="+"){
          result=intNumbers[i]+intNumbers[i+1];
          results.add(result);
          intNumbers[i]=result;
          intNumbers.removeAt(i+1);
          operations.removeAt(i);
          i--;
        }
        if(operations[i]=="-"){
          result=intNumbers[i]-intNumbers[i+1];
          results.add(result);
          intNumbers[i]=result;
          intNumbers.removeAt(i+1);
          operations.removeAt(i); 
          i--;
        }
    }
    numbers.clear();
    history.clear();
    history.add(results.toString());
    numbers.add(results.last.toString());
  }
  });

}
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("calculator"),
        ),
        body: Column(
          children:[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text(
                numbers.join(),
                style: TextStyle(fontSize: 30,
                color: Colors.white,
                )
              ),
            ),
          SizedBox(
            width: 400,
            height: 400,
            child: GridView.builder(
            itemCount: buttonsIcons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              ),
              itemBuilder: (
                BuildContext context,int index){
                  return GridTile(
                  child: FloatingActionButton(
                  onPressed: (){
                    
                      onButtonPressed(index);
                      
                    
                  },
                  tooltip: '${buttonsIcons[index]}',
                  child: Text('${buttonsIcons[index]}')
                  ),
                  );
                }
                ),
                
                
        ),
        Container(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child:Column(
                children: [
                  Text(
                    "history",
                    style: TextStyle(fontSize: 30,
                    color: Colors.white,
                    )
                  ),
                
               Text(
                history.join(),
                style: TextStyle(fontSize: 30,
                color: Colors.white,
                )
              ),
              ],
            ),
        )
          ]
          
        
        )
      );
          
      
          
          
                

          
          
          
          
          
        
      
    
  }
}


