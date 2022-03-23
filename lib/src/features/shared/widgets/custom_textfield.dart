import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_typography.dart';
import '../../../helpers/constants/app_styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final double? width, height;
  final int? maxLength;
  final String? floatingText, hintText;
  final TextStyle hintStyle, errorStyle, inputStyle;
  final TextStyle? floatingStyle;
  final EdgeInsets? contentPadding;
  final void Function(String? value)? onSaved, onChanged;
  final Widget? prefix;
  final bool showCursor;
  final bool autofocus;
  final bool showErrorBorder;
  final TextAlign textAlign;
  final Alignment errorAlign, floatingAlign;
  final Color fillColor;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String? value)? validator;

  const CustomTextField({
    Key? key,
    this.controller,
    this.width,
    this.height = 47,
    this.maxLength,
    this.floatingText,
    this.floatingStyle,
    this.onSaved,
    this.onChanged,
    this.prefix,
    this.showCursor = true,
    this.showErrorBorder = false,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
    this.errorAlign = Alignment.centerRight,
    this.floatingAlign = Alignment.centerLeft,
    this.fillColor = AppColors.backgroundColor,
    this.hintText,
    this.validator,
    this.hintStyle = const TextStyle(
      fontSize: FontSizes.f16,
      color: AppColors.textWhite80Color,
    ),
    this.errorStyle = const TextStyle(
      height: 0,
      color: Colors.transparent,
    ),
    this.inputStyle = const TextStyle(
      fontSize: FontSizes.f16,
      color: AppColors.textWhite80Color,
    ),
    this.contentPadding = const EdgeInsets.fromLTRB(17, 10, 1, 10),
    required this.keyboardType,
    required this.textInputAction,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorText;
  bool hidePassword = true;

  bool get hasError => errorText != null;

  bool get showErrorBorder => widget.showErrorBorder && hasError;

  bool get hasFloatingText => widget.floatingText != null;

  bool get isPasswordField =>
      widget.keyboardType == TextInputType.visiblePassword;

  void _onSaved(String? value) {
    final trimmedValue = value!.trim();
    widget.controller?.text = trimmedValue;
    widget.onSaved?.call(trimmedValue);
  }

  void _onChanged(String value) {
    if (widget.onChanged != null) {
      _runValidator(value);
      widget.onChanged!(value);
    }
  }

  String? _runValidator(String? value) {
    final error = widget.validator?.call(value!.trim());
    setState(() {
      errorText = error;
    });
    return error;
  }

  void _togglePasswordVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  OutlineInputBorder _focusedBorder() {
    return const OutlineInputBorder(
      borderRadius: Corners.rounded7,
      borderSide: BorderSide(
        color: AppColors.primaryColor,
        width: 2,
      ),
    );
  }

  OutlineInputBorder _normalBorder() {
    return const OutlineInputBorder(
      borderRadius: Corners.rounded7,
      borderSide: BorderSide.none,
    );
  }

  OutlineInputBorder _errorBorder() {
    return const OutlineInputBorder(
      borderRadius: Corners.rounded7,
      borderSide: BorderSide(
        color: AppColors.redColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Floating text
        if (hasFloatingText) ...[
          SizedBox(
            width: widget.width,
            child: Align(
              alignment: widget.floatingAlign,
              child: Text(
                widget.floatingText!,
                style: widget.floatingStyle ??
                    AppTypography.primary.body16.copyWith(
                      color: AppColors.textGreyColor,
                      fontSize: FontSizes.f16,
                    ),
              ),
            ),
          ),
          Insets.gapH2,
        ],

        //TextField
        SizedBox(
          height: widget.height,
          width: widget.width,
          child: TextFormField(
            controller: widget.controller,
            textAlign: widget.textAlign,
            autofocus: widget.autofocus,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            style: widget.inputStyle,
            showCursor: widget.showCursor,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            textAlignVertical: TextAlignVertical.center,
            autovalidateMode: AutovalidateMode.disabled,
            cursorColor: Colors.white,
            obscureText: isPasswordField && hidePassword,
            validator: _runValidator,
            onFieldSubmitted: _runValidator,
            onSaved: _onSaved,
            onChanged: _onChanged,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              errorStyle: widget.errorStyle,
              fillColor: widget.fillColor,
              prefixIcon: widget.prefix,
              contentPadding: widget.contentPadding,
              isDense: true,
              filled: true,
              counterText: '',
              border: _normalBorder(),
              focusedBorder: _focusedBorder(),
              focusedErrorBorder: _focusedBorder(),
              errorBorder: showErrorBorder ? _errorBorder() : null,
              suffixIcon: isPasswordField
                  ? InkWell(
                      onTap: _togglePasswordVisibility,
                      child: const Icon(
                        Icons.remove_red_eye_sharp,
                        color: AppColors.textGreyColor,
                        size: 22,
                      ),
                    )
                  : null,
            ),
          ),
        ),

        //Error text
        if (hasError) ...[
          Insets.gapH2,
          SizedBox(
            width: widget.width,
            child: Align(
              alignment: widget.errorAlign,
              child: Text(
                errorText!,
                style: AppTypography.primary.body16.copyWith(
                  fontSize: FontSizes.f16,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
