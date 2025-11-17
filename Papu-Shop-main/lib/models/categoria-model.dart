import 'dart:io';

class CategoriasModel {
  final String categoriaId;
  final String categoriaImg;
  final String categoriaName;
  final dynamic createAt;
  final dynamic updateAt;
  late File img;

  CategoriasModel(
      {required this.categoriaId,
      required this.categoriaImg,
      required this.categoriaName,
      required this.createAt,
      required this.updateAt,
      required this.img});

  Map<String, dynamic> toMap() {
    return {
      'categoriaId': categoriaId,
      'categoriaImg': categoriaImg,
      'categoriaName': categoriaName,
      'createAt': createAt,
      'updateAt': updateAt,
      'img': img,
    };
  }

  factory CategoriasModel.fromMap(Map<String, dynamic> json) {
    return CategoriasModel(
        categoriaId: json['categoriaId'],
        categoriaImg: json['categoriaImg'],
        categoriaName: json['categoriaName'],
        createAt: json['createAt'],
        updateAt: json['updateAt'],
        img: json['img']);
  }
}
