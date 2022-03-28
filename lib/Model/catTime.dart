class CatTimeModel {
  final int? id;
  final int idPro;
  final double bodyLenght;
  final double heartGirth;
  final double hearLenghtSide;
  final double hearLenghtRear;
  final double hearLenghtTop;
  final double pixelReference;
  final double distanceReference;
  final int imageSide;
  final int imageRear;
  final int imageTop;
  final String date;
  final String note;

  CatTimeModel({
    this.id,
    required this.idPro,
    required this.bodyLenght,
    required this.heartGirth,
    required this.hearLenghtSide,
    required this.hearLenghtRear,
    required this.hearLenghtTop,
    required this.pixelReference,
    required this.distanceReference,
    required this.imageSide,
    required this.imageRear,
    required this.imageTop,
    required this.date,
    required this.note,
  });

  CatTimeModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        idPro = res["idPro"],
        bodyLenght = res["bodyLenght"],
        heartGirth = res["heartGirth"],
        hearLenghtSide = res["hearLenghtSide"],
        hearLenghtRear = res["hearLenghtRear"],
        hearLenghtTop = res["hearLenghtTop"],
        pixelReference = res["pixelReference"],
        distanceReference = res["distanceReference"],
        imageSide = res["imageSide"],
        imageRear = res["imageRear"],
        imageTop = res["imageTop"],
        date = res["date"],
        note = res["note"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'idPro': idPro,
      'bodyLenght': bodyLenght,
      'heartGirth': heartGirth,
      'hearLenghtSide': hearLenghtSide,
      'hearLenghtRear': hearLenghtRear,
      'hearLenghtTop': hearLenghtTop,
      'pixelReference': pixelReference,
      'distanceReference': distanceReference,
      'imageSide': imageSide,
      'imageRear': imageRear,
      'imageTop': imageTop,
      'date': date,
      'note': note,
    };
  }
}
