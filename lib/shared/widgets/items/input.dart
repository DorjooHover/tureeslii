import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tureeslii/shared/constants/colors.dart';

class Input extends StatelessWidget {
  const Input(
      {super.key,
      this.controller,
      this.maxLine,
      this.onSubmitted,
      this.value,
      this.autoFocus = false,
      this.textInputAction = TextInputAction.done,
      this.obscureText = false,
      this.textInputType = TextInputType.text,
      this.suffixIcon,
      this.labelText,
      this.validator,
      this.inputFormatter ,
      this.borderSide = const BorderSide(color: divider),
      this.onChange});
  final TextEditingController? controller;
  final Function(String)? onSubmitted;
  final String? value;
  final bool autoFocus;
  final int? maxLine;
  final TextInputAction textInputAction;
  final bool obscureText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final String? labelText;
  final String? Function(String?)? validator;
  final Function(String)? onChange;
  final BorderSide borderSide;
  final List<TextInputFormatter>? inputFormatter;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,

      onFieldSubmitted: onSubmitted,
      autofocus: autoFocus,
      textInputAction: textInputAction,
      // focusNode: focusNode ?? focusNode
      maxLines: maxLine,
      enableSuggestions: false,
      obscureText: obscureText,

      keyboardType: textInputType,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: gray),
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
        
        isDense: true,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: gray),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: gray),
        ),
        suffixIcon: suffixIcon ?? suffixIcon,
        contentPadding: const EdgeInsets.all(13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: borderSide,
        ),
        filled: true,
        fillColor: Colors.white,
        // labelText: labelText,

        hintText: labelText,
        errorMaxLines: 2,
        hintStyle:
            Theme.of(context).textTheme.displayMedium!.copyWith(color: gray),
      ),
      controller: controller ?? controller,
      validator: validator ?? validator,
      onChanged: onChange,
    );
  }
}
