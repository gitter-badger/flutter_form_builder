import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:intl/intl.dart';

class FormBuilderTouchSpin extends FormBuilderField<num> {
  final num step;
  final num min;
  final num max;
  final Icon subtractIcon;
  final Icon addIcon;
  final num iconSize;

  final NumberFormat displayFormat;

  final EdgeInsets iconPadding;

  final TextStyle textStyle;

  final Color iconActiveColor;

  final Color iconDisabledColor;

  FormBuilderTouchSpin({
    Key key,
    @required String attribute,
    bool readOnly = false,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    num initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<num> onChanged,
    FormFieldSetter<num> onSaved,
    ValueTransformer<num> valueTransformer,
    List<FormFieldValidator<num>> validators = const [],
    this.step,
    this.min = 1,
    this.max = 9999,
    this.iconSize = 24.0,
    this.displayFormat,
    this.subtractIcon = const Icon(Icons.remove),
    this.addIcon = const Icon(Icons.add),
    this.iconPadding = const EdgeInsets.all(4.0),
    this.textStyle = const TextStyle(fontSize: 24),
    this.iconActiveColor,
    this.iconDisabledColor,
  }) : super(
          key: key,
          attribute: attribute,
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          initialValue: initialValue,
          decoration: decoration,
          onChanged: onChanged,
          onSaved: onSaved,
          valueTransformer: valueTransformer,
          validators: validators,
        );

  @override
  _FormBuilderTouchSpinState createState() => _FormBuilderTouchSpinState();
}

class _FormBuilderTouchSpinState
    extends FormBuilderFieldState<FormBuilderTouchSpin, num, num> {
  @override
  Widget build(BuildContext context) {
    return FormField<num>(
      key: fieldKey,
      enabled: widget.enabled,
      initialValue: initialValue,
      autovalidateMode: widget.autovalidateMode,
      validator: (val) => validate(val),
      onSaved: (val) => save(val),
      builder: (FormFieldState<num> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: widget.enabled,
            errorText: field.errorText,
          ),
          child: TouchSpin(
            key: ObjectKey(field.value),
            min: widget.min,
            max: widget.max,
            step: widget.step,
            value: field.value,
            iconSize: widget.iconSize,
            onChanged: readOnly
                ? null
                : (value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    field.didChange(value);
                    widget.onChanged?.call(value);
                  },
            displayFormat: widget.displayFormat,
            textStyle: widget.textStyle,
            addIcon: widget.addIcon,
            subtractIcon: widget.subtractIcon,
            iconActiveColor:
                widget.iconActiveColor ?? Theme.of(context).primaryColor,
            iconDisabledColor:
                widget.iconDisabledColor ?? Theme.of(context).disabledColor,
            iconPadding: widget.iconPadding,
            enabled: widget.enabled,
          ),
        );
      },
    );
  }
}
