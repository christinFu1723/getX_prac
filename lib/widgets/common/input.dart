import 'package:flutter/material.dart';
import 'package:demo7_pro/config/theme.dart' show AppTheme;

/// input
class InputForm extends StatefulWidget {
  final Function onTap;
  final String hintStr;
  final int maxLength;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function validatorFn;
  final Function onChange;
  final String initVal;
  final TextAlign textAlign;
  final bool enabled;
  final InputDecoration inputDecoration;
  final bool isCollapsed;

  InputForm(
      {Key key,
      @required this.controller,
      @required this.validatorFn,
      @required this.onChange,
      this.enabled,
      this.textAlign,
      this.onTap,
      this.hintStr,
      this.maxLength,
      this.readOnly,
      this.keyboardType,
      this.initVal = '',
      this.inputDecoration,
      this.isCollapsed});

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  @override
  void initState() {
    // TODO: implement initState
    if (widget.initVal != null &&
        widget.initVal != '' &&
        widget.controller != null) {
      widget.controller.text = widget.initVal;
    }
    super.initState();
  }

  @override
  didUpdateWidget(InputForm oldWidget) {
    if (widget.initVal != null &&
        widget.initVal != '' &&
        widget.controller != null) {
      Future.delayed(Duration(milliseconds: 100)).then((e) {
        widget.controller.text = widget.initVal;
      });

    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: widget.enabled ?? true,
        maxLength: widget.maxLength,
        textAlign: widget.textAlign ?? TextAlign.right,
        controller: widget.controller,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        readOnly: widget.readOnly ?? false,
        style: TextStyle(
            color: widget.readOnly ?? false
                ? AppTheme.placeholderColor
                : AppTheme.titleColor),
        decoration: widget.inputDecoration ??
            InputDecoration(
              errorText: '',
              // ?????????????????????
              errorStyle: TextStyle(color: Colors.transparent, height: 0),
              // ?????????????????????
              counterText: "",
              // ????????????????????????????????????
              isCollapsed: widget.isCollapsed ?? false,
              border: InputBorder.none,
              labelStyle: TextStyle(
                  color: widget.readOnly ?? false
                      ? AppTheme.placeholderColor
                      : AppTheme.titleColor),
              hintText: widget.hintStr,
              hintStyle: TextStyle(
                  color: AppTheme.placeholderColor,
                  fontSize: AppTheme.fontSizeSmall),
              hintTextDirection: TextDirection.rtl,
            ),
        validator: widget.validatorFn,
        autovalidate: true,
        enableSuggestions: false,
        onTap: widget.onTap,
        onChanged: widget.onChange);
  }
}
