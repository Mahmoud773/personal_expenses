
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {

  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<StatefulWidget> createState() {
    return _NewTransactionState();
  }
}

   class _NewTransactionState extends State<NewTransaction>{
     final titleController = TextEditingController();
     final priceController = TextEditingController();
      DateTime? _selectedDate ;

     void submitData(){
       if(priceController.text.isEmpty){
         return ;
       }
       final enteredTitle = titleController.text ;
       final enteredPrice =double.parse(priceController.text)  ;

       if(enteredTitle.isEmpty || enteredPrice <= 0 || _selectedDate == null){
         return ;
       }
       widget.addTransaction(  enteredTitle, enteredPrice , _selectedDate) ;

       Navigator.of(context).pop();
     }

     // method to show date picker
     void _presentDatePicker(){
       showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime.now()
       ).then((choosenDate) {
         if (choosenDate == null) {return ;}
         setState(() {
           _selectedDate = choosenDate ;
         });

       })
       ;
     }



     @override
     Widget build(BuildContext context) {
       return SingleChildScrollView(
         child: Card( elevation : 5, child:
         Container(
           padding: EdgeInsets.only(top: 10 , left: 10 , right: 10 , bottom:MediaQuery.of(context).viewInsets.bottom + 10 ),
           color: Colors.white,
           child:  Column(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [

               TextField(decoration: InputDecoration(labelText: 'title'), keyboardType: TextInputType.text,
                 onSubmitted: (_) => submitData() ,
                 controller: titleController,) ,
               TextField(decoration: InputDecoration(labelText: 'price'), keyboardType: TextInputType.number,
                 onSubmitted: (_) => submitData()  ,controller: priceController,) ,

               Row(children: [ Expanded(
                 child: Text( _selectedDate == null ? 'No Date chosen !' :
                 "picked Date : ${DateFormat.yMd().format(_selectedDate)}" ,
                   style: TextStyle(color: Theme.of(context).primaryColor  , fontWeight:
                 FontWeight.bold),),
               ) ,
                AdaptiveFlatButton(_presentDatePicker, "choose Date")
               ],
               ),
               TextButton(child: Text('add transaction' , style: TextStyle(color: Theme.of(context).primaryColor),), onPressed:
               submitData
                 ,) ,
             ],
           ),
         ),
         ),
       ) ;
     }


   }

