import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petstore/core/router/routes.dart';
import 'package:petstore/core/router/transition/route_transition.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';
import 'package:petstore/presentation/add_pet/add_pet_page.dart';
import 'package:petstore/presentation/root/root_page.dart';
import 'package:petstore/presentation/update_pet/update_pet_page.dart';

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
    initialLocation: Routes.home,
    routes: [
      GoRoute(
        path: Routes.home,
        pageBuilder: (context, state) {
          return RouteTransition.slideIn(child: RootPage(), key: state.pageKey);
        },
      ),
      GoRoute(
        path: Routes.addPet,
        pageBuilder: (context, state) {
          return RouteTransition.slideIn(child: AddPetPage(), key: state.pageKey);
        },
      ),
      GoRoute(
        path: Routes.updatePet,
        pageBuilder: (context, state) {
          final pet = state.extra as PetEntity;
          return RouteTransition.slideIn(
            child: UpdatePetPage(pet: pet),
            key: state.pageKey,
          );
        },
      ),
    ],
  );
}
