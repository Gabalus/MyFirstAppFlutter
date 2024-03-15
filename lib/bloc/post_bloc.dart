import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import '../models/post.dart';

part 'post_event.dart';
part 'post_state.dart';

const _postLimit = 30;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }
  final http.Client httpClient;

  Future<void> _onPostFetched(
      PostFetched event,
      Emitter<PostState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts((state.posts.length/30).round()+1);
        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }
      final posts = await _fetchPosts((state.posts.length/30).round()+1);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: PostStatus.success,
          posts: List.of(state.posts)..addAll(posts),
          hasReachedMax: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts([int index = 0]) async {
    var uri =Uri.http(
        '81.163.28.221',
        '/api/organizations/category/1/organizations/'
    );
    final response = await httpClient.get(
      uri,
        headers: {
      'Authorization': 'Token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTYsImV4cCI6MTcxMTA0MjM4OH0.5HM0ybuS9C8EWeNZhziipj7eEIk9OfM9OZnHDovnofg',
      'X-Pagination-Per-Page': '$_postLimit',
      'X-Pagination-Current-Page': '$index',
    });
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['data'];
      return body.map<Post>((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Post(
          id: map['id'] as int,
          name: (map['name'] != null) ? map['name'] as String : '',
          photo: (map['photo'] == null || map['photo'] == '') ? 'https://previews.123rf.com/images/adambaihaqi/adambaihaqi2105/adambaihaqi210500015/168509421-restaurant-location-pin-icon-with-glyph-style-placeholder-vector-icon.jpg' : map['photo'] as String,
          rate: (map['rate'] != null) ? map['rate'] as double : 0.0,
          averageCheck: map['averageCheck'] as List,
          cuisines: map['cuisines'] as List,
          isFavorite: map['isFavorite'] as bool,
          distance: (map['distance'] != null) ? map['distance'] as int : 0,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}