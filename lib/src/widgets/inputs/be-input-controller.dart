import 'package:bestapp_package/src/formatters/br_telefone_input_formatter.dart';
import 'package:bestapp_package/src/formatters/cep_input_formatter.dart';
import 'package:bestapp_package/src/formatters/cnpj_input_formatter.dart';
import 'package:bestapp_package/src/formatters/cpf_input_formatter.dart';
import 'package:bestapp_package/src/formatters/currency_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TypeInput {
  NONE,
  PASSWORD,
  EMAIL,
  COUNTER,
  CURRENCY,

  // brasil
  CPF,
  CNPJ,
  CEP,
  BR_TEL
}

class BeInputController extends StatefulWidget {
  final TextEditingController controller;
  final bool fulwidth;
  final double width;
  final IconData suffixIcon;
  final IconData prefixIcon;
  final hintText;
  final bool enable;
  final bool obscure;
  final TypeInput typeInput;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final Function onSuffixTap;
  final Function onPrefixTap;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final EdgeInsetsGeometry padding;
  final bool validator;
  
  BeInputController({
    this.controller, 
    this.width,
    this.fulwidth = true,
    this.hintText, 
    this.suffixIcon,
    this.prefixIcon,
    this.enable=true,
    this.obscure=true,
    this.typeInput,
    this.inputFormatters,
    this.keyboardType,
    this.onSuffixTap,
    this.onPrefixTap,
    this.padding,
    this.enableInteractiveSelection=true,
    this.readOnly=false,
    this.validator=false,
  });

  @override
  _BeInputControllerState createState() => _BeInputControllerState();
}

class _BeInputControllerState extends State<BeInputController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.fulwidth ? MediaQuery.of(context).size.width : widget.width,
      padding: widget.padding != null ? widget.padding :  EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty && widget.validator) {
            return 'Campo não pode estar vazio!';
          }
          return null;
        },
        controller: widget.controller,
        enabled:  widget.enable,
        readOnly: widget.readOnly,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        showCursor: true,
        obscureText: widget.typeInput == TypeInput.PASSWORD && widget.obscure ? true : false,
        inputFormatters: defineTypeformatters(widget.typeInput),
        keyboardType: defineTypeInput(widget.typeInput),
        decoration: new InputDecoration(
          suffixIcon:  widget.suffixIcon != null && (widget.typeInput == TypeInput.PASSWORD || widget.typeInput == TypeInput.COUNTER || widget.typeInput == TypeInput.CURRENCY || widget.typeInput == TypeInput.CEP) ?
          IconButton(
            icon: Icon(widget.suffixIcon), 
            onPressed: widget.onSuffixTap
          ) : widget.suffixIcon != null ? 
          Icon(widget.suffixIcon) : null,
          prefixIcon:  widget.prefixIcon != null && (widget.typeInput == TypeInput.PASSWORD || widget.typeInput == TypeInput.COUNTER || widget.typeInput == TypeInput.CURRENCY || widget.typeInput == TypeInput.CEP) ?
          IconButton(
            icon: Icon(widget.prefixIcon),
            onPressed: widget.onPrefixTap,
          ) : widget.prefixIcon != null ? 
          Icon(widget.prefixIcon) : null,
          hintText:  widget.hintText ?? widget.hintText
        )
      ),
    );
  }

  List<TextInputFormatter> defineTypeformatters(TypeInput typeInput){
    if(typeInput == TypeInput.CPF){
      return [
        FilteringTextInputFormatter.digitsOnly,
        CpfInputFormatter()
      ];
    }
    else if(typeInput == TypeInput.CNPJ){
      return [
        FilteringTextInputFormatter.digitsOnly,
        CnpjInputFormatter()
      ];
    }
    else if(typeInput == TypeInput.CEP){
      return [
        FilteringTextInputFormatter.digitsOnly,
        CepInputFormatter()
      ];
    }
    else if(typeInput == TypeInput.BR_TEL){
      return [
        FilteringTextInputFormatter.digitsOnly,
        BrtelefoneInputFormatter()
      ];
    }
    else if(typeInput == TypeInput.CURRENCY){
      return [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyInputFormatter(showprefix: true)
      ];
    }
    // retorno o widget defaut que pode seu utilizado pelo usuario se quize
    else return widget.inputFormatters;
  }

  TextInputType defineTypeInput(TypeInput typeInput){
    if(typeInput == TypeInput.CPF || typeInput == TypeInput.CNPJ || typeInput == TypeInput.CEP || typeInput == TypeInput.BR_TEL || typeInput == TypeInput.COUNTER || typeInput == TypeInput.CURRENCY){
      return TextInputType.number;
    }else if(typeInput == TypeInput.EMAIL){
      return TextInputType.emailAddress;
    }
    // retorno o widget defaut que pode seu utilizado pelo usuario se quize
    else return widget.keyboardType;
  }
}