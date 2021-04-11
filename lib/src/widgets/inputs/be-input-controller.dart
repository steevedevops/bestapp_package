import 'package:bestapp_package/src/formatters/br_telefone_input_formatter.dart';
import 'package:bestapp_package/src/formatters/cep_input_formatter.dart';
import 'package:bestapp_package/src/formatters/cnpj_input_formatter.dart';
import 'package:bestapp_package/src/formatters/cpf_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TypeInput {
  NONE,
  PASSWORD,
  EMAIL,

  // brasil
  CPF,
  CNPJ,
  CEP,
  BR_TEL
}

class BeInputController extends StatefulWidget {
  final TextEditingController textController;
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
  final Function onTap;
  final EdgeInsetsGeometry padding;
  
  BeInputController({
    this.textController, 
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
    this.onTap,
    this.padding
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
          if (value.isEmpty) {
            return 'Campo não pode estar vazio!';
          }
          return null;
        },
        controller: widget.textController,
        enabled:  widget.enable,
        obscureText: widget.typeInput == TypeInput.PASSWORD && widget.obscure ? true : false,
        inputFormatters: defineTypeformatters(widget.typeInput),
        keyboardType: defineTypeInput(widget.typeInput),
        decoration: new InputDecoration(
          suffixIcon:  widget.suffixIcon != null && widget.typeInput == TypeInput.PASSWORD ?
          GestureDetector(
            onTap: widget.onTap,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Icon(widget.suffixIcon),
            ),
          ) : widget.suffixIcon != null ? 
          Icon(widget.suffixIcon) : null,

          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
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
    // retorno o widget defaut que pode seu utilizado pelo usuario se quize
    else return widget.inputFormatters;
  }

  TextInputType defineTypeInput(TypeInput typeInput){
    if(typeInput == TypeInput.CPF || typeInput == TypeInput.CNPJ || typeInput == TypeInput.CEP || typeInput == TypeInput.BR_TEL){
      return TextInputType.number;
    }else if(typeInput == TypeInput.EMAIL){
      return TextInputType.emailAddress;
    }
    // retorno o widget defaut que pode seu utilizado pelo usuario se quize
    else return widget.keyboardType;
  }
}