class Product {
  final String id;
  final String name;
  final String imagePath;
  final String desc;
  final String price;

  Product({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.desc,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imagePath: json['imagePath'],
      desc: json['desc'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'desc': desc,
      'price': price,
    };
  }
}
