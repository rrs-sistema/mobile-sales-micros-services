import 'package:flutter/material.dart';

import './../../../../main/factories/pages/base_screen/base_screen.dart';
import './../../../../main/factories/pages/categories/categories.dart';
import './../../../../ui/pages/pages.dart';

Widget makeBaseScreenPage() => BasePageScreen(makeGetxBasePagePresenter(), makeGetxCategoriesPresenter());