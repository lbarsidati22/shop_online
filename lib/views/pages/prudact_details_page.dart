import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/view_models/prudact_details_cubit/prudact_details_cubit.dart';

class PrudactDetailsPage extends StatelessWidget {
  final String prudactId;
  const PrudactDetailsPage({
    super.key,
    required this.prudactId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrudactDetailsCubit, PrudactDetailsState>(
      bloc: BlocProvider.of<PrudactDetailsCubit>(context),
      builder: (context, state) {
        if (state is PrudactDetailsLeading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is PrudactDetailsErrror) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        } else if (state is PrudactDetailsLoaded) {
          final prudact = state.prudacts;
          return Scaffold(
            appBar: AppBar(
              title: Text('Prudact Details'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border),
                ),
              ],
            ),
            body: Stack(
              children: [
                CachedNetworkImage(imageUrl: prudact.imgUrl),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text('Somethind is rong'),
            ),
          );
        }
      },
    );
  }
}
