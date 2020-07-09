import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:lily_books/models/auth_screen.model.dart';
import 'package:lily_books/ui/screens/auth/auth_type/auth_type_cubit.dart';

class AuthTabWidget extends StatelessWidget {
  final AuthScreen item;
  final AuthScreenType type;

  const AuthTabWidget({
    Key key,
    @required this.item,
    @required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.cubit<AuthTypeCubit>().changeType(item.type),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: TextStyle(
                fontSize: item.type == type ? 20 : 14,
                color: item.type == type ? Colors.black : Colors.black54,
              ),
            ),
            SizedBox(height: 4),
            Visibility(
              visible: item.type == type,
              child: Container(
                height: 4,
                width: 25,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
