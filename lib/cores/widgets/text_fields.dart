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
    this.isBorder = true,
    this.isValidate = false,
  });

  final TextEditingController textController;

  final Function? onChanged, onTap;
  final String? label;
  final TextInputType? textInputType;
  final bool readOnly;
  final bool isValidate;
  final bool? isIgnore, isBorder;
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

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isIgnore!,
      child: TextFormField(
        onTap: () {
          textController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: textController.text.length,
          );
          onTap?.call();
        },
        validator: isValidate ? validaterMandatory : null,
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
            border: isBorder == false
                ? null
                : const OutlineInputBorder(
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

class UnderlinedTextFormField extends StatelessWidget {
  const UnderlinedTextFormField({
    super.key,
    required this.textController,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.validator,
  });
  final bool? readOnly;

  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final void Function()? onTap;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        onTap: () {
          textController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: textController.text.length,
          );
          onTap?.call();
        },
        readOnly: readOnly!,
        validator: validator,
        keyboardType: TextInputType.number,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        controller: textController,
        style: const TextStyle(fontSize: 10),
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
      ),
    );
  }
}
