import 'package:bestapp_package/src/formatters/computable_formatter.dart';
import 'package:flutter/services.dart';

/// Formata o valor do campo com a mascara de Cartão `XX/XX`
class MMYYFormatter extends TextInputFormatter implements ComputableFormatter {
  /// Define o tamanho máximo do campo.
  @override
  int get maxLength => 4;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue valorAntigo, TextEditingValue valorNovo) {
    final novoTextLength = valorNovo.text.length;
    var selectionIndex = valorNovo.selection.end;

    if (novoTextLength > maxLength) {
      return valorAntigo;
    }
    var usedSubstringIndex = 0;
    final newText = StringBuffer();

    if (novoTextLength >= 3) {
      newText.write(valorNovo.text.substring(0, usedSubstringIndex = 2) + '/');
      if (valorNovo.selection.end >= 2) selectionIndex++;
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
