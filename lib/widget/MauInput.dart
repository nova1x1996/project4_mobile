import 'package:flutter/material.dart';


Widget MauInput(
    {required String label,
    required String placeholder,
    required TextEditingController controller,
    FocusNode? nextFocus,
    FocusNode? currentFocus,
    BuildContext? context,
    }) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(label,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
        SizedBox(
          height: 7,
        ),
        TextField(
          focusNode: currentFocus,
          onTapOutside: (event) {
            if (context != null && nextFocus != null && currentFocus != null) {
              currentFocus.unfocus();
            }
          },
          onSubmitted: (val) {
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
            fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(10),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(width: 1, color: Colors.black)),
              labelText: placeholder,
              labelStyle: TextStyle(color: Colors.black26)),
        ),

      ],
    ),
  );
}

void _scrollTo(FocusNode focusNode) {
  Scrollable.ensureVisible(
    focusNode.context!,
    alignment:
        0.5, // Điều chỉnh giá trị này để kiểm soát vị trí của TextField trên màn hình.
    duration: Duration(milliseconds: 300),
  );
}

