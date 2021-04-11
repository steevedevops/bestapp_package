import 'package:flutter/services.dart';

/// Define um [TextInputFormatter] que pode ser combinado com outros
/// para que seja possível interpolar de um para outro
/// Usado em [ComputableFormatter]
abstract class ComputableFormatter extends TextInputFormatter {
  /// Tamanho máximo do Formatter
  int get maxLength;
}
