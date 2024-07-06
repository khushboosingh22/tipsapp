import 'package:app2/widgets/bill_amount_field.dart';
import 'package:app2/widgets/person_counter.dart';
import 'package:flutter/material.dart';
import 'package:app2/widgets/tip_slider.dart';
 class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
} 

class _HomePageState extends State<HomePage> {
  int _personCount=1;
  
  double _tipPercentage=0.0;
  double _billTotal=0.0;

  double totalPerPerson(){
    return ((_billTotal*_tipPercentage)+(_billTotal))/_personCount;
  }

  double totalTip(){
    return ((_billTotal*_tipPercentage)+(_billTotal));
  }
  //method
  void increment(){
    setState(() {
      _personCount=_personCount+1;
    });
  }
  void decrement(){
    setState(() {
      if(_personCount>1){ 
      _personCount--;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
  var theme=Theme.of(context);
  double total=totalPerPerson();
  double totalT=totalTip();
  final style=theme.textTheme.titleMedium!.copyWith( 
    color:theme.colorScheme.onPrimary,
    fontWeight: FontWeight.bold,
  );
    return Scaffold( 
        appBar: AppBar(
          title:const Text("Utip App"),
      ),
      body:Column( 
      crossAxisAlignment: CrossAxisAlignment.stretch,  
        children: [ 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration( 
                color:Theme.of(context).colorScheme.inversePrimary,
                // color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                 Text("Total per person",
                 style:style.copyWith( 
                  color:theme.colorScheme.onPrimary,
                  // fontSize:theme.textTheme.bodyMedium!.fontSize,
                 ),
                 ),
                 Text(total.toStringAsFixed(2),
                 style:style.copyWith( 
                  fontSize:theme.textTheme.bodySmall!.fontSize,
                 ),
                 ),
                ],
              ),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container( 
              padding: const EdgeInsets.all(20),
              // width:100,
              // height:100,
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.circular(5),
                border:Border.all(color:theme.colorScheme.primary,width:2),
              ),
              child: Column( 
                children:[ 
                 BillAmountField(billAmount:_billTotal.toString(), 
                 onChanged: (value) { 
                  setState(() {
                  _billTotal=double.parse(value);
                  });
                  
                  },
            ),
                     PersonCounter(theme: theme,
                      personCount: _personCount,
                      onIncrement: increment,
                      ondecrement: decrement,
                      ),

                      // ==tip section==
                      Row( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                         Text("Tip",
                         style:theme.textTheme.titleMedium),
                         Text("$totalT",
                         style:theme.textTheme.titleMedium),
                        ],
                      ),

                      // ==slider text==
                     Text('${(_tipPercentage *100).round()}%'),

                      // ==tip slider==
                      TipPercentage(tipPercentage: _tipPercentage, onChanged: (double value) { setState(() {
                        _tipPercentage = value;
                      }); },),
                ]
                  
              ),
            ),
          )
        ],
      ),
    
    ); 
  }
}

