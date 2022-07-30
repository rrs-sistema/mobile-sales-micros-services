import 'package:delivery_micros_services/main/factories/pages/categories/categories_presenter_factory.dart';
import 'package:flutter/material.dart';

import '../../../../ui/pages/pages.dart';

Widget makeCategoriesPage() => CategoriesPage(makeGetxCategoriesPresenter());