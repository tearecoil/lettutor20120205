import 'package:flutter/material.dart';

class MergeInputDecoration {
  static InputDecoration merge(
      InputDecoration input1, InputDecoration? input2) {
    if (input2 == null) {
      return input1;
    }
    return input1.copyWith(
      alignLabelWithHint:
          input2.alignLabelWithHint ?? input1.alignLabelWithHint,
      border: input2.border ?? input1.border,
      constraints: input2.constraints ?? input1.constraints,
      contentPadding: input2.contentPadding ?? input1.contentPadding,
      counter: input2.counter ?? input1.counter,
      counterStyle: input2.counterStyle ?? input1.counterStyle,
      counterText: input2.counterText ?? input1.counterText,
      disabledBorder: input2.disabledBorder ?? input1.disabledBorder,
      enabled: input2.enabled,
      enabledBorder: input2.enabledBorder ?? input1.enabledBorder,
      errorBorder: input2.errorBorder ?? input1.errorBorder,
      errorMaxLines: input2.errorMaxLines ?? input1.errorMaxLines,
      errorStyle: input2.errorStyle ?? input1.errorStyle,
      errorText: input2.errorText ?? input1.errorText,
      fillColor: input2.fillColor ?? input1.fillColor,
      filled: input2.filled ?? input1.filled,
      floatingLabelBehavior:
          input2.floatingLabelBehavior ?? input1.floatingLabelBehavior,
      floatingLabelStyle:
          input2.floatingLabelStyle ?? input1.floatingLabelStyle,
      focusColor: input2.focusColor ?? input1.focusColor,
      focusedBorder: input2.focusedBorder ?? input1.focusedBorder,
      focusedErrorBorder:
          input2.focusedErrorBorder ?? input1.focusedErrorBorder,
      helperMaxLines: input2.helperMaxLines ?? input1.helperMaxLines,
      helperStyle: input2.helperStyle ?? input1.helperStyle,
      helperText: input2.helperText ?? input1.helperText,
      hintMaxLines: input2.hintMaxLines ?? input1.hintMaxLines,
      hintStyle: input2.hintStyle ?? input1.hintStyle,
      hintText: input2.hintText ?? input1.hintText,
      hintTextDirection: input2.hintTextDirection ?? input1.hintTextDirection,
      hoverColor: input2.hoverColor ?? input1.hoverColor,
      icon: input2.icon ?? input1.icon,
      iconColor: input2.iconColor ?? input1.iconColor,
      isCollapsed: input2.isCollapsed,
      isDense: input2.isDense ?? input1.isDense,
      label: input2.label ?? input1.label,
      labelStyle: input2.labelStyle ?? input1.labelStyle,
      labelText: input2.labelText ?? input1.labelText,
      prefix: input2.prefix ?? input1.prefix,
      prefixIcon: input2.prefixIcon ?? input1.prefixIcon,
      prefixIconColor: input2.prefixIconColor ?? input1.prefixIconColor,
      prefixIconConstraints:
          input2.prefixIconConstraints ?? input1.prefixIconConstraints,
      prefixStyle: input2.prefixStyle ?? input1.prefixStyle,
      prefixText: input2.prefixText ?? input1.prefixText,
      semanticCounterText:
          input2.semanticCounterText ?? input1.semanticCounterText,
      suffix: input2.suffix ?? input1.suffix,
      suffixIcon: input2.suffixIcon ?? input1.suffixIcon,
      suffixIconColor: input2.suffixIconColor ?? input1.suffixIconColor,
      suffixIconConstraints:
          input2.suffixIconConstraints ?? input1.suffixIconConstraints,
      suffixStyle: input2.suffixStyle ?? input1.suffixStyle,
      suffixText: input2.suffixText ?? input1.suffixText,
    );
  }
}
