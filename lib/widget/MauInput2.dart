import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/validate/validateAllFields.dart';

import '../const/const.dart';


Widget MauInput2(
    {required String label,
    required String placeholder,
    required TextEditingController controller,
    FocusNode? nextFocus,
    FocusNode? currentFocus,
    BuildContext? context,
      bool? password,
    String? kieuValidate

    }) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: labelInput,fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 7,
        ),
        TextFormField(
          obscureText: (password == null) ? false: true,
          validator: (value) {
            if (kieuValidate == "email") {
              return validateAllFields().validateEmail(value!);
            } else if (kieuValidate == "password") {
              return validateAllFields().validatePassword(value!);
            } else if (kieuValidate == "username") {
              return validateAllFields().validateUsername(value!);
            } else if (kieuValidate == "fullname") {
              return validateAllFields().validateFullname(value!);
            } else if (kieuValidate == "phone") {
              return validateAllFields().validatePhone(value!);
            } else if (kieuValidate == "passwordLogin") {
              return validateAllFields().validatePasswordLogin(value!);
            }
            return null;
          },
          focusNode: currentFocus,
          onTapOutside: (event) {
            if (context != null && nextFocus != null && currentFocus != null) {
              currentFocus.unfocus();
            }
          },
          onFieldSubmitted: (val) {
            if (context != null && nextFocus != null && currentFocus != null) {
              currentFocus.unfocus();
              FocusScope.of(context!).requestFocus(nextFocus);
              _scrollTo(nextFocus);
            }
          },
          controller: controller,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: backgroundInput,
              contentPadding: const EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: colorBoderInput)),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
           ),
              labelText: placeholder,
              labelStyle: TextStyle(color: placeholderInput)),
        ),
      ],
    ),
  );
}

void _scrollTo(FocusNode focusNode) {
  Scrollable.ensureVisible(
    focusNode.context!,
    alignment: 0.5,
    // Điều chỉnh giá trị này để kiểm soát vị trí của TextField trên màn hình.
    duration: Duration(milliseconds: 300),
  );
}
