import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() {

// first commit

// this is mistake
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'personal expenses',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.green)
        ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}
class MyHomePageState extends State<MyHomePage>{

  final List<Transaction> _userTransactions =[
   // Transaction(id: "t1", title: "shoes" , price:  99.99 , date: DateTime.now() ),
   // Transaction(id: "t2", title: "shirt" , price:  100.99 , date: DateTime.now() )
  ];

  bool _showChart = false ;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return  element.date.isAfter(DateTime.now().subtract(Duration(days: 7) ,
      ) ,
      ) ;
    }).toList() ;
  }

  void _addNewTransaction(String txTitle , double txPrice , DateTime choosenDate){
    final newTransaction = Transaction(id:  DateTime.now().toString(), title: txTitle , price:  txPrice , date: choosenDate ) ;
    setState(() {
      _userTransactions.add(newTransaction) ;
    });

  }
  void _startAddNewTransaction( BuildContext context){
    showModalBottomSheet(context: context, builder: (_) {
      return GestureDetector( onTap :() {}
          ,child:  NewTransaction(_addNewTransaction) ,
        behavior: HitTestBehavior.opaque,
      );
    } ,) ;
  }

  // delete transaction
  void deleteTransaction( String id){
    setState(() {
      _userTransactions.removeWhere((element)  {
        return element.id == id ;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context) ;
    final isLandscape = mediaQuery.orientation == Orientation.landscape ;
    final   appBar =
    //Platform.isIOS ? CupertinoNavigationBar(
     // middle: Text('personal expense') ,
      //trailing: Row(  mainAxisSize: MainAxisSize.min,
      //  children: [
       // GestureDetector(child: Icon(CupertinoIcons.add),
       //   onTap:  () => _startAddNewTransaction(context), )
     // ],),
    //)
         AppBar(
      title: Text('personal expense'),
      actions: [
        IconButton(icon: Icon(Icons.add), onPressed: () => _startAddNewTransaction(context),)
      ],
    );

    final txListWidget = Container(height: (mediaQuery.size.height - appBar.preferredSize.height
        - mediaQuery.padding.top) *0.7 ,
        child: TransactionList(_userTransactions , deleteTransaction)) ;

    final pageBody =  SafeArea(child:  SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start ,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children :<Widget>[
          if(isLandscape) Row(
            mainAxisAlignment : MainAxisAlignment.center,
            children: [
              Text('show Chart'),
              Switch.adaptive(value: _showChart, onChanged: (onChanged){
                setState(() {
                  _showChart = onChanged ;
                });
              })
            ],),
          if(!isLandscape) Container( height: (mediaQuery.size.height - appBar.preferredSize.height
              - mediaQuery.padding.top) *0.3
              , child: Chart(_recentTransactions)) ,
          if(!isLandscape) txListWidget ,

          // if we in landscape we should show either chart or tx list based on switch enable or disable
          if(isLandscape) _showChart ?
          Container( height: (mediaQuery.size.height - appBar.preferredSize.height
              - mediaQuery.padding.top) *0.7
              , child: Chart(_recentTransactions))
              :  txListWidget
        ],
      ),

    )) ;

    return  Platform.isIOS ? CupertinoPageScaffold(child: pageBody)
        :
    Scaffold(
      appBar: appBar ,
      body: pageBody ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS?
      Container()
      :FloatingActionButton(onPressed: () => _startAddNewTransaction(context),
          child: Icon(Icons.add)
      ),

    );
  }
}
