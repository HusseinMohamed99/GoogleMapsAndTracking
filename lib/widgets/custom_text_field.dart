part of './../core/helpers/export_manager/export_manager.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.textEditingController,
    this.onTap,
    this.readOnly,
    this.prefixIcon,
    this.onIconTap,
  });
  final TextEditingController? textEditingController;
  final Function()? onTap;
  final bool? readOnly;
  final Widget? prefixIcon;
  final Function()? onIconTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      readOnly: readOnly ?? false,
      controller: textEditingController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        hintText: 'Search here',
        prefixIcon: prefixIcon ?? const Icon(FontAwesomeIcons.magnifyingGlass),
        filled: true,
        fillColor: Colors.white,
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.transparent),
    );
  }
}
