import 'package:crud/ui/screens/UpdateProduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/Product.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product});
  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  final String deleteApiUrl = "http://mdsakibulhasansanto.com/crud_database/data_delete.php";

  Future<void> _deleteProduct() async {
    setState(() {});

    final Uri url = Uri.parse("$deleteApiUrl?id=${widget.product.id}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product deleted successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed delete product")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occurred $e")),
      );
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        widget.product.imageUrl,
        height: 100,
        width: 80,
        fit: BoxFit.fitHeight,
      ),
      title: Text(
        widget.product.name,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product price : ${widget.product.productPrice}',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            'Total price : ${widget.product.totalPrice}',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            'Quantity : ${widget.product.quantity}',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            'Date : ${widget.product.date}',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _deleteProduct();
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.green),
            onPressed: () {
              Navigator.pushNamed(
                context,
                UpdateProduct.name,
                arguments: {'Id': widget.product.id},
              );
            },
          ),
        ],
      ),
    );
  }
}
