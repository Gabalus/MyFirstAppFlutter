import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../bloc/post_bloc.dart';
import '../page/PostList.dart';

class FoodScreen extends StatelessWidget {
  final Function changePage;
  FoodScreen({required this.changePage});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Row(
        children: [
          BackButton(onPressed: () => changePage(0)),
          GestureDetector(
            onTap: () {
                  () => changePage(0);
            },
            child: Container(
    child: Text('Food', style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          ),
        ]
        ),
      ),
      body: BlocProvider(
        create: (_) => PostBloc(httpClient: http.Client())..add(PostFetched()),
        child: PostsList(),
      ),
    );
  }
}