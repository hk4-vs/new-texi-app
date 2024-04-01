import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatefulWidget {
  const MyTextFieldWidget({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.focusNode,
    this.validator,
  });

  final String hintText;
  final Widget? prefixIcon;
  final bool? isPassword;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String?)? validator;

  @override
  State<MyTextFieldWidget> createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {
  bool isVisiable = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword! ? !isVisiable : false,
      validator: (value) => widget.validator!(value),
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: widget.hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10),
          child: widget.prefixIcon,
        ),
        suffixIcon: widget.isPassword!
            ? GestureDetector(
                onTap: () => setState(() => isVisiable = !isVisiable),
                child:
                    Icon(isVisiable ? Icons.visibility : Icons.visibility_off))
            : const SizedBox(
                height: 0.0,
                width: 0.0,
              ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none),
      ),
    );
  }
}
