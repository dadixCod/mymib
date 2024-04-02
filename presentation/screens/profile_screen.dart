import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/generated/l10n.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_bloc.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_event.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_state.dart';
import 'package:mymib/logic/blocs/user_bloc/user_bloc.dart';
import 'package:mymib/logic/blocs/user_bloc/user_event.dart';
import 'package:mymib/logic/blocs/user_bloc/user_state.dart';
import 'package:mymib/presentation/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String selectedLanguage;
  @override
  void initState() {
    context.read<UserBloc>().add(LoadUser());
    selectedLanguage = 'fr';
    super.initState();
  }

  var isLoading = false;
  var userLoading = false;
  void saveSelectedLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', languageCode);
  }

  void updateAppLanguage(String languageCode) {
    S.load(Locale(languageCode));
  }

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    Constants constants = Constants(deviseSize: size);
    final autoTexts = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is FailedUserLoading) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(state.errorMessage),
                );
              },
            );
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              return Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, bottom: 10, top: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileInfoContainer(
                            title:
                                "${autoTexts.username.replaceFirst("'", "")}: ",
                            content: state.user.displayName!,
                            selectedLanguage: selectedLanguage,
                          ),
                          SizedBox(height: constants.tenVertical),
                          ProfileInfoContainer(
                            title: '${autoTexts.email}: ',
                            content: state.user.email!,
                            selectedLanguage: selectedLanguage,
                          ),
                          SizedBox(height: constants.tenVertical),
                          ProfileInfoContainer(
                            title: '${autoTexts.type}: ',
                            content: state.user.type! == 'individual'
                                ? autoTexts.individual
                                : autoTexts.company,
                            selectedLanguage: selectedLanguage,
                          ),
                          SizedBox(height: constants.tenVertical * 4),
                          Text(
                            autoTexts.your_categories,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: constants.tenVertical * 2),
                          ContactContainer(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/edit_categories',
                                arguments: true,
                              );
                            },
                            icon: Image.asset(
                              'assets/icons/income.png',
                              color: context.colorScheme.background,
                            ),
                            text: state.user.type! == 'individual'
                                ? autoTexts.individualRevenues
                                : autoTexts.companyRevenues,
                            backgroundColor: Colors.blueAccent.shade100,
                          ),
                          SizedBox(height: constants.tenVertical * 2),
                          ContactContainer(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/edit_categories',
                                arguments: false,
                              );
                            },
                            icon: Image.asset(
                              'assets/icons/expense.png',
                              color: context.colorScheme.background,
                            ),
                            text: state.user.type! == 'individual'
                                ? autoTexts.individualExpenses
                                : autoTexts.companyExpenses,
                            backgroundColor:
                                context.colorScheme.primary.withAlpha(200),
                          ),
                          SizedBox(height: constants.tenVertical * 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                autoTexts.selectedLangue,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                                textDirection: selectedLanguage == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                              ),
                              DropdownButton<String>(
                                  value: selectedLanguage,
                                  items: <String>['fr', 'en', 'ar']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) => DropdownMenuItem(
                                              value: value, child: Text(value)))
                                      .toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        selectedLanguage = newValue;
                                      });
                                      saveSelectedLanguage(newValue);
                                      updateAppLanguage(newValue);
                                    }
                                    return;
                                  })
                            ],
                          ),
                        ],
                      ),
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccessSignOutState) {
                          Navigator.of(context).pushReplacementNamed('/log_in');
                        }
                        if (state is AuthLoadingState) {
                          isLoading = state.isLoading;
                        } else if (state is AuthFailureState) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(state.errorMessage),
                              );
                            },
                          );
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(SignOut());
                          },
                          child: Container(
                            width: size.width,
                            height: constants.tenVertical * 5,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: context.colorScheme.outline,
                            ),
                            child: Center(
                              child: isLoading
                                  ? SpinKitFadingCircle(
                                      color: context.colorScheme.background
                                          .withOpacity(0.8),
                                    )
                                  : Text(
                                      autoTexts.signout,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: context.colorScheme.background
                                            .withOpacity(0.8),
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else if (state is LoadingUser) {
              return Center(
                child: SpinKitFadingCircle(
                  color: context.colorScheme.primary,
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
