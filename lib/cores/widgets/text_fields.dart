import 'package:flutter/material.dart';

double parseDouble(String? value) {
  return double.tryParse(value?.trim() ?? '') ?? 0;
}

class DefaultTextFormField extends StatelessWidget {
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
    return IgnorePointer(
      ignoring: isIgnore!,
      child: TextFormField(
        obscureText: isObscure!,
        onTap: () {
          textController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: textController.text.length,
          );
          onTap?.call();
        },
        validator: isValidate
            ? label == 'Email'
                ? emailValidator
                : validaterMandatory
            : null,
        readOnly: readOnly,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        controller: textController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: maxLine == null
            ? const TextStyle(
                fontSize: 13,
              )
            : null,
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        maxLines: maxLine ?? 1,
        decoration: InputDecoration(
            prefix: prefix != null
                ? Icon(
                    prefix,
                    size: 15,
                  )
                : null,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            hintText: readOnly ? label : 'Enter $label',
            suffix: suffix == null ? null : Icon(suffix),
            label: Text(
              label ?? '',
              style: const TextStyle(fontSize: 12),
            )),
      ),
    );
  }
}
