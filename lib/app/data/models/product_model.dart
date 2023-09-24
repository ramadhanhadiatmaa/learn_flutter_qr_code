class ProductModel {
  final String code;
  final String name;
  final String productId;
  final int quantity;

  ProductModel({
    required this.code,
    required this.name,
    required this.productId,
    required this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        code: json["code"] ?? "",
        name: json["name"] ?? "",
        productId: json["productId"] ?? "",
        quantity: json["quantity"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "productId": productId,
        "quantity": quantity,
      };
}
