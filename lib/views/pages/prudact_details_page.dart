import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/prudact_item_model.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/view_models/prudact_details_cubit/prudact_details_cubit.dart';
import 'package:shop_online/views/widgets/counter_widget.dart';

class PrudactDetailsPage extends StatelessWidget {
  final String prudactId;
  const PrudactDetailsPage({
    super.key,
    required this.prudactId,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<PrudactDetailsCubit>(context);
    return BlocBuilder<PrudactDetailsCubit, PrudactDetailsState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is PrudactDetailsLeading ||
          current is PrudactDetailsLoaded ||
          current is PrudactDetailsErrror,
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
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text('Prudact Details'),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border),
                ),
              ],
            ),
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.54,
                  decoration: BoxDecoration(
                    color: AppColors.grey2,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.13,
                      ),
                      CachedNetworkImage(
                        height: size.height * 0.4,
                        imageUrl: prudact.imgUrl,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.48),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    prudact.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: AppColors.amber,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        prudact.avrageRate.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              BlocBuilder<PrudactDetailsCubit,
                                  PrudactDetailsState>(
                                bloc: cubit,
                                buildWhen: (previous, current) =>
                                    current is QuantityCounterLoaded ||
                                    current is PrudactDetailsLoaded,
                                builder: (context, state) {
                                  if (state is QuantityCounterLoaded) {
                                    return CounterWidget(
                                      prudactId: prudact.id,
                                      cubit: cubit,
                                      value: state.value,
                                    );
                                  } else if (state is PrudactDetailsLoaded) {
                                    return CounterWidget(
                                      prudactId: prudact.id,
                                      cubit: cubit,
                                      value: 1,
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Size',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          BlocBuilder<PrudactDetailsCubit, PrudactDetailsState>(
                            bloc: cubit,
                            buildWhen: (previous, current) =>
                                current is SizeSelected ||
                                current is PrudactDetailsLoaded,
                            builder: (context, state) {
                              return Row(
                                children: PrudactSize.values
                                    .map(
                                      (size) => Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0, right: 6.0),
                                        child: InkWell(
                                          onTap: () {
                                            if (state is SizeSelected) {}
                                            cubit.selectSize(size);
                                          },
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: state is SizeSelected &&
                                                      state.size == size
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : AppColors.grey2,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Text(
                                                size.name.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      color:
                                                          state is SizeSelected &&
                                                                  state.size ==
                                                                      size
                                                              ? AppColors.white
                                                              : AppColors.black,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                            },
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Description',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            prudact.description,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: AppColors.black45,
                                ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: '\$',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.prymaryColor,
                                      ),
                                  children: [
                                    TextSpan(
                                      text: '${prudact.price}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              BlocBuilder<PrudactDetailsCubit,
                                  PrudactDetailsState>(
                                bloc: cubit,
                                buildWhen: (previous, current) =>
                                    current is PrudactAdedToCart ||
                                    current is PrudactAddingToCart,
                                builder: (context, state) {
                                  if (state is PrudactAddingToCart) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 12,
                                        ),
                                        backgroundColor: AppColors.prymaryColor,
                                        foregroundColor: AppColors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      onPressed: null,
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  } else if (state is PrudactAdedToCart) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 12,
                                        ),
                                        backgroundColor: AppColors.prymaryColor,
                                        foregroundColor: AppColors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      onPressed: null,
                                      child: Text('Aded to Cart'),
                                    );
                                  }
                                  return ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                      backgroundColor: AppColors.prymaryColor,
                                      foregroundColor: AppColors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.shopping_bag_rounded,
                                      color: AppColors.white,
                                    ),
                                    onPressed: () {
                                      if (cubit.selectedSize != null) {
                                        cubit.addToCart(prudact.id);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('Please Select Size'),
                                          ),
                                        );
                                      }
                                    },
                                    label: Text('add to cart'),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
