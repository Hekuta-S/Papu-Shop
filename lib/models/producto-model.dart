class ProductoModel {
  final String productoId;
  final String categoriaId;
  final String productoName;
  final String categoriaName;
  final String precioVenta;
  final String precioCompleto;
  final List productoImg;
  final bool enVenta;
  final String descripcionProducto;
  final dynamic createdAt;
  final dynamic updatedAt;

  ProductoModel({
    required this.productoId,
    required this.categoriaId,
    required this.productoName,
    required this.categoriaName,
    required this.precioVenta,
    required this.precioCompleto,
    required this.productoImg,
    required this.enVenta,
    required this.descripcionProducto,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'productoId': productoId,
      'categoriaId': categoriaId,
      'productoName': productoName,
      'categoriaName': categoriaName,
      'precioVenta': precioVenta,
      'precioCompleto': precioCompleto,
      'productoImg': productoImg,
      'enVenta': enVenta,
      'descripcionProducto': descripcionProducto,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ProductoModel.fromMap(Map<String, dynamic> json) {
    return ProductoModel(
      productoId: json['productoId'],
      categoriaId: json['categoriaId'],
      productoName: json['productoName'],
      categoriaName: json['categoriaName'],
      precioVenta: json['precioVenta'],
      precioCompleto: json['precioCompleto'],
      productoImg: json['productoImg'],
      enVenta: json['enVenta'],
      descripcionProducto: json['descripcionProducto'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
