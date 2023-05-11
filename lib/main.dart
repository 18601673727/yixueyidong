import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'router/router_notifier.dart';
import 'router/routes.dart';
import 'utils/state_logger.dart';

void main() {
  runApp(
    const ProviderScope(observers: [StateLogger()], child: MyAwesomeApp()),
  );
}

class MyAwesomeApp extends HookConsumerWidget {
  const MyAwesomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(routerNotifierProvider.notifier);

    final key = useRef(GlobalKey<NavigatorState>(debugLabel: 'routerKey'));
    final router = useMemoized(
      () => GoRouter(
        navigatorKey: key.value,
        refreshListenable: notifier,
        debugLogDiagnostics: true,
        initialLocation: SplashRoute.path,
        routes: notifier.routes,
        redirect: notifier.redirect,
      ),
      [notifier],
    );

    return MaterialApp.router(
      routerConfig: router,
      title: '易学易懂',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
