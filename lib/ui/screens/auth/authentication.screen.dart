import 'package:flutter/material.dart';
import 'package:lily_books/api/api_status.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/models/auth_screen.model.dart';
import 'package:lily_books/routes.dart';
import 'package:lily_books/ui/screens/screens.dart';
import 'package:lily_books/ui/widgets/widgets.dart';

class AuthenticationScreen extends StatelessWidget {
  _getForm(AuthScreenType type) {
    switch (type) {
      case AuthScreenType.SignIn:
        return SignInForm();
      case AuthScreenType.SignUp:
        return SignUpForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is SignedInListener) {
              context.bloc<LoadingStateBloc>().add(
                    ToggleLoading(
                      isLoading: state.resource.status == ApiStatus.loading,
                    ),
                  );
              switch (state.resource.status) {
                case ApiStatus.loading:
                  break;
                case ApiStatus.success:
                  Navigator.pushReplacementNamed(context, RoutesName.home);
                  break;
                case ApiStatus.failed:
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.resource.message)),
                  );
                  break;
              }
            }
            if (state is SignedUpListener) {
              context.bloc<LoadingStateBloc>().add(
                    ToggleLoading(
                      isLoading: state.resource.status == ApiStatus.loading,
                    ),
                  );
              switch (state.resource.status) {
                case ApiStatus.loading:
                  break;
                case ApiStatus.success:
                  context
                      .bloc<AuthTypeBloc>()
                      .add(AuthTypeChange(type: AuthScreenType.SignIn));
                  break;
                case ApiStatus.failed:
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.resource.message)),
                  );
                  break;
              }
            }
          },
          child: BlocBuilder<AuthTypeBloc, AuthScreenType>(
            builder: (context, type) => ListView(
              children: [
                _buildTabMenu(context, type),
                _getForm(type),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabMenu(BuildContext context, AuthScreenType type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: authMenu
          .map((item) => AuthTabWidget(item: item, type: type))
          .toList(),
    );
  }
}
