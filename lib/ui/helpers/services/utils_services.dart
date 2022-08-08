import 'package:intl/date_symbol_data_local.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UtilsServices {

  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR', decimalDigits: 2);
    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();
    
    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime);
  }

  void showToast({ required String message, bool isError = false, }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: isError ? Colors.red : Colors.white,
        textColor: isError ? Colors.white : Colors.black,
        fontSize: 14.0
    );
  }

}