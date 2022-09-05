import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:world_times/features/home/cubit/home_cubit.dart';
import 'package:world_times/features/single_time/view/single_time_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              return Stack(
                children: [
                  appBar(state, context),
                  Container(
                    margin: EdgeInsets.only(top: 175, right: 35, left: 35),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 20),
                      itemCount: state.countries!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NeumorphicButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SingleTimeView(
                                        continent: state
                                            .countries![index].continent
                                            .toString(),
                                        country: state.countries![index].country
                                            .toString()))));
                          },
                          margin: EdgeInsets.only(bottom: 20),
                          style: NeumorphicStyle(
                            shape: NeumorphicShape.concave,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(35)),
                            depth: 5,
                            lightSource: LightSource.top,
                            color: Color.fromARGB(255, 210, 207, 207),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            child: Text(
                              "${state.countries![index].continent} / ${state.countries![index].country}",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final error = state as HomeError;

              return Center(
                child: Text(error.error),
              );
            }
          },
        ),
      ),
    );
  }

  Neumorphic appBar(HomeLoaded state, BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        )),
        depth: 5,
        lightSource: LightSource.top,
        color: Color.fromARGB(255, 210, 207, 207),
      ),
      child: Container(
        height: 175,
        width: 400,
        color: Color.fromARGB(255, 76, 175, 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            NeumorphicText(
              "World Times",
              textStyle: NeumorphicTextStyle(fontSize: 30),
            ),

            const SizedBox(height: 20),
            // search bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                width: 200,
                child: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(35)),
                    depth: -8,
                    lightSource: LightSource.top,
                    color: Color.fromARGB(255, 210, 207, 207),
                  ),
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: ((value) {
                      BlocProvider.of<HomeCubit>(context).onSearched(value);
                    }),
                    decoration:
                        InputDecoration(fillColor: Colors.green, filled: true),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
