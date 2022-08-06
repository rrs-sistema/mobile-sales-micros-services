import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../ui/pages/pages.dart';

Widget makeProductsDetailsScreen() => ProductsDetailsScreen(int.parse(Get.parameters['product_id'].toString()),);