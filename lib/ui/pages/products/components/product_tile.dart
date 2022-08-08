import 'package:delivery_micros_services/ui/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../../ui/helpers/services/services.dart';
import './../../../../ui/common/common.dart';
import './../../products/products.dart';

class ProductTile extends StatefulWidget {
  final ProductViewModel item;
  final void Function(GlobalKey) cardAnimationMethod;

  const ProductTile({required this.item, required this.cardAnimationMethod});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {

  final GlobalKey imageGk = GlobalKey();

  IconData tileIcon = Icons.add_shopping_cart_outlined;

  Future<void> switchIcon() async {
    setState(() => tileIcon = Icons.check);
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() => tileIcon = Icons.add_shopping_cart_outlined);
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    final presenter = Provider.of<ProductsPresenter>(context);
    return GestureDetector(
      key: Key('onClickProductListTile'),
      //onTap: () => presenter.goToDetailResult(item.id),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return Provider(
              create: (_) => presenter, child: ProductsDetailsScreen(widget.item.id));
        }));
      },
      child: Stack(
        children: [
          Card(
            elevation: 1,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    child: Hero(
                      tag: widget.item.imgUrl,
                      child: Image.network(
                        widget.item.imgUrl,
                        key: imageGk,
                        errorBuilder: (context, url, error) => Image.asset(
                          'lib/ui/assets/sem-foto.jpg',
                          fit: BoxFit.fill,
                          errorBuilder: (context, url, error) => Image.asset(
                            'lib/ui/assets/sem-foto.jpg',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.item.name.length > 40
                        ? '${widget.item.name.substring(0, 39)}...'
                        : widget.item.name,
                    key: Key('itemProductName'),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: widget.item.quantityAvailable < 1
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    UtilsServices().priceToCurrency(widget.item.price),
                    style: TextStyle(
                        fontSize: 20,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: widget.item.quantityAvailable < 1
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(20)),
              child: Material(
                child: InkWell(
                  onTap: () {
                    switchIcon();
                    widget.cardAnimationMethod(imageGk);
                  },
                  child: Ink(
                    height: 40,
                    width: 35,
                    decoration: BoxDecoration(
                      color: primaryColor,
                    ),
                    child: Icon(
                      tileIcon,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
