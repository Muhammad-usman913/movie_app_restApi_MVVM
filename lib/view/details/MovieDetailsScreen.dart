
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_mvvm/models/moviesList/MainMovies.dart';
import 'package:flutter_movie_app_mvvm/res/AppContextExtension.dart';
import 'package:flutter_movie_app_mvvm/view/widget/MyTextView.dart';

class MovieDetailsScreen extends StatelessWidget {

  static final String id = "movie_details";

  final Results? movieData;

  // receive data from the HomeScreen as a parameter
  MovieDetailsScreen(this.movieData);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(context.resources.strings.movieDetailScreen)),
      body: Container(
        color: context.resources.color.colorWhite,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(context.resources.dimension.smallMargin),
            child: Column(
              children: [
                Center(
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w185${movieData!.posterPath}' ?? "",
                    errorBuilder: (context, error, stackTrace) {
                      return new Image.asset('assets/images/img_error.png');
                    },
                    fit: BoxFit.cover,
                    height: context.resources.dimension.imageHeight,
                  ),
                ),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          title: MyTextView(movieData?.title ?? "NA",context.resources.color.colorPrimaryText,context.resources.dimension.bigText,),
                          subtitle: MyTextView(movieData?.releaseDate??"NA",context.resources.color.colorSecondaryText,context.resources.dimension.mediumText,),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${movieData!.voteAverage}'),
                              SizedBox(width: context.resources.dimension.verySmallMargin,),
                              Icon(Icons.star,color: context.resources.color.colorAccent,),
                            ],
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: MyTextView('OverView',context.resources.color.colorSecondaryText,context.resources.dimension.mediumText),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: context.resources.dimension.defaultMargin),
                        child: Container(

                          child: Text('${movieData!.overview}'),

                      ),
                      // Padding(
                      //   padding: EdgeInsets.all(context.resources.dimension.defaultMargin),
                      //   child: _setChipView(movieData?.genres,context.resources.color.catChipColor),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: context.resources.dimension.defaultMargin),
                      //   child: Container(child: MyTextView(context.resources.strings.titleCast,context.resources.color.colorPrimaryText, context.resources.dimension.bigText),alignment: AlignmentDirectional.topStart,),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.all(context.resources.dimension.defaultMargin),
                      //   child: _setChipView(movieData?.actors,context.resources.color.castChipColor),
                      // ),
                      )
                    ],
                  ),
                  elevation: context.resources.dimension.highElevation,
                  margin: EdgeInsets.all(context.resources.dimension.smallMargin),
                  color: context.resources.color.colorWhite,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _setChipView(List<String>? data,Color color) {
  //   var size = data?.length??0;
  //   return Container(
  //     alignment: AlignmentDirectional.topStart,
  //     child: Wrap(
  //       alignment: WrapAlignment.start,
  //       spacing: 8,
  //       children: [
  //         for (var i = 0; i < size; i++)
  //           MyChips(data?[i]??"NA", color)
  //       ],
  //     ),
  //   );
  // }
}
