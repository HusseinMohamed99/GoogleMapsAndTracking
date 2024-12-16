part of './../core/helpers/export_manager/export_manager.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.places,
  });

  final List<PlaceAutocompleteModel> places;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(places[index].description!),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: places.length),
    );
  }
}
