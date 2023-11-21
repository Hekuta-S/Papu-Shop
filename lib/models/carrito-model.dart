class CarritoModel {
  final String produntoId;
  final String categoriaId;
  final String productoName;
  final String categoriaName;
  final String precioVenta;
  final String precioCompleto;
  final List productoImagen;
  final bool enVenta;
  final String productoDescripcion;
  final dynamic createdAt;
  final dynamic updtatedAt;
  final int cantidadProducto;
  final double precioTotalProducto;

  CarritoModel({
    required this.produntoId,
    required this.categoriaId,
    required this.productoName,
    required this.categoriaName,
    required this.precioVenta,
    required this.precioCompleto,
    required this.productoImagen,
    required this.enVenta,
    required this.productoDescripcion,
    required this.createdAt,
    required this.updtatedAt,
    required this.cantidadProducto,
    required this.precioTotalProducto,
  });
  Map<String, dynamic> toMap() {
    return {
      'produntoId': produntoId,
      'categoriaId': categoriaId,
      'productoName': productoName,
      'categoriaName': categoriaName,
      'precioVenta': precioVenta,
      'precioCompleto': precioCompleto,
      'productoImagen': productoImagen,
      'enVenta': enVenta,
      'productoDescripcion': productoDescripcion,
      'createdAt': createdAt,
      'updtatedAt': updtatedAt,
      'cantidadProducto': cantidadProducto,
      'precioTotalProducto': precioTotalProducto,
    };
  }

  factory CarritoModel.fromMap(Map<String, dynamic> json) {
    return CarritoModel(
      produntoId: json['produntoId'],
      categoriaId: json['categoriaId'],
      productoName: json['productoName'],
      categoriaName: json['categoriaName'],
      precioVenta: json['precioVenta'],
      precioCompleto: json['precioCompleto'],
      productoImagen: json['productoImagen'],
      enVenta: json['enVenta'],
      productoDescripcion: json['productoDescripcion'],
      createdAt: json['createdAt'],
      updtatedAt: json['updtatedAt'],
      cantidadProducto: json['cantidadProducto'](),
      precioTotalProducto: json['precioTotalProducto'],
    );
  }
}
