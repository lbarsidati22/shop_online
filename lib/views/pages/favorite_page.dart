import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/view_models/favorite_cubit/favorite_cubit.dart';
import 'package:shop_online/view_models/favorite_cubit/favorite_state.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      bloc: favoriteCubit,
      buildWhen: (previous, current) =>
          current is FavoriteError ||
          current is FavoriteLeading ||
          current is FavoriteLoaded,
      builder: (context, state) {
        if (state is FavoriteLeading) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (state is FavoriteLoaded) {
          final favoritePrudacts = state.favoritePrudact;
          if (favoritePrudacts.isEmpty) {
            return Center(child: Text('No Favorite Prudacts'));
          }
          return RefreshIndicator(
            onRefresh: () async {
              await favoriteCubit.getFavoritePrudacts();
            },
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    color: AppColors.grey3,
                    endIndent: 20,
                    indent: 20,
                  );
                },
                itemCount: favoritePrudacts.length,
                itemBuilder: (context, index) {
                  final prudact = favoritePrudacts[index];
                  return ListTile(
                    title: Text(prudact.name),
                    subtitle: Text(prudact.price.toString()),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        prudact.imgUrl,
                      ),
                    ),
                    trailing: BlocConsumer<FavoriteCubit, FavoriteState>(
                      bloc: favoriteCubit,
                      listenWhen: (previous, current) =>
                          current is FavoriteRemoveError ||
                          current is FavoriteRemoved,
                      listener: (context, state) {
                        if (state is FavoriteRemoveError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                            ),
                          );
                        }
                      },
                      buildWhen: (previous, current) =>
                          (current is FavoriteRemoving &&
                              current.prudactId == prudact.id) ||
                          current is FavoriteRemoveError ||
                          (current is FavoriteRemoved &&
                              current.prudactId == prudact.id),
                      builder: (context, state) {
                        if (state is FavoriteRemoving) {
                          return CircularProgressIndicator.adaptive();
                        }
                        return IconButton(
                          onPressed: () {
                            favoriteCubit.removeFavorite(prudact.id);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.red,
                          ),
                        );
                      },
                    ),
                  );
                }),
          );
        } else if (state is FavoriteError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
