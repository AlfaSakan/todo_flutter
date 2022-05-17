import 'package:flutter/material.dart';
import '../models/shopping_model.dart';
import '../providers/providers.dart';
import '../helpers/helpers.dart';

class ShoppingCartWidget extends StatelessWidget {
  const ShoppingCartWidget({
    Key? key,
    required this.shoppingCart,
    this.onTapDone,
    this.isInCart,
  }) : super(key: key);

  final List<ShoppingItem> shoppingCart;
  final Function()? onTapDone;
  final bool? isInCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      height: 250,
      width: double.infinity,
      child: shoppingCart.isEmpty
          ? const Center(
              child: Icon(
                Icons.remove_shopping_cart_outlined,
                size: 70,
                color: Colors.grey,
              ),
            )
          : ListView.builder(
              itemCount: shoppingCart.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    toTitleCase(shoppingCart[index].getName),
                    style: TextStyle(
                      decoration: isInCart ?? false
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                      '${shoppingCart[index].getAmount}${shoppingCart[index].getUnit}'),
                  leading: const Icon(
                    Icons.shop,
                    color: Colors.green,
                  ),
                  trailing: InkWell(
                    onTap: onTapDone,
                    child: Icon(
                      isInCart ?? false
                          ? Icons.check_circle_outline
                          : Icons.radio_button_unchecked,
                      color: Colors.green,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
