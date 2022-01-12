import 'package:bestapp_package/src/formatters/computable_formatter.dart';
import 'package:flutter/services.dart';

/// Formata o valor do campo com a mascara de Cartão `XXXX XXXX XXXX XXXX`
class CreditCardFormatter extends TextInputFormatter implements ComputableFormatter {
  /// Define o tamanho máximo do campo.
  @override
  int get maxLength => 16;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue valorAntigo, TextEditingValue valorNovo) {
    final novoTextLength = valorNovo.text.length;
    var selectionIndex = valorNovo.selection.end;

    if (novoTextLength > maxLength) {
      return valorAntigo;
    }
    var usedSubstringIndex = 0;
    final newText = StringBuffer();

    if (novoTextLength >= 5) {
      newText.write(valorNovo.text.substring(0, usedSubstringIndex = 4) + ' ');
      if (valorNovo.selection.end >= 4) selectionIndex++;
    }
    if (novoTextLength >= 9) {
      newText.write(valorNovo.text.substring(4, usedSubstringIndex = 8) + ' ');
      if (valorNovo.selection.end >= 8) selectionIndex++;
    }
    if (novoTextLength >= 13) {
      newText.write(valorNovo.text.substring(8, usedSubstringIndex = 12) + ' ');
      if (valorNovo.selection.end >= 12) selectionIndex++;
    }
    if (novoTextLength >= usedSubstringIndex) {
      newText.write(valorNovo.text.substring(usedSubstringIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
