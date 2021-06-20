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

  static String obterCep(String cep, {bool ponto = false}) {
    assert(cep.length == 8, 'CEP com tamanho inválido. Deve conter 8 caracteres');

    return ponto
        ? '${cep.substring(0, 2)}.${cep.substring(2, 5)}-${cep.substring(5, 8)}'
        : '${cep.substring(0, 2)}${cep.substring(2, 5)}-${cep.substring(5, 8)}';
  }

  /// Retorna o CPF utilizando a máscara: `XXX.YYY.ZZZ-NN`
  static String obterCpf(String cpf) {
    // assert(CPFValidator.isValid(cpf), 'CPF inválido!');
    return CPFValidator.format(cpf);
  }

  /// Retorna o CNPJ informado, utilizando a máscara: `XX.YYY.ZZZ/NNNN-SS`
  static String obterCnpj(String cnpj) {
    // assert(CNPJValidator.isValid(cnpj), 'CNPJ inválido!');
    return CNPJValidator.format(cnpj);
  }

  static String obterCPFCNPJ(String value) {    
    if(value.length <=11){      
      return CPFValidator.format(value);
    }else{      
      return CNPJValidator.format(value);
    }
  }
}