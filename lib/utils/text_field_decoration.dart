import 'package:flutter/material.dart';

class TextFieldDecoration{




                  static decoration({String? hintTxt, helperText}){
                    return InputDecoration(
                    border:const OutlineInputBorder(borderSide: BorderSide(),),
                        focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pinkAccent, width: 1.0),
            ),
            enabledBorder:const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
                    
                    hintText:hintTxt ?? '',
                    helperText: helperText ?? ''
                  );
                  }
}