import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:world_times/features/single_time/cubit/single_time_cubit.dart';

class SingleTimeView extends StatefulWidget {
  const SingleTimeView(
      {Key? key, required this.continent, required this.country})
      : super(key: key);

  final String country;
  final String continent;

  @override
  State<SingleTimeView> createState() => _SingleTimeViewState();
}

class _SingleTimeViewState extends State<SingleTimeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SingleTimeCubit(continent: widget.continent, country: widget.country),
      child: Scaffold(
        body: BlocBuilder<SingleTimeCubit, SingleTimeState>(
          builder: (context, state) {
            if (state is SingleTimeLoaded) {
              return Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            clockAera(context, state,
                                state.singleTime!.utcToString!.hour.toString()),
                            const SizedBox(width: 20),
                            clockAera(
                                context,
                                state,
                                state.singleTime!.utcToString!.minute
                                    .toString())
                          ],
                        ),
                        const SizedBox(height: 20),
                        Neumorphic(
                          child: Container(
                            alignment: Alignment.center,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            height: 35,
                            width: 220,
                            child: NeumorphicText(
                              widget.continent,
                              textStyle: NeumorphicTextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50, left: 20),
                    child: NeumorphicButton(
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  )
                ],
              );
            } else if (state is SingleTimeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final error = state as SingleTimeError;
              return Center(
                child: Text(state.error.toString()),
              );
            }
          },
        ),
      ),
    );
  }

  Neumorphic clockAera(
      BuildContext context, SingleTimeLoaded state, String number) {
    return Neumorphic(
      style: const NeumorphicStyle(depth: 5),
      child: Container(
        alignment: Alignment.center,
        color: Theme.of(context).scaffoldBackgroundColor,
        height: 100,
        width: 100,
        child: NeumorphicText(
          number,
          style: const NeumorphicStyle(depth: 5),
          textStyle:
              NeumorphicTextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
