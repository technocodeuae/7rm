import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevin_rm/helper/error_dialog_helper.dart';
import 'package:sevin_rm/helper/snack_bar_helper.dart';

import '../../../data/models/favourite/favourite_model.dart';
import '../../util/app_them.dart';
import '../conset/Const.dart';
import 'cubit/cubit.dart';
import 'cubit/status.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({
    Key? key,
  }) : super(key: key);
////
  // int stableId;
  // int horseId;
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavoriteModel? favoriteModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Favorite",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: primaryColor,
            )),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          Transform.scale(
            scale: 1.05,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/img.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Positioned(
          //   top: MediaQuery.of(context).size.height * 0.05,
          //   left: MediaQuery.of(context).size.width * 0.38,
          //   child: Center(
          //     child: Text(
          //       "Favorite",
          //       style: TextStyle(color: Color10, fontSize: 25),
          //     ),
          //   ),
          // ),
            Container(
            child: BlocProvider(
              create: (BuildContext context) =>
                  FavoriteCubitPage()..getFavorite(),
              child: BlocConsumer<FavoriteCubitPage, FavoriteCubitPageStates>(
                  listener: (BuildContext context, state) {
                if (state is RemoveFavErrorStates) {
                  DialogHelper.errorDialog(
                      context, "Error", state.error.toString());
                }
                if (state is RemoveFavSuccess) {
                  SnackBarHelper.mySnackBar(
                      "${state.removeFavoriteModel.message}", context);
                  (state.removeFavoriteModel.message,);
                }
                if (state is GetFavoriteErrorStates) {
                  DialogHelper.errorDialog(
                      context, "Error", state.error.toString());
                }
              }, builder: (BuildContext context, state) {
                if (state is FavoriteInitialStates) {
                  BlocProvider.of<FavoriteCubitPage>(context).getFavorite();
                } else if (state is GetFavoriteSuccessStates) {
                  state.favoriteModel;
                  print(state.favoriteModel);
                  print("Success");
                  return state.favoriteModel.horse.isEmpty ?Center(
                    child: Container(
                      child: Text("You don't have any horse in your favorite",
                      style: TextStyle(
                        color: Color1
                      )),
                    ),
                  ): Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.favoriteModel.horse.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, i) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                FittedBox(
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Image.network(
                                      state.favoriteModel.horse[i].horse!
                                              .imageId ??
                                          "",
                                      //
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: Image.asset(
                                            'assets/images/main/7rmlogo.png',
                                          ),
                                        );
                                      },
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 35),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Name: ${state.favoriteModel.horse[i].horse!.name}",
                                              style: TextStyle(
                                                  color: Color1, fontSize: 14),
                                            ),
                                            Text(
                                              // widget.filtersModel!.data[i]
                                              //     .gender
                                              //     .toString(),
                                              "Gender: ${state.favoriteModel.horse[i].horse!.gender}",
                                              style: TextStyle(
                                                  color: Color1, fontSize: 14),
                                            ),
                                            Text(
                                              "Price: ${state.favoriteModel.horse[i].horse!.price} AED",
                                              style: TextStyle(
                                                  color: Color1, fontSize: 14),
                                            ),
                                            Text(
                                              "Color: ${state.favoriteModel.horse[i].horse!.color}",
                                              style: TextStyle(
                                                  color: Color1, fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.remove_circle_outlined),
                                      onPressed: () {
                                        print(state.favoriteModel.horse[i]
                                            .stableId);
                                        context
                                            .read<FavoriteCubitPage>()
                                            .removeFavorite(
                                              state.favoriteModel.horse[i]
                                                  .horse!.id
                                                   ?? 0,
                                            );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            Divider(
                              color: Color6,
                              thickness: 0.8,
                              height: 2,
                              indent: 5,
                              endIndent: 5,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                          ],
                        );
                      },

                      // widget.dataIncludeCategory?.stables.length,
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Color1,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
