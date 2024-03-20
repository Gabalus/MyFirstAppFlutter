import 'package:equatable/equatable.dart';

final class Post extends Equatable {
  const Post(
      {required this.id,
      required this.name,
      required this.photo,
      required this.rate,
      required this.averageCheck,
      required this.cuisines,
      required this.isFavorite,
      required this.distance});

  final int id;
  final String? name;
  final String? photo;
  final double? rate;
  final List averageCheck;
  final List cuisines;
  final bool isFavorite;
  final int? distance;

  @override
  List<Object?> get props =>
      [id, name, photo, rate, averageCheck, cuisines, isFavorite, distance];

  static Post fromJson(dynamic json) {
    return Post(
      id: json['id'] as int,
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      rate: json['rate'] as double?,
      averageCheck: json['averageCheck'] as List,
      cuisines: json['cuisines'] as List,
      isFavorite: json['isFavorite'] as bool,
      distance: json['distance'] as int?,
    );
  }
}
