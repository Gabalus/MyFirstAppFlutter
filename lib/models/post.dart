import 'package:equatable/equatable.dart';

final class Post extends Equatable {
  const Post({required this.id, required this.name, required this.photo, required this.rate,required this.averageCheck,
    required this.cuisines, required this.isFavorite,required this.distance});

  final int id;
  final String name;
  final String photo;
  final double rate;
  final List averageCheck;
  final List cuisines;
  final bool isFavorite;
  final int distance;

  @override
  List<Object> get props => [id, name, photo, rate, averageCheck, cuisines, isFavorite, distance];
}