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
List<String> buttonsIcons = ["÷", "-", "*", "+", "⌫", "=", "C",".", "0","1", "2", "3", "4", "5", "6", "7", "8", "9"];
List<String>numbers=[];
List<num>intNumbers=[];
List<String>operations=[];
String stringNum="";
num result=0;
List<String>history=[];
List<num>results=[];
List<String>dataHistory=[];
String historyData ="";
String calcWay = "";
List<String>result1=[];
void onButtonPressed(int whichButton){
  setState(() {
  if(whichButton>=7){
    numbers.add(buttonsIcons[whichButton]);
    stringNum=stringNum+buttonsIcons[whichButton];
  }
  if(whichButton<=3){
    numbers.add(buttonsIcons[whichButton]);
    intNumbers.add(num.parse(stringNum));
    operations.add(buttonsIcons[whichButton]);
    dataHistory.add(stringNum);
    stringNum="";
    dataHistory.add(buttonsIcons[whichButton]);
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
    dataHistory.add(stringNum);

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
    historyData=dataHistory.join();
    dataHistory.clear();
    dataHistory.add(
      historyData
    );
    historyData="";
    numbers.clear();
    numbers.add(results.last.toString());
    result1.add(results.last.toString());
    if(result1[0]=="Infinity"){
      result1=["error"];
      history.add(result1.toString());
    }
    else{
      history.add(result1.toString());
    }
    
  }
  });

}
void historyDelete(){
  setState(() {
    history.clear();
  });
  
}
  Widget build(BuildContext context) {
      return Scaffold(
        drawer: Drawer(
          child: Column(
          children: [
            Flexible(
              child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (BuildContext context,int index){
              return ListTile(
                title: Text(dataHistory[index]+"="+history[index]),
                
              );
            }
              ),
            ),
            FloatingActionButton(
            onPressed: historyDelete,
            backgroundColor: Colors.blueGrey,
            child: Icon(Icons.delete),
            ),
            ]
          ),
        ),
       
            
        
        appBar: AppBar(
          title: const Text("calculator"),
        ),
        body: Center(
        child: Column(
          children:[
            Container(
              child: Text(
                numbers.join(),
                style: TextStyle(fontSize: 30,
                color: Colors.black,
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
          ]
        )
        )     
      );   
  }
}


