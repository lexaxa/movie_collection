import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_collection/router/router.dart';

import '../destinations.dart';
import '../main.dart';
import '../models/data.dart' as data;
import '../models/models.dart';
import 'email_widget.dart';
import 'search_bar.dart' as search_bar;

class EmailListView extends StatefulWidget {
  const EmailListView({super.key, this.selectedIndex, this.onSelected, required this.currentUser});

  final int? selectedIndex;
  final ValueChanged<int>? onSelected;
  final User currentUser;

  @override
  State<EmailListView> createState() => _EmailListViewState();
}

class _EmailListViewState extends State<EmailListView> {
  int selectedIndexT = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          const SizedBox(height: 8),
          Text('text keys'),
          Shortcuts(
            shortcuts: {
              LogicalKeySet(LogicalKeyboardKey.keyT, LogicalKeyboardKey.controlLeft): IntentCtrlT(),
              LogicalKeySet(LogicalKeyboardKey.keyT): IntentT(),
            },
            child: Actions(
              actions: <Type, Action<Intent>>{
                IntentT: CallbackAction<IntentT>(
                  onInvoke: (IntentT intent) => setState(() {
                    print('_EmailListViewState.build + ');
                    selectedIndexT = (selectedIndexT + 1) % destinations.length;
                    print('_EmailListViewState.build + = ${selectedIndexT}');
                  }),
                ),
                IntentCtrlT: CallbackAction<IntentCtrlT>(
                  onInvoke: (IntentCtrlT intent) => setState(() {
                    print('_EmailListViewState.build - ');
                    selectedIndexT = selectedIndexT <= 0 ? 0 : selectedIndexT - 1;
                    print('_EmailListViewState.build - = ${selectedIndexT}');
                  }),
                ),
              },
              child: Focus(autofocus: true, child: Text('count: ${selectedIndexT}')),
            ),
          ),
          search_bar.SearchBar(currentUser: widget.currentUser),
          const SizedBox(height: 8),
          ...List.generate(data.emails.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: EmailWidget(
                email: data.emails[index],
                onSelected: widget.onSelected != null
                    ? () {
                        widget.onSelected!(index);
                        context.go('/emails/$index', extra: index);
                      }
                    : null,
                isSelected: widget.selectedIndex == index,
              ),
            );
          }),
        ],
      ),
    );
  }
}
