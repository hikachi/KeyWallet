import 'package:flutter/src/widgets/framework.dart';
import 'package:key_wallet/login/login_bloc.dart';
import 'package:key_wallet/password_list/password_list_bloc.dart';
import 'package:key_wallet/register/register_bloc.dart';
import 'package:key_wallet/shared/repositories/user_dao.dart';
import 'package:provider/src/provider.dart';

import 'dependecies_provider.dart';

class BlocProvider extends DependenciesProvider {
  const BlocProvider(Widget child, {Key? key})
      : super(
          child,
          key: key,
        );

  @override
  List<Provider> get providers => [
        Provider<LoginBloc>(
          create: (context) => LoginBloc(Provider.of<UserDao>(context, listen: false), context),
        ),
        Provider<RegisterBloc>(
          create: (context) => RegisterBloc(Provider.of<UserDao>(context, listen: false), context),
        ),
        Provider<PasswordListBloc>(
          create: (context) => PasswordListBloc(
            Provider.of<UserDao>(context, listen: false),
          ),
        ),
      ];
}
