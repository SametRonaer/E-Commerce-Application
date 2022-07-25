import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController? controller;
  IconData? prefixIcon;
  IconData? suffixIcon;
  String? hintText;
  String? title;
  bool? haveGap;
  bool? isLargeFied;
  bool isPassword = false;
  String? Function(String?)? validator;
  Function(String?)? onChangeFunction;
  TextInputType? textInputType;
  TextStyle? textStyle;

  CustomTextField(
      {this.controller,
      this.textInputType = TextInputType.emailAddress,
      this.prefixIcon,
      this.textStyle,
      this.onChangeFunction,
      this.suffixIcon,
      this.isLargeFied = false,
      this.hintText,
      this.haveGap = true,
      this.title,
      this.validator});

  CustomTextField.password({
    this.controller,
    this.validator,
    this.textStyle,
    this.textInputType = TextInputType.emailAddress,
    this.hintText,
    this.title,
  }) {
    this.isPassword = true;
  }

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  double? screenHeight;
  bool hideText = true;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return widget.isPassword
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: double.infinity, height: 10),
              if (widget.title != null)
                Text(
                  widget.title!,
                  style: widget.textStyle ??
                      TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                ),
              if (widget.title != null)
                SizedBox(width: double.infinity, height: 3),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  TextFormField(
                      keyboardType: widget.textInputType,
                      validator: widget.validator,
                      controller: widget.controller,
                      obscureText: hideText,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey.shade700,
                          ),
                          suffixIcon: IconButton(
                              padding: EdgeInsets.all(0),
                              onPressed: (() {
                                setState(() {
                                  hideText = !hideText;
                                });
                              }),
                              icon: Icon(
                                hideText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.blue.shade900,
                              )),
                          hintText: widget.hintText ?? "Enter your password",
                          hintStyle: TextStyle(
                              color: Colors.grey.shade400, fontSize: 12),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ))),
                ],
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.haveGap!) SizedBox(width: double.infinity, height: 10),
              if (widget.title != null)
                Text(
                  widget.title!,
                  style: widget.textStyle ??
                      TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                ),
              if (widget.title != null)
                SizedBox(width: double.infinity, height: 3),
              Stack(
                alignment: widget.isLargeFied!
                    ? Alignment.topCenter
                    : Alignment.bottomCenter,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    height: widget.isLargeFied! ? 200 : 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: TextFormField(
                        onChanged: widget.onChangeFunction,
                        maxLines: widget.isLargeFied! ? 10 : 1,
                        keyboardType: widget.textInputType,
                        validator: widget.validator,
                        controller: widget.controller,
                        decoration: InputDecoration(
                            prefixIcon: widget.prefixIcon != null
                                ? Icon(
                                    widget.prefixIcon,
                                    color: Colors.grey.shade700,
                                  )
                                : null,
                            suffixIcon: widget.suffixIcon != null
                                ? Icon(
                                    widget.suffixIcon,
                                    color: Colors.grey.shade700,
                                  )
                                : null,
                            hintText: widget.hintText,
                            hintStyle: TextStyle(
                                color: Colors.grey.shade400, fontSize: 15),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ))),
                  ),
                ],
              ),
            ],
          );
  }
}
