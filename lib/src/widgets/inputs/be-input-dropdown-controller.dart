import 'package:bestapp_package/bestapp_package.dart';
import 'package:flutter/material.dart';

// Usuando <T> para permitir ele soportar eses tipo de tipo
/*
  Exemple
  BeinputDropdownController(
    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
    hintText: "Gender",
    options: ["Male", "Female"],
    // value: '',
    onChanged: (String value) {
      print('value $value');
      setState(() {
        // gender = value;
        // state.didChange(newValue);
      });
    },
    getLabel: (String value) => value,
  ),
*/
class BeinputDropdownController<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T value;
  final String Function(T) getLabel;
  final void Function(T) onChanged;
  final bool fulwidth;
  final EdgeInsetsGeometry padding;
  final double width;
  final IconData prefixIcon;

  BeinputDropdownController({
    this.hintText = 'Selecione sua Opção',
    this.options = const [],
    this.getLabel,
    this.value,
    this.onChanged,
    this.fulwidth = true,
    this.padding,
    this.width,
    this.prefixIcon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fulwidth ? MediaQuery.of(context).size.width : width,
      padding: padding != null ? padding :  EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: FormField<T>(
        builder: (FormFieldState<T> state) {
          return InputDecorator(
            decoration: InputDecoration(
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              hintText:  hintText ?? hintText
            ),
            isEmpty:  value == null || value == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                isExpanded: true,
                value: value,
                isDense: true,
                onChanged: onChanged,
                items: options.map((T value) {
                  return DropdownMenuItem<T>(
                    value: value,
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.check),
                          SizedBox(width: 10),
                          Text(
                            getLabel(value),
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    )
                  );
                }).toList(),
              ),
            )
          );
        }
      )
    );
  }
}