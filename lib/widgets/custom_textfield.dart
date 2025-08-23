import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:physiotherapy/res/res.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    this.focusNode,
    this.autoFocus = false,
    this.textEditingController,
    this.isObscureText = false,
    this.obscureCharacter = '●',
    this.textCapitalization = TextCapitalization.none,
    this.isFilled,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 15,
    ),
    this.fillColor,
    this.hintText,
    this.hintStyle,
    this.errorStyle,
    this.formBorder,
    this.focusedBorder,
    this.errorText,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.formStyle,
    required this.onChange,
    this.isReadOnly = false,
    this.onTap,
    this.errorBorder,
    this.inputFormatters,
    this.maxLength = TextField.noMaxLength,
    this.onEditingComplete,
    this.initialValue,
    this.cursorColor,
    this.maxlines = 1,
    this.enabled = true,
    this.validator,
    this.textAlign,
    this.autocorrect = true,
    this.labelText,
    this.disabledBorder,
  });

  final FocusNode? focusNode;
  final bool autoFocus;
  final bool autocorrect;
  final TextEditingController? textEditingController;
  final bool isObscureText;
  final String obscureCharacter;
  final TextCapitalization textCapitalization;
  final bool? isFilled;
  final EdgeInsets contentPadding;
  final Color? fillColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final OutlineInputBorder? formBorder;
  final OutlineInputBorder? disabledBorder;
  final String? errorText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final TextStyle? formStyle;
  final void Function(String value) onChange;
  final bool isReadOnly;
  final Function()? onTap;
  final InputBorder? errorBorder;
  final List<TextInputFormatter>? inputFormatters;
  final OutlineInputBorder? focusedBorder;
  final Function()? onEditingComplete;
  final int? maxLength;
  final String? initialValue;
  final Color? cursorColor;
  final int? maxlines;
  final bool? enabled;
  final String? Function(String?)? validator;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      FocusScope.of(context).unfocus();
    },
    child: TextFormField(
      onTap: onTap,
      style: Styles.black14,
      readOnly: isReadOnly,
      obscureText: isObscureText,
      obscuringCharacter: obscureCharacter,
      cursorColor: cursorColor ?? ColorsValue.primaryColor,
      keyboardType: textInputType,
      controller: textEditingController,
      onChanged: onChange,
      validator: validator,
      inputFormatters: inputFormatters,
      autocorrect: autocorrect,
      textInputAction: textInputAction,
      autofocus: autoFocus,
      maxLength: maxLength,
      maxLines: maxlines,
      textCapitalization: textCapitalization,
      enabled: enabled,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        contentPadding: contentPadding,
        hintText: '$hintText',
        hintStyle: hintStyle ?? Styles.grey14,
        suffixIcon: suffixIcon,
        suffixIconColor: ColorsValue.primaryColor,
        labelText: labelText,
        labelStyle: hintStyle ?? Styles.grey14,
        floatingLabelStyle: Styles.black14.copyWith(
          color: ColorsValue.primaryColor,
        ),
        alignLabelWithHint: true,
        counterText: '',
        filled: isFilled,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(Dimens.ten),
        ),
        disabledBorder: disabledBorder,
        enabledBorder:
            formBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.withValues(alpha: .3),
                width: Dimens.one,
              ),
              borderRadius: BorderRadius.circular(Dimens.ten),
            ),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsValue.primaryColor,
                width: Dimens.one,
              ),
              borderRadius: BorderRadius.circular(Dimens.ten),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(Dimens.ten),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: Dimens.one),
          borderRadius: BorderRadius.circular(Dimens.ten),
        ),
      ),
    ),
  );
}
