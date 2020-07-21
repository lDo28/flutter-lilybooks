import 'package:flutter/material.dart';
import 'package:lily_books/generated/l10n.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.collections_bookmark,
            size: 150,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: 16),
          Text(
            S.of(context).appName,
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 32),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
