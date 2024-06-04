import 'package:flutter/material.dart';
import 'package:shopsquad/services/squad_service.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';

class ListCard extends StatefulWidget {
  const ListCard(
      {super.key,
      required this.title,
      this.subtitle,
      required this.backgroundColor,
      this.trailing,
      this.onTap,
      required this.onDelete,
      required this.onReceipt,
      required this.isActive,
      this.imageUrl});

  final String title;
  final Color backgroundColor;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback onDelete;
  final VoidCallback onReceipt;
  final Widget? subtitle;
  final bool isActive;
  final String? imageUrl;

  @override
  ListCardState createState() => ListCardState();
}

class ListCardState extends State<ListCard> {
  bool _isLoading = false;
  final SquadService squadService = SquadService();

  static const IconData deleteIcon =
      IconData(0xf696, fontFamily: 'MaterialIcons');
  static const IconData moneyIcon =
      IconData(0xf58f, fontFamily: 'MaterialIcons');
  static const IconData menu = IconData(0xf8dc, fontFamily: 'MaterialIcons');

  void showOptionsDialog(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    showImage(widget.imageUrl!);

    // String? imageUrl;
    // try {
    // imageUrl = await squadService.getImageLink();
    // imageUrl = imageUrl.replaceAll('"', '');
    // print(imageUrl);
    // } catch (e) {
    // // Handle error
    // }
    // if (imageUrl != null && Uri.tryParse(imageUrl)?.hasAbsolutePath == true) {
    //   showImage(widget.imageUrl!);
    // }

    setState(() {
      _isLoading = false;
    });
  }

  void showImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 40.0,
                right: 20.0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.s0_5,
        horizontal: AppSizes.s1,
      ),
      child: GestureDetector(
        onTap: widget.isActive ? widget.onTap : () {},
        child: Container(
          decoration: BoxDecoration(
            color: widget.isActive ? AppColors.success : widget.backgroundColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            title: Text(
              widget.title,
              style: TextStyle(color: AppColors.white),
            ),
            subtitle: widget.subtitle == null ? null : widget.subtitle,
            trailing: widget.trailing ??
                (widget.isActive
                    ? null
                    : !_isLoading
                        ? (IconButton(
                            onPressed: () {
                              showOptionsDialog(context);
                            },
                            icon: Icon(
                              moneyIcon,
                              color: AppColors.white,
                            )))
                        : CircularProgressIndicator(
                            color: AppColors.green,
                          )),
          ),
        ),
      ),
    );
  }
}
