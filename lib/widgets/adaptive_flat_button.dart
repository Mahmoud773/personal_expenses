
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget{
  final String text ;
  final VoidCallback handler ;
  AdaptiveFlatButton(this.handler , this.text) ;
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? CupertinoButton(child: Text(
        text ,
        style:
    TextStyle(color: Theme.of(context).primaryColor
        , fontWeight:
        FontWeight.bold)),

        onPressed: handler)
        : TextButton( child: Text('choose a date' , style: TextStyle(color: Theme.of(context).primaryColor  , fontWeight:
    FontWeight.bold)) , onPressed: handler
      ,);
  }

}