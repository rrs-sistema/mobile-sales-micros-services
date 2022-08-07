import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../helpers/services/services.dart';
import './../../pages/products/products.dart';
import './components/components.dart';
import './../../common/common.dart';

class ProductsDetailsScreen extends StatefulWidget {
  final int productId;
  ProductsDetailsScreen(this.productId);

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  final UtilsServices utilsServices = UtilsServices();

  int cartItemQuantity = 1;

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<ProductsPresenter>(context);
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Builder(
        builder: (context) {
          presenter.loadById(widget.productId);
          return StreamBuilder<ProductViewModel?>(
              stream: presenter.productStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Error(
                    primaryColor: primaryColor,
                    error: '${snapshot.error}',
                    presenter: presenter,
                  );
                }
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(child: Padding(
                            padding: const EdgeInsets.only(top: 55),
                            child: Hero(
                              tag: snapshot.data!.imgUrl,
                              child: Image.network(snapshot.data!.imgUrl)),
                          )),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(50),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade600,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          snapshot.data!.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Quantity(
                                        value: cartItemQuantity, 
                                        suffixText: 'un', 
                                        result: (quantity) {
                                          setState(() {
                                            cartItemQuantity = quantity;
                                          });
                                        },),
                                    ],
                                  ),
                                  Text(
                                    utilsServices
                                        .priceToCurrency(snapshot.data!.price),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: SingleChildScrollView(
                                        child: Text(
                                          snapshot.data!.description,
                                          style: TextStyle(
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 55,
                                    child: ElevatedButton.icon(
                                      onPressed: () => null,
                                      label: Text(
                                        'Add no carrinho',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      icon: const Icon(
                                        Icons.shopping_cart_outlined,
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                primaryColor),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: SafeArea(
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return CircularProgress(
                  'Aguarde por favor...',
                );
              });
        },
      ),
    );
  }
}
