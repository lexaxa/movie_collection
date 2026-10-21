import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_collection/widgets/email_list_view.dart';
import 'package:movie_collection/widgets/email_widget.dart';
import 'package:movie_collection/widgets/reply_list_view.dart';
import 'package:movie_collection/models/data.dart' as data;

import '../main.dart';

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
    // Динамический роутинг с параметрами (например, /product/42)
    GoRoute(
      path: '/reply/:id',
      builder: (context, state) {
        // Достаем id из URL
        final index = int.tryParse(state.pathParameters['id'] ?? '0');
        return EmailWidget(
          email: data.replies[index ?? 0],
          isPreview: false,
          isThreaded: true,
          showHeadline: index == 0,
        );
      },
    ),
  ],
);
