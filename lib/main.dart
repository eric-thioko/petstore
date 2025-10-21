import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:petstore/core/common/bloc_observer.dart';
import 'package:petstore/core/common/theme/theme.dart';
import 'package:petstore/core/di/service_locator.dart';
import 'package:petstore/core/router/router.dart';
import 'package:petstore/data/repository/cart/model/pet_entity_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(PetEntityAdapter());

  // Setup GetIt service locator
  await setupServiceLocator();

  Bloc.observer = AppBlocObserver();

  runApp(const PetStoreApp());
}

class PetStoreApp extends StatelessWidget {
  const PetStoreApp({super.key});
  @override
  Widget build(BuildContext context) {
    final goRouter = createRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: goRouter,
      title: 'Pet Store',
    );
  }
}
