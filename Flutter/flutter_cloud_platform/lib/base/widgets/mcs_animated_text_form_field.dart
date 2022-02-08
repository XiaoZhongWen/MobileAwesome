import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MCSAnimatedTextFormField extends StatefulWidget {
  const MCSAnimatedTextFormField({
    Key? key,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.focusNode,
    this.autofillHints,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.autocorrect = false,
    this.secure = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? enabled;
  final bool autocorrect;
  final bool secure;

  @override
  _MCSAnimatedTextFormFieldState createState() => _MCSAnimatedTextFormFieldState();
}

class _MCSAnimatedTextFormFieldState extends State<MCSAnimatedTextFormField> {

  late InputBorder _inputBorder;
  late InputBorder _errorBorder;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _inputBorder = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(100)
    );
    _errorBorder = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(100)
    );
    _obscureText = widget.secure;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget textFormField = TextFormField(
      cursorColor: theme.primaryColor,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      validator: widget.validator,
      enabled: widget.enabled,
      autocorrect: widget.autocorrect,
      obscureText: _obscureText,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _buildSuffixIcon(),
        enabledBorder: _inputBorder,
        focusedBorder: _inputBorder,
        disabledBorder: _inputBorder,
        errorBorder: _errorBorder,
        focusedErrorBorder: _errorBorder
      ),
      autofillHints: widget.autofillHints,
    );

    return textFormField;
  }

  Widget? _buildSuffixIcon() {
    return widget.secure?
        GestureDetector(
          onTap: () => setState(() {
            _obscureText = !_obscureText;
          }),
          child: _obscureText?
            const Icon(Icons.visibility, size: 20,):
            const Icon(Icons.visibility_off, size: 20,)
        ):
        widget.suffixIcon;
  }
}
