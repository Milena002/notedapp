import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notedapp/common/models/user_model.dart';
import 'package:notedapp/common/routes/routes.dart';
import 'package:notedapp/common/utils/constants.dart';
import 'package:notedapp/features/onboarding/pages/onboarding.dart';
import 'package:notedapp/features/auth/controllers/user_state.dart';
import 'package:notedapp/firebase_options.dart';
import 'package:notedapp/features/todo/pages/homepage.dart';

Widget entrypoint = const OnBoarding();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key});

  static final defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.green);

  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    primarySwatch: Colors.green,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userProvider.notifier).refresh();
    List<UserModel> users = ref.watch(userProvider);

    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 825),
      minTextAdapt: true,
      builder: (context, child) {
        return DynamicColorBuilder(
          builder: (lightColorScheme, darkColorScheme) {
            return MaterialApp(
              title: 'Noted App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: AppConst.kWhite,
                colorScheme: lightColorScheme ?? defaultLightColorScheme,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme ?? defaultDarkColorScheme,
                scaffoldBackgroundColor: AppConst.kDarkGrey,
                useMaterial3: true,
              ),
              themeMode: ThemeMode.system,
              home: users.isEmpty ? const OnBoarding() : const HomePage(),
              onGenerateRoute: Routes.onGenerateRoute,
              builder: (context, child) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppConst.kAshgreen,
                     toolbarHeight: 0,
                  ),
                  body: child,
                );
              },
            );
          },
        );
      },
    );
  }
}
