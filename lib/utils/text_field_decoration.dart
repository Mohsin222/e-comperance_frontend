import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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



                  //home screen textfield decoration

                  static homeTextFieldDecoration({String? hintText}){
                    return InputDecoration(
                      hintText: hintText,
               prefix:  Icon(Icons.search,color: Colors.black,),
   
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle:  TextStyle(fontSize: 15.sp),
                      //  border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.white,
                      //  ),),
                          contentPadding: EdgeInsets.all(10.0),
                           enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width:1, color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                )
                       
                    );
                
                  }
}