import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:swastha/Bloc/auth_cubit.dart';
import 'package:swastha/Bloc/breath_cubit.dart';
import 'package:swastha/firebase_options.dart';
import 'package:swastha/screens/authentication/user_detail.dart';
import 'package:swastha/screens/home.dart';
import 'package:swastha/screens/home/physical_health.dart';
import 'package:swastha/screens/on_boarding.dart';
import 'package:swastha/utils/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => AuthCubit())),
        BlocProvider(create: ((context) => BreathCubit()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthCubit, Authstate>(
          buildWhen: ((previous, current) {
            return previous == Authstate.init;
          }),
          builder: (context, state) {
            if (state == Authstate.loggedIn) {
              return const Home();
            } else if (state == Authstate.loggedOut) {
              return const OnBoardingScreen();
            } else if (state == Authstate.unRegistered) {
              return const UserDetail();
            } else {
              return const Scaffold(
                body: Center(
                  child: SpinKitFadingCube(color: kPrimaryColor),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
