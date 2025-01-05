import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_online/models/loaction_item_model.dart';
import 'package:shop_online/utils/app_colors.dart';
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
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        color: AppColors.grey,
                      ),
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dummyLocations.length,
                  itemBuilder: (context, index) {
                    final dummyLoaction = dummyLocations[index];
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dummyLoaction.city,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    '${dummyLoaction.city} - ${dummyLoaction.country}',
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
                                    backgroundImage: CachedNetworkImageProvider(
                                      dummyLoaction.imgUrl,
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
