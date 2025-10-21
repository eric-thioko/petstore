import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petstore/core/router/routes.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

class RefreshListenableCubit<T> extends ChangeNotifier {
  final Cubit<T> cubit;
  late final StreamSubscription<T> _subscription;

  RefreshListenableCubit(this.cubit) {
    _subscription = cubit.stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: globalNavigatorKey,
    initialLocation: Routes.onboard,
    routes: [],
  );
}
