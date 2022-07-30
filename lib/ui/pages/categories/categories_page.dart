import 'package:flutter/material.dart';

import './../../../ui/pages/views_models/category_view_model.dart';
import './../../../ui/pages/categories/components/components.dart';
import './../../../ui/pages/categories/categories_presenter.dart';
import './../../../ui/helpers/i18n/i18n.dart';

class CategoriesPage extends StatelessWidget {
  final CategoriesPresenter presenter;

  CategoriesPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    presenter.loadData();
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.titleCategorie),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          return StreamBuilder<List<CategoryViewModel>>(
              stream: presenter.categoriesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(snapshot.error,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: presenter.loadData,
                          child: Text(R.strings.reload),
                        )
                      ],
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return CategoryListTile(category: snapshot.data[index]);
                      });
                }
                return const CircularProgressIndicator(
                  key: Key("circularLoadCategory"),
                  color: Colors.white,
                );
              });
        },
      ),
    );
  }
}
