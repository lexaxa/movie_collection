import 'package:flutter/material.dart';

import '../models/data.dart' as data;
import 'email_widget.dart';

class ReplyListView extends StatefulWidget {
  const ReplyListView({super.key});

  @override
  State<ReplyListView> createState() => _ReplyListViewState();
}

class _ReplyListViewState extends State<ReplyListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        child: ListView(
          controller: _scrollController,
          children: [
            const SizedBox(height: 8),
            ...List.generate(data.replies.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: EmailWidget(
                  email: data.replies[index],
                  isPreview: false,
                  isThreaded: true,
                  showHeadline: index == 0,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}