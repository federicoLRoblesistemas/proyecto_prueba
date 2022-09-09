import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfieldModelWidget extends StatelessWidget {
  const TextfieldModelWidget({
    super.key,
    required this.controller,
    required this.labelTitulo,
    required this.obscureText,
    required this.decoration,
    this.maxWidth,
    this.onChanged,
    this.margin,
    this.msjError,
    required this.desactivarCampo,
    this.onSubmitted,
    this.textInputAction,
    this.maxhigth,
    this.maxLineas = 1,
    this.minLineas = 1,
    this.hintText,
    this.focusNode,
    this.inputFormatters,
    this.maxLength,
    this.autoFoco = false,
    this.padingInferiorTexto, 
    this.tamanioTextoPhone,
  });
  final TextEditingController? controller;
  final String labelTitulo;
  final bool obscureText;
  final InputDecoration decoration;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? hintText;
  final EdgeInsets? margin;
  final double? maxWidth;
  final String? msjError;
  final bool desactivarCampo;
  final TextInputAction? textInputAction;
  final double? maxhigth;
  final int? maxLineas;
  final int? minLineas;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool? autoFoco;
  final double? padingInferiorTexto;
  final double? tamanioTextoPhone;
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: desactivarCampo,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? MediaQuery.of(context).size.width,
        ),
        margin: margin,
        height: 37,
        color: Colors.transparent,
        child: TextFormField(
            textInputAction: textInputAction,
            maxLines: maxLineas,
            minLines: minLineas,
            // maxLength: maxLength,
            autofocus: autoFoco!,
            controller: controller,
            obscureText: obscureText,
            inputFormatters: inputFormatters,
            focusNode: focusNode,
            // style: Theme.of(context)
            //     .textTheme
            //     .headline4!
            //     .copyWith(color: null, fontSize: context.determinarTamano(desktop: 15, phone: tamanioTextoPhone ?? 9, mobile: 14)),
            textCapitalization: TextCapitalization.sentences,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            decoration: decoration.copyWith(
              alignLabelWithHint: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(3), borderSide: BorderSide(width: desactivarCampo ? 0 : 0.1)),
              contentPadding: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: padingInferiorTexto ?? 15,
              ),
              //label: TextModelWidget.texto(texto: labelTitulo),
              labelText: labelTitulo,
            )),
      ),
    );
  }

  

  factory TextfieldModelWidget.estandar({
    Key key,
    TextEditingController? controller,
    required String labelTitulo,
    bool obscureText,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    EdgeInsets? margin,
    String? tooltipMessage,
    IconData? suffixIcon,
    InputDecoration decoration,
    double? maxWidth,
    bool? desactivarCampo,
    TextInputAction? textInputAction,
    final double? maxhigth,
    String? msjError,
    FocusNode? focusNode,
    String? hintText,
    bool? autoFoco,
    double? padingInferiorTexto,
    double? tamanioTextoPhone,
  }) = _TextfieldEstandarModelWidget;
  
}



class _TextfieldEstandarModelWidget extends TextfieldModelWidget {
  _TextfieldEstandarModelWidget(
      {super.key,
      super.controller,
      required super.labelTitulo,
      super.onChanged,
      super.obscureText = false,
      InputDecoration? decoration,
      String? tooltipMessage,
      IconData? suffixIcon = Icons.lightbulb_outline,
      EdgeInsets? margin,
      super.maxWidth,
      String? msjError,
      bool? desactivarCampo,
      super.onSubmitted,
      FocusNode? focusNode,
      TextInputAction? textInputAction = TextInputAction.next,
      super.maxhigth,
      String? hintText,
      super.autoFoco,
      super.padingInferiorTexto,
      super.tamanioTextoPhone})
      : super(
            decoration: decoration ??
                InputDecoration(
                  errorText: msjError,
                  // suffixIcon: Visibility(
                  //   visible: tooltipMessage != null && tooltipMessage.isNotEmpty,
                  //   child: Tooltip(
                  //       message: tooltipMessage ?? '',
                  //       child: Icon(
                  //         suffixIcon,
                  //         size: 14,
                  //       )),
                  // ),
                ),
            margin: margin,
            textInputAction: textInputAction,
            desactivarCampo: desactivarCampo ?? false,
            hintText: hintText,
            focusNode: focusNode);
}

