import 'package:flutter/material.dart';
import 'package:flutter_movie_app_mvvm/models/moviesList/MainMovies.dart';
import 'package:flutter_movie_app_mvvm/res/AppContextExtension.dart';
import 'package:flutter_movie_app_mvvm/view/widget/MyTextView.dart';
import 'package:flutter_movie_app_mvvm/view_model/home/MovieListVM.dart';
import 'package:provider/provider.dart';

import '../../data/remote/response/Status.dart';
import '../../utils/Utils.dart';
import '../details/MovieDetailsScreen.dart';
import '../widget/LoadingWidget.dart';
import '../widget/MyErrorWidget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final MovieListVM viewModel = MovieListVM();
  @override
  void initState() {
    viewModel.fetchMovies();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyTextView(context.resources.strings.homeScreen,context.resources.color.colorWhite,context.resources.dimension.bigText)
      ),
      body: ChangeNotifierProvider<MovieListVM>(
        create: (BuildContext context) => viewModel,
        child: Consumer<MovieListVM>(
          builder: (context , viewModel,_){
          switch(viewModel.movieMain.status){
            case Status.LOADING:
            print('Loading');
            return LoadingWidget();

            case Status.ERROR:
              print('Error');
              return MyErrorWidget(viewModel.movieMain.message ?? "NA");

            case Status.COMPLETED:
              print('Completed');
              return _getMoviesListView(viewModel.movieMain.data?.results);

            default:

          }
          return Container();
          },
        ),
      )
    );
  }


  Widget _getMoviesListView(List<Results>? moviesList) {
    return ListView.builder(
        itemCount: moviesList?.length,
        itemBuilder: (context, position) {
          return _getMovieListItem(moviesList![position]);
        });
  }
  Widget _getMovieListItem(Results item) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          child: Image.network(
              'https://image.tmdb.org/t/p/w185${item.posterPath}' ?? "",
            errorBuilder: (context, error, stackTrace) {
              return new Image.asset('assets/images/img_error.png');
            },
            fit: BoxFit.fill,
            width: context.resources.dimension.listImageSize,
            height: context.resources.dimension.listImageSize,
          ),
          borderRadius: BorderRadius.circular(context.resources.dimension.imageBorderRadius),
        ),
        title: MyTextView(item.title ?? "NA",context.resources.color.colorPrimaryText,context.resources.dimension.bigText),
        subtitle: MyTextView(item.releaseDate??"NA",context.resources.color.colorSecondaryText,context.resources.dimension.mediumText),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${item.voteAverage}'),
            SizedBox(width: context.resources.dimension.verySmallMargin,),
            Icon(Icons.star,color: context.resources.color.colorAccent,),
          ],
        ),
        onTap: () {
          _sendDataToMovieDetailScreen(context, item);
        },
      ),
      elevation: context.resources.dimension.lightElevation,
    );
  }

  void _sendDataToMovieDetailScreen(BuildContext context, Results item) {
  Navigator.push(context, MaterialPageRoute(builder: (context){
    return MovieDetailsScreen(item);
  }));
  }
}
