// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {

  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  String? id;


  Product({required this.name, required this.description, required this.quantity, required this.images, required this.category, required this.price, this.id});
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,

    }; 
  } 

 factory Product.fromMap(Map<String, dynamic> map) {
  return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
  );
}

 factory Product.fromMapElastic(Map<String, dynamic> map) {
  return Product(
      name: map['_source']['name'] ?? '',
      description: map['_source']['description'] ?? '',
      quantity: map['_source']['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['_source']['images']),
      category: map['_source']['category'] ?? '',
      price: map['_source']['price']?.toDouble() ?? 0.0,
      id: map['_id'],
  );
}




  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Product.fromJsonElastic(String source) => Product.fromMapElastic(json.decode(source) as Map<String, dynamic>);
}
