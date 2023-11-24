class FacturaModel {
  final String clienteId;
  final List productosCompra;
  final double precioTotal;
  final dynamic createdAt;
  final dynamic updatedAt;

  FacturaModel({
    required this.clienteId,
    required this.productosCompra,
    required this.precioTotal,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'clienteId': clienteId,
      'productosCompra': productosCompra,
      'precioTotal': precioTotal,
      'createAt': createdAt,
      'updateAt': updatedAt,
    };
  }

  factory FacturaModel.fromMap(Map<String, dynamic> json) {
    return FacturaModel(
      clienteId: json['clienteId'],
      productosCompra: json['productosCompra'],
      precioTotal: json['precioTotal'],
      createdAt: json['createAt'],
      updatedAt: json['updateAt'],
    );
  }
}
