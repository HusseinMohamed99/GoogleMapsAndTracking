part of './../core/helpers/export_manager/export_manager.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.places,
    required this.googleMapsPlacesService,
    required this.onPlaceSelect,
  });

  final List<PlaceAutocompleteModel> places;
  final GoogleMapsPlacesService googleMapsPlacesService;
  final void Function(PlaceDetailsModel) onPlaceSelect;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(FontAwesomeIcons.locationDot),
            title: Text(places[index].description!),
            trailing: IconButton(
              onPressed: () async {
                var placeDetails =
                    await googleMapsPlacesService.getPlaceDetails(
                  placeID: places[index].placeId.toString(),
                );
                onPlaceSelect(placeDetails);
              },
              icon: const Icon(FontAwesomeIcons.arrowRight),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: places.length,
      ),
    );
  }
}
