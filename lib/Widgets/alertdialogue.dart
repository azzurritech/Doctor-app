import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension showdialog on  BuildContext{
  Future<void> showerrordialogue(String error){
    return showDialog(context: this, builder: (BuildContext context){
      return AlertDialog(title: Text(""), content: Text(error), actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("Ok"),
        )
      ],);
    });
  }
}