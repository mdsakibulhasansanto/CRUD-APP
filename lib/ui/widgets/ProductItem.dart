import 'package:flutter/material.dart';

import '../../models/Product.dart';


class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.imageUrl,
        height: 100,
        width: 80,fit: BoxFit.fitHeight,
      ),
      title: Text(
        product.name ?? '',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      subtitle:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( 'Product price : ${product.productPrice}',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
            ),

            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
          Text(
            'Total price : ${product.totalPrice}',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
            ),

            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
          Text(
            'Quantity : ${product.quantity}',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            'Date : ${product.date}',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
              shadows: [
                Shadow(
                  color: Colors.amber,
                  blurRadius: 10.0,
                ),
              ],
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Icon(Icons.delete),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(Icons.create_new_folder_outlined),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}