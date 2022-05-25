import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../general/colors.dart';

class InputTextFieldWidget extends StatelessWidget {

  String txtName;
  String iconPath;
  int? maxLength;
  TextInputType? textInputType;
  List<FilteringTextInputFormatter>? inputFormatters;
  bool isDNI;
  TextEditingController txtController;

  InputTextFieldWidget({required this.txtController,required this.txtName, required this.iconPath, this.maxLength, this.textInputType, this.inputFormatters,required this.isDNI,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.0,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$txtName:",
            style: TextStyle(
              color: kFontPrimaryColor.withOpacity(0.6),
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.06),
                  offset: const Offset(4, 4),
                  blurRadius: 12.0,),
              ],
            ),
            child: TextFormField(
              controller: txtController,
              maxLength: isDNI ? 8 : null,
              keyboardType: isDNI ? TextInputType.number : null,
              inputFormatters: isDNI ? [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]'),
                ),
              ] : [],
              decoration: InputDecoration(
                counterText: "",
                filled: true,
                fillColor: Colors.white,
                hintText: txtName,
                hintStyle: TextStyle(
                  fontSize: 13.0,
                  color: kFontPrimaryColor.withOpacity(0.4),
                ),
                prefixIcon: SvgPicture.asset(
                  iconPath,
                  height: 12.0,
                  fit: BoxFit.scaleDown,
                  color: kFontPrimaryColor.withOpacity(0.4),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
              //Todo lo que se ingresa al campo es el value
              validator: (value){
                if(value!.isEmpty){
                  return "El campo es obligatorio";
                }

                if(isDNI && value.length < 8){
                  return "El DNI necesita 8 numeros";
                }

                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
