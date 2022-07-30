import 'package:delivery_micros_services/main/factories/pages/categories/categories_presenter_factory.dart';
import 'package:flutter/material.dart';

import './../../../../main/factories/pages/base_screen/base_screen.dart';
import './../../../../ui/pages/pages.dart';

Widget makeBaseScreenPage() => BasePageScreen(makeGetxBasePagePresenter(), makeGetxCategoriesPresenter());