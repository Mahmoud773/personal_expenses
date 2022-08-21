import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';


class TransactionList extends StatelessWidget {
  final Function deleteTransaction ;
  final List<Transaction> _userTransactions ;
  TransactionList(this._userTransactions , this.deleteTransaction) ;


  @override
  Widget build(BuildContext context) {
return Container(  height :450 ,
  child : _userTransactions.isEmpty ? LayoutBuilder(builder: (ctx , constraints) {
    return Column(children: [
      Text('there is no transactions yet'),
      SizedBox(height: 10,) ,
      Container( height :constraints.maxHeight *0.6
          ,child: Image.asset('assets/images/waiting.png' , fit: BoxFit.cover)
      ),


    ],) ;

  },)

    :
    ListView.builder(
    itemBuilder: (context , index){
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8 , horizontal: 8),
      child: ListTile( leading: CircleAvatar(
        radius: 30,
        child: Padding(
          padding:  EdgeInsets.all(6),
          child: FittedBox(child: Text('\$ ${_userTransactions[index].price}')),
        ),
      ),
        title: Text(_userTransactions[index].title , style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        subtitle: Text(DateFormat.yMMMd().format(_userTransactions[index].date)
        ),
        trailing: MediaQuery.of(context).size.width >460 ? TextButton.icon(
            onPressed: () => deleteTransaction(_userTransactions[index].id),
            icon: Icon(Icons.delete), label: Text('Delete') ,
        )
        :IconButton(icon: Icon(Icons.delete),
        color: Theme.of(context).errorColor,
        onPressed: () => deleteTransaction(_userTransactions[index].id), ),
      ),
    );


  } ,  // itemBuilder
  itemCount: _userTransactions.length,
  )
)
 ;
throw UnimplementedError();
  }

  }

