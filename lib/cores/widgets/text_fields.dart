import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/theme/color_pellets.dart';

double parseDouble(String? value) {
  return double.tryParse(value?.trim() ?? '') ?? 0;
}

class DefaultTextFormField extends StatefulWidget {
  const DefaultTextFormField({
    super.key,
    required this.textController,
    this.label,
    this.textInputType,
    this.onChanged,
    this.readOnly = false,
    this.suffix,
    this.onTap,
    this.textInputAction = TextInputAction.next,
    this.isIgnore = false,
    this.prefix,
    this.maxLine,
    this.isObscure = false,
    this.isValidate = false,
  });

  final TextEditingController textController;
  final Function? onChanged, onTap;
  final String? label;
  final TextInputType? textInputType;
  final bool readOnly;
  final bool isValidate;
  final bool? isIgnore, isObscure;
  final int? maxLine;
  final IconData? suffix;
  final IconData? prefix;
  final TextInputAction? textInputAction;

  @override
  DefaultTextFormFieldState createState() => DefaultTextFormFieldState();
}

class DefaultTextFormFieldState extends State<DefaultTextFormField> {
  @override
  void initState() {
    super.initState();
    widget.textController.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.textController.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    setState(() {});
  }

  String? validaterMandatory(String? value) {
    final parsedValue = parseDouble(value);
    if (value == null || value.isEmpty) {
      return 'Required Field';
    } else if (parsedValue < 0) {
      return '-ve value not permitted';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    bool hasValue = widget.textController.text.isNotEmpty;

    return IgnorePointer(
      ignoring: widget.isIgnore!,
      child: TextFormField(
        obscureText: widget.isObscure!,
        onTap: () {
          widget.textController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: widget.textController.text.length,
          );
          widget.onTap?.call();
        },
        validator: widget.isValidate
            ? widget.label == 'Email'
                ? emailValidator
                : validaterMandatory
            : null,
        readOnly: widget.readOnly,
        textInputAction: widget.textInputAction,
        keyboardType: widget.textInputType,
        controller: widget.textController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: widget.maxLine == null
            ? const TextStyle(
                fontSize: 13,
              )
            : null,
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        maxLines: widget.maxLine ?? 1,
        decoration: InputDecoration(
          prefix: widget.prefix != null
              ? Icon(
                  widget.prefix,
                  size: 15,
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
                color: hasValue ? AppPallete.enabledGreen : Colors.grey),
          ),
          hintText: widget.readOnly ? widget.label : 'Enter ${widget.label}',
          suffix: widget.suffix == null ? null : Icon(widget.suffix),
          label: Text(
            widget.label ?? '',
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
