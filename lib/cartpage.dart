import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CreateProvider.dart';

class Cartpage extends StatelessWidget {
  const Cartpage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: cart.cartItems.isEmpty
          ? Center(child: Text("Cart is empty"))
          : ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (context, index) {
                final item = cart.cartItems[index];

                return ListTile(
                  leading: Image.asset(item["image"]),
                  title: Text(item["title"]),
                  subtitle: Text("Price: ${item["price"]}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      cart.removeFromCart(item);  
                    },
                  ),
                );
              },
            ),
    );
  }
}
