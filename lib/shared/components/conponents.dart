import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  required BuildContext context,
  double width = double.infinity,
  double? height,
  Color? background,
  required Function function,
  required String text,
}) =>
    // ignore: sized_box_for_whitespace
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () => function(),
      ),
    );

Widget defaultFormField({
  required TextEditingController inputController,
  required TextInputType keyboardType,
  required String labelText,
  required Function validate,
  required IconData prefix,
  Function? onChange,
  Function? onSubmit,
  bool obscureText = false,
  // IconData? suffix,
}) =>
    TextFormField(
      controller: inputController,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: (value) =>(onChange != null)? onChange(value) : null,
      onFieldSubmitted: (value) {
        if(onSubmit != null) onSubmit(value);
      },
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        // suffixIcon: Icon(suffix),
      ),
      validator: (value) => validate(value),
    );
