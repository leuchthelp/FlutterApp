import 'package:flutter/material.dart';
import 'package:projects/providers/router_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/providers/theme_provider.dart';

void main() => runApp(const ProviderScope(child: Root()));

class Root extends ConsumerWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'SimpleApp',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: theme,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
