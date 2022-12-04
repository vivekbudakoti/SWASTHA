import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastha/Bloc/auth_cubit.dart';
import 'package:swastha/screens/authentication/register.dart';
import 'package:swastha/screens/home/mental_health.dart';
import 'package:swastha/screens/home/physical_health.dart';
import 'package:swastha/screens/side_drawer/bmi_calculator.dart';
import 'package:swastha/screens/side_drawer/my_account.dart';
import 'package:swastha/screens/side_drawer/privacy_policy.dart';
import 'package:swastha/screens/side_drawer/term_and_condition.dart';
import 'package:swastha/services/change_screen.dart';
import 'package:swastha/utils/styles.dart';
import 'package:swastha/widgets/drawer_list_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  final List<Widget> pages = [
    const PhysicalHealth(),
    const MentalHealth(),
  ];
  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<AuthCubit>(context);
    final advancedDrawerController = AdvancedDrawerController();

    return AdvancedDrawer(
      backdropColor: kPrimaryColor,
      controller: advancedDrawerController,
      drawer: SafeArea(
        child: Container(
          color: kPrimaryColor,
          child: ListTileTheme(
            textColor: kWhite,
            iconColor: kWhite,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Container(
                  decoration: const BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  width: double.infinity,
                  child: Column(children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    CircleAvatar(
                      radius: 75.0,
                      backgroundImage:
                          Image.network(blocProvider.userModel.profileURL)
                              .image,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      blocProvider.userModel.name,
                      style: kHeadingTextStyle.copyWith(
                          fontSize: 24.0, color: kPrimaryColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      blocProvider.userModel.bmi,
                      style: kHeadingTextStyle.copyWith(fontSize: 18.0),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      blocProvider.userModel.mobile,
                      style: kSubHeadingTextStyle,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: kWhite,
                  thickness: 1.5,
                ),
                DrawerListTile(
                  title: 'My Account',
                  icon: Icons.person,
                  onPress: () {
                    changeScreen(context, const MyAccount());
                  },
                ),
                DrawerListTile(
                  title: 'BMI Calculator',
                  icon: Icons.monitor_heart,
                  onPress: () {
                    changeScreen(
                        context, const BMICalculator(name: '', profileURL: ''));
                  },
                ),
                DrawerListTile(
                  title: 'Privacy Policy',
                  icon: Icons.privacy_tip,
                  onPress: () {
                    changeScreen(context, const PrivacyPolicy());
                  },
                ),
                DrawerListTile(
                  title: 'Term & Conditions',
                  icon: Icons.report,
                  onPress: () {
                    changeScreen(context, const TermAndCondtion());
                  },
                ),
                BlocConsumer<AuthCubit, Authstate>(
                  listener: (context, state) {
                    if (state == Authstate.loggedIn) {
                      changeScreenReplacement(context, const PhysicalHealth());
                    } else if (state == Authstate.loggedOut) {
                      changeScreenReplacement(context, const Register());
                    }
                  },
                  builder: (context, state) {
                    if (state == Authstate.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return DrawerListTile(
                      title: 'Logout',
                      icon: Icons.logout,
                      onPress: () {
                        blocProvider.logOut();
                      },
                    );
                  },
                )
              ]),
            ),
          ),
        ),
      ),
      child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: FloatingActionButton(
            mini: true,
            backgroundColor: kWhite,
            onPressed: () {
              advancedDrawerController.showDrawer();
            },
            child: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    color: kPrimaryColor,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          body: pages[index],
          bottomNavigationBar: BottomNavigationBar(
            onTap: ((value) {
              setState(() {
                index = value;
              });
            }),
            currentIndex: index,
            selectedItemColor: kPrimaryColor,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center), label: 'Physical'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.psychology), label: 'Mental'),
            ],
          )),
    );
  }
}
