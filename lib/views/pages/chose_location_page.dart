import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/utils/app_colors.dart';
import 'package:shop_online/view_models/chose_location_cubit/chose_location_cubit.dart';
import 'package:shop_online/views/widgets/main_bottom.dart';

class ChoseLocationPage extends StatefulWidget {
  const ChoseLocationPage({super.key});

  @override
  State<ChoseLocationPage> createState() => _ChoseLocationPageState();
}

class _ChoseLocationPageState extends State<ChoseLocationPage> {
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChoseLocationCubit>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Address',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose your location',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(height: 10),
                Text(
                  'Let\'s find your unfforgatble event! Choose a location below to get started',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: AppColors.grey,
                      ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.grey,
                    ),
                    suffixIcon:
                        BlocConsumer<ChoseLocationCubit, ChoseLocationState>(
                      listenWhen: (previous, current) =>
                          current is LocationAded,
                      listener: (context, state) {
                        if (state is LocationAded) {
                          locationController.clear();
                        }
                      },
                      bloc: cubit,
                      buildWhen: (previous, current) =>
                          current is LocationsAdding ||
                          current is LocationAded ||
                          current is LocationsAddingFailure,
                      builder: (context, state) {
                        if (state is LocationsAdding) {
                          return Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: AppColors.grey,
                            ),
                          );
                        }
                        return IconButton(
                          onPressed: () {
                            if (locationController.text.isNotEmpty) {
                              cubit.addLocation(locationController.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Your locations required'),
                                ),
                              );
                            }
                          },
                          icon: Icon(
                            Icons.add,
                            color: AppColors.grey,
                          ),
                        );
                      },
                    ),
                    hintText: 'Write your location',
                    fillColor: AppColors.grey2,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.red),
                    ),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Select location',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(height: 16),
                BlocBuilder<ChoseLocationCubit, ChoseLocationState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is FetchedLocations ||
                      current is FetchLocationsFailure ||
                      current is FetchingLocations,
                  builder: (context, state) {
                    if (state is FetchingLocations) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is FetchedLocations) {
                      final locations = state.locations;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          final location = locations[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.grey,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          location.city,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        Text(
                                          '${location.city} - ${location.country}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: AppColors.grey,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 44,
                                          backgroundColor: AppColors.grey,
                                        ),
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            location.imgUrl,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is FetchLocationsFailure) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
                SizedBox(height: 16),
                MainBottom(
                  text: 'Conrifim',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
