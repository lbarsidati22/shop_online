class LoactionItemModel {
  final String id;
  final String city;
  final String country;
  final String imgUrl;

  LoactionItemModel({
    required this.id,
    required this.city,
    required this.country,
    this.imgUrl =
        'https://previews.123rf.com/images/emojoez/emojoez1903/emojoez190300018/119684277-illustrations-design-concept-location-maps-with-road-follow-route-for-destination-drive-by-gps.jpg',
  });
}

List<LoactionItemModel> dummyLocations = [
  LoactionItemModel(
    id: '1',
    city: 'Nouakchott',
    country: 'Mauritania',
  ),
  LoactionItemModel(
    id: '2',
    city: 'Nema',
    country: 'Mauritania',
  ),
  LoactionItemModel(
    id: '3',
    city: 'Trarza',
    country: 'Mauritania',
  ),
];
