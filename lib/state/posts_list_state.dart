import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../page/post_list_page.dart';
import '../screen/bottom_loader.dart';
import '../screen/post_list_item.dart';
import 'post_bloc.dart';

class PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state.status != PostStatus.initial) {
          if (state.posts.isEmpty) {
            return const Center(child: Text('no posts'));
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return (index >= state.posts.length)
                  ? const BottomLoader()
                  : PostListItem(post: state.posts[index]);
            },
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
            controller: _scrollController,
          );
        } else
          return const Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
