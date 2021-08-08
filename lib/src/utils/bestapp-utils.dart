import 'package:bestapp_package/src/validators/cnpj_validator.dart';
import 'package:bestapp_package/src/validators/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class BestappUtils {
  
  /// Remover caracteres especiais (ex: `/`, `-`, `.`)
  static String removeCaracteres(String valor) {
    assert(valor.isNotEmpty);
    return valor.replaceAll(RegExp('[^0-9a-zA-Z]+'), '');
  }

  /// Converter o valor de uma String com `R$`
  static double converterMoedaParaDouble(String valor) {
    assert(valor.isNotEmpty);
    final value = double.tryParse(valor.replaceAll('R\$', '').replaceAll('.', '').replaceAll(',', '.'));
    return value ?? 0;
  }

  /// Formatar resultado String no valor em real com o simbolo `R$`
  static String formatCurrencyPTBR({@required String value, bool compact = false}) {
    assert(value.isNotEmpty);
    double temp = double.parse(value);
    if(compact){
      return NumberFormat.compactCurrency(symbol: "R\$", decimalDigits: 2, locale: "pt-br").format(temp).toString();
    }else{
      return NumberFormat.currency(symbol: "R\$", decimalDigits: 2, locale: "pt-br").format(temp).toString();
    }
  }

  static String formatCep(String cep, {bool ponto = false}) {
    assert(cep.length == 8, 'CEP com tamanho inválido. Deve conter 8 caracteres');

    return ponto
        ? '${cep.substring(0, 2)}.${cep.substring(2, 5)}-${cep.substring(5, 8)}'
        : '${cep.substring(0, 2)}${cep.substring(2, 5)}-${cep.substring(5, 8)}';
  }

  static String formatTelefone(String telefone, {bool ddd = true}) {
    if (ddd) {
      assert((telefone.length == 10 || telefone.length == 11),
          'Telefone com tamanho inválido. Deve conter 10 ou 11 caracteres');

      return telefone.length == 10
          ? '(${telefone.substring(0, 2)}) ${telefone.substring(2, 6)}-${telefone.substring(6, 10)}'
          : '(${telefone.substring(0, 2)}) ${telefone.substring(2, 7)}-${telefone.substring(7, 11)}';
    } else {
      assert((telefone.length == 8 || telefone.length == 9),
          'Telefone com tamanho inválido. Deve conter 8 ou 9 caracteres');

      return (telefone.length == 8)
          ? '${telefone.substring(0, 4)}-${telefone.substring(4, 8)}'
          : '${telefone.substring(0, 5)}-${telefone.substring(5, 9)}';
    }
  }

  /// Retorna o CPF utilizando a máscara: `XXX.YYY.ZZZ-NN`
  static String formatCpf(String cpf) {
    // assert(CPFValidator.isValid(cpf), 'CPF inválido!');
    return CPFValidator.format(cpf);
  }

  /// Retorna o CNPJ informado, utilizando a máscara: `XX.YYY.ZZZ/NNNN-SS`
  static String formatCnpj(String cnpj) {
    // assert(CNPJValidator.isValid(cnpj), 'CNPJ inválido!');
    return CNPJValidator.format(cnpj);
  }

  static String formatCPFCNPJ(String value) {    
    if(value.length <=11){      
      return CPFValidator.format(value);
    }else{      
      return CNPJValidator.format(value);
    }
  }

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}