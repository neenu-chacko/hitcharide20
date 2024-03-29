import 'package:flutter/material.dart';

class TaxiButtonDriver extends StatelessWidget {
  final String title;
  final Color color;
  final Function onPressed;

  TaxiButtonDriver({this.title, this.onPressed, this.color});


  @override
  Widget build(BuildContext context) {
    return RaisedButton(   // The Register Button
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(25),
      ),
      color:color,
      textColor: Colors.white,
      child:Container(
        height:50,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18,
            fontFamily: 'Brand-Bold')
          ),
        ),
      ),
      
      onPressed: onPressed,
    );
}
}