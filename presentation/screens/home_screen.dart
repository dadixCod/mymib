import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/generated/l10n.dart';
import 'package:mymib/logic/blocs/categories_bloc.dart/bloc/category_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:mymib/logic/blocs/authentification_bloc/auth_bloc.dart';
// import 'package:mymib/logic/blocs/authentification_bloc/auth_event.dart';
// import 'package:mymib/logic/blocs/authentification_bloc/auth_state.dart';

// import 'package:mymib/logic/blocs/user_bloc/user_bloc.dart';
// import 'package:mymib/logic/blocs/user_bloc/user_event.dart';
// import 'package:mymib/logic/blocs/user_bloc/user_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs;
  bool isInitialized = false;
  var isLoading = false;
  var userLoading = false;

  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();
    isInitialized = _prefs.getBool('initialized') ?? false;
    if (!isInitialized) {
      _initializeCategories();
    }
  }

  Future<void> _initializeCategories() async {
    context.read<CategoryBloc>().add(InitializeDefaultCategories());
    _prefs.setBool('initialized', true);
  }

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<UserBloc>().add(LoadUser());
    // });
    _initialize();
    context.read<CategoryBloc>().add(GetCategories());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final autoTexts = S.of(context);
    final size = context.deviceSize;
    Constants constants = Constants(deviseSize: size);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: context.colorScheme.surface,
        shadowColor: context.colorScheme.onBackground,
        elevation: 0.4,
        title: Text(
          autoTexts.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/icons/filter.png',
              height: 24,
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            showDateRangePicker(
              context: context,
              firstDate: DateTime(2024),
              lastDate: DateTime(2030),
              initialDateRange: DateTimeRange(
                start: DateTime.now().subtract(const Duration(days: 30)),
                end: DateTime.now(),
              ),
            );
          },
          icon: const Icon(
            Icons.calendar_month_outlined,
            size: 24,
          ),
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          children: [
            // Container(
            //   height: size.height * 0.07,
            //   width: size.width,
            //   // padding: const EdgeInsets.symmetric(horizontal: 5),
            //   decoration: BoxDecoration(
            //     color: context.colorScheme.surface,
            //     boxShadow: [
            //       BoxShadow(
            //         spreadRadius: 0.3,
            //         blurRadius: 1,
            //         offset: Offset.zero,
            //         color: context.colorScheme.onBackground.withOpacity(0.2),
            //       )
            //     ],
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       IconButton(
            //         onPressed: () {},
            //         icon: const Icon(
            //           Icons.arrow_back_ios_rounded,
            //           size: 20,
            //         ),
            //       ),
            //       Text(
            //         DateFormat.yMMMM().format(
            //           DateTime.now(),
            //         ),
            //         style: const TextStyle(
            //           fontSize: 17,
            //         ),
            //       ),
            //       IconButton(
            //         onPressed: () {},
            //         icon: const Icon(
            //           Icons.arrow_forward_ios_rounded,
            //           size: 20,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: constants.tenVertical * 1.5),
            //3 Containers of Total , income , expenses
            GradientContainer(
              height: constants.tenVertical * 7,
              width: size.width * 0.95,
              title: "Total :",
              content: "2400 DA",
              gradientColors: [
                context.colorScheme.primary.withAlpha(100).withOpacity(0.3),
                context.colorScheme.primary.withOpacity(0.7),
              ],
              centerContent: true,
            ),
            SizedBox(height: constants.tenVertical),
            SizedBox(
              height: constants.tenVertical * 7,
              width: size.width * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientContainer(
                    height: constants.tenVertical * 7,
                    width: size.width * 0.45,
                    title: "Income:",
                    content: "2400 DA",
                    gradientColors: [
                      Colors.blue.shade200.withAlpha(100).withOpacity(0.4),
                      Colors.blue.shade100.withAlpha(200),
                    ],
                    centerContent: false,
                  ),
                  GradientContainer(
                    height: constants.tenVertical * 7,
                    width: size.width * 0.45,
                    title: "Expenses:",
                    content: "950 DA",
                    gradientColors: [
                      Colors.red.shade500.withOpacity(0.6),
                      Colors.red.shade500.withOpacity(0.8),
                    ],
                    centerContent: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: constants.tenVertical),
            //This is the main widget , it shows the transactions of the selected date
            Container(
              height: size.height * 0.57,
              width: size.width * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: context.colorScheme.onBackground.withOpacity(0.1),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/add_data.png',
                      height: size.height * 0.3,
                    ),
                    SizedBox(height: constants.tenVertical),
                    Text(
                      "Ajouter des expenses et revenues",
                      style: TextStyle(
                        color: context.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            100,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/add');
        },
        child: const Icon(
          Icons.add_rounded,
          size: 26,
        ),
      ),
    );
  }
}

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
    required this.height,
    required this.width,
    required this.gradientColors,
    required this.title,
    required this.content,
    this.centerContent = true,
  });
  final double height;
  final double width;
  final List<Color> gradientColors;
  final String title;
  final String content;
  final bool centerContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: centerContent
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisAlignment:
            centerContent ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            content,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
