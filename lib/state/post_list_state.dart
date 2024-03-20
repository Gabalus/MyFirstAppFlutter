import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/state/post_bloc.dart';

import '../page/post_list_page.dart';
import '../screen/post_list_item.dart';

class PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();
  int index = 1;

  PostsListState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case PostStatus.success:
            if (state.posts.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return Container(
                child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index == state.posts.length)
                  return Center(child: CircularProgressIndicator());
                if (index > state.posts.length) return SizedBox.shrink();
                if (index < state.posts.length)
                  return PostListItem(post: state.posts[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.posts.length
                  : state.posts.length + 30,
              controller: _scrollController,
            ));
          case PostStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
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
