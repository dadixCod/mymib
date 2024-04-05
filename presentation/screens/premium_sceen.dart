import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/generated/l10n.dart';
import 'package:mymib/logic/blocs/user_bloc/user_bloc.dart';
import 'package:mymib/logic/blocs/user_bloc/user_event.dart';
import 'package:mymib/logic/blocs/user_bloc/user_state.dart';

import '../widgets/widgets.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  var type = '';
   
  @override
  void initState() {
    context.read<UserBloc>().add(LoadUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final autoTexts = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          autoTexts.premium,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            type = state.user.type!;
            return type == 'individual'
                ? const IndividualPremium()
                : const CompanyPremium();
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
        listener: (context, state) {
          if (state is FailedUserLoading) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(state.errorMessage),
              ),
            ).then(
              (value) => context.read<UserBloc>().add(
                    LoadUser(),
                  ),
            );
          }
        },
      ),
    );
  }
}
