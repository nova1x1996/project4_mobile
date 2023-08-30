import 'package:flutter/material.dart';

import 'package:project_hk4_mobile/validate/validateAllFields.dart';



Widget MauInput3({
  required String label,
  required String placeholder,
  TextEditingController? controller,
  FocusNode? nextFocus,
  FocusNode? currentFocus,
  BuildContext? context,
  bool? password,
  String? kieuValidate,
  String? initialValue,
  bool readOnly = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 7,
        ),
        TextFormField(
          obscureText: (password == null) ? false : true,
          controller: controller,
          readOnly: readOnly,
          validator: (value) {
            if (kieuValidate == "password") {
              return validateAllFields().validatePassword(value!);
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
          // controller: controller,
          decoration: InputDecoration(
    
            filled: true,
            fillColor: readOnly ? Colors.grey : Colors.white,
            contentPadding: const EdgeInsets.all(10),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(width: 1, color: Colors.black)),
            labelText: placeholder,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: TextStyle(color: Colors.black26),
          ),
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
