import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});
  static const String name = '/addProductState';

  @override
  State<StatefulWidget> createState() {
    return AddProductState();
  }
}

class AddProductState extends State<AddProduct> {
  final String apiUrl = "http://mdsakibulhasansanto.com/crud_database/data_add.php";
  final TextEditingController _name = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final TextEditingController _totalPrice = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _imageUrl = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _addNewProductInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildTextField(_name, 'Name', 'Enter product name'),
                const SizedBox(height: 15),
                buildTextField(_productPrice, 'Product Price', 'Enter product price', TextInputType.number),
                const SizedBox(height: 15),
                buildTextField(_totalPrice, 'Total Price', 'Enter total price', TextInputType.number),
                const SizedBox(height: 15),
                buildTextField(_quantity, 'Quantity', 'Enter quantity', TextInputType.number),
                const SizedBox(height: 15),
                buildTextField(_imageUrl, 'Submit Image url', 'Submit url '),
                const SizedBox(height: 15),
                buildTextField(_date, 'Submit date ', 'Submit date'),
                const SizedBox(height: 20),
                Visibility(
                  visible: !_addNewProductInProgress,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addProduct();
                      }
                    },

                    child: const Text('Add Product'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildTextField(TextEditingController controller, String label, String errorText, [TextInputType? keyboardType]) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black26, fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.amber, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
      ),
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return errorText;
        }
        return null;
      },
    );
  }

  Future<void> addProduct() async {
    setState(() {
      _addNewProductInProgress = true; // Show loader
    });

    final Uri url = Uri.parse(
        "$apiUrl?n=${_name.text.trim()}&p_p=${_productPrice.text.trim()}&t_p=${_totalPrice.text.trim()}&qu=${_quantity.text.trim()}&url=${_imageUrl.text.trim()}&da=${_date.text.trim()}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        _clearTextFields();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Product added successfully: ${response.body}")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add product: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occurred: $e")),
      );
    } finally {
      setState(() {
        _addNewProductInProgress = false; // Hide loader
      });
    }
  }

  void _clearTextFields() {
    _name.clear();
    _productPrice.clear();
    _totalPrice.clear();
    _quantity.clear();
    _imageUrl.clear();
    _date.clear();
  }

  @override
  void dispose() {
    _name.dispose();
    _productPrice.dispose();
    _totalPrice.dispose();
    _quantity.dispose();
    _imageUrl.dispose();
    _date.dispose();
    super.dispose();
  }
}

