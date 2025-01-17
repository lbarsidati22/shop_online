import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/prudact_item_model.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/view_models/home_cobit/home_cubit.dart';

class PrudactItem extends StatelessWidget {
  final PrudactItemModel prudactItemModel;
  const PrudactItem({super.key, required this.prudactItemModel});
  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: size.height * 0.15,
              width: size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.grey3,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: prudactItemModel.imgUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator.adaptive()),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white54,
                  ),
                  child: BlocBuilder<HomeCubit, HomeState>(
                    bloc: homeCubit,
                    buildWhen: (previous, current) =>
                        (current is SetFavoriteLeading &&
                            current.prudactId == prudactItemModel.id) ||
                        (current is SetFavoriteError &&
                            current.prudactId == prudactItemModel.id) ||
                        (current is SetFavoriteSuccess &&
                            current.prudactId == prudactItemModel.id),
                    builder: (context, state) {
                      if (state is SetFavoriteLeading) {
                        return CircularProgressIndicator.adaptive();
                      } else if (state is SetFavoriteSuccess) {
                        return state.isFavorite
                            ? InkWell(
                                onTap: () async => await homeCubit
                                    .setFavorite(prudactItemModel),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.favorite,
                                    color: AppColors.red,
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () async => await homeCubit
                                    .setFavorite(prudactItemModel),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.favorite_border,
                                  ),
                                ),
                              );
                      }
                      return InkWell(
                        onTap: () async =>
                            await homeCubit.setFavorite(prudactItemModel),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: prudactItemModel.isFavorite
                              ? Icon(
                                  Icons.favorite,
                                  color: AppColors.red,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                ),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          prudactItemModel.name,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          prudactItemModel.category,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.grey,
                //  fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          '\$${prudactItemModel.price}',
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                //  color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
        )
      ],
    );
  }
}
