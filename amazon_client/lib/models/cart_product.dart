import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first


class CartProduct {

  final String id;
  final List<dynamic> allProduct;
  final String user_id;
  CartProduct({
    required this.id,
    required this.allProduct,
    required this.user_id,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'allProduct': allProduct,
      'user_id': user_id,
    };
  }

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
      id: map['_id'] as String,
      allProduct: (map['allProduct'] as List<dynamic>).cast<Map<String,dynamic>>().toList(),
      user_id: map['user_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // Process
  factory CartProduct.fromJson(String source) => CartProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  CartProduct copyWith({
    String? id,
    List<dynamic>? allProduct,
    String? user_id,
  }) {
    return CartProduct(
      id: id ?? this.id,
      allProduct: allProduct ?? this.allProduct,
      user_id: user_id ?? this.user_id,
    );
  }
}
