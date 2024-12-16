part of './../core/helpers/export_manager/export_manager.dart';

class DisplayPlaces extends StatefulWidget {
  const DisplayPlaces({super.key});

  @override
  State<DisplayPlaces> createState() => _DisplayPlacesState();
}

class _DisplayPlacesState extends State<DisplayPlaces> {
  late TextEditingController textEditingController;
  late GoogleMapsPlacesService googleMapsPlacesService;
  List<PlaceAutocompleteModel> places = [];
  late Uuid uuid;

  @override
  void initState() {
    textEditingController = TextEditingController();
    googleMapsPlacesService = GoogleMapsPlacesService();
    uuid = const Uuid();

    fetchPredictions();
    super.initState();
  }

  void fetchPredictions() {
    var sessionToken = uuid.v4();
    textEditingController.addListener(
      () async {
        if (textEditingController.text.isNotEmpty) {
          var result = await googleMapsPlacesService.getPredictions(
            input: textEditingController.text,
            sessionToken: sessionToken,
          );
          places.clear();
          places.addAll(result);
          setState(() {});
        } else {
          places.clear();
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(uuid.v4());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            children: [
              CustomTextField(
                prefixIcon: IconButton(
                  icon: const Icon(FontAwesomeIcons.arrowLeft),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                ),
                textEditingController: textEditingController,
              ),
              const SizedBox(height: 16),
              CustomListView(
                places: places,
                googleMapsPlacesService: googleMapsPlacesService,
                onPlaceSelect: (placeDetailsModel) {
                  textEditingController.clear();
                  places.clear();
                  setState(() {});
                  print(placeDetailsModel.geometry!.location!.lat);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
