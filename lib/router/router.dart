import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_collection/widgets/email_widget.dart';
import 'package:movie_collection/widgets/reply_list_view.dart';
import 'package:movie_collection/models/data.dart' as data;

import '../main.dart';
import '../models/models.dart';

Widget _buildEmailDetail(List<Email> list, int? index) {
  final email = index != null && index >= 0 && index < list.length ? list[index] : null;
  if (email == null) return const Scaffold(body: Center(child: Text('Not found')));
  return EmailWidget(
    email: email,
    isPreview: false,
    isThreaded: true,
    showHeadline: index == 0,
  );
}

final GoRouter router = GoRouter(
  // Экран, который откроется по умолчанию
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Feed(currentUser: data.user_0),
    ),
    GoRoute(
      path: '/reply',
      builder: (context, state) => const ReplyListView(),
    ),
    GoRoute(
      path: '/reply/:id',
      builder: (context, state) {
        final index = int.tryParse(state.pathParameters['id'] ?? '');
        return _buildEmailDetail(data.replies, index);
      },
    ),
    GoRoute(
      path: '/emails/:id',
      builder: (context, state) {
        print('state=${state.pathParameters}, extra=${state.extra}');
        final index = int.tryParse(state.pathParameters['id'] ?? '');
        return _buildEmailDetail(data.emails, index);
      },
    ),
  ],
);
