import 'package:flutter/material.dart';
import '../const/string_const.dart';

class CustomDialogBox extends StatefulWidget {
  final String description;
  final double height;
  final VoidCallback onPressed;

  const CustomDialogBox({
    Key? key,
    required this.description,
    required this.height,
    required this.onPressed,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: 414.0,
            height: 320.0,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 24.0),
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: w,
                    child: Text(widget.description,
                        style: const TextStyle(fontSize: 14.0),
                        textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: SizedBox(
                    width: w,
                    height: 60.0,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // <-- Radius
                          ),
                        ),
                        onPressed: widget.onPressed,
                        child: const Text(
                          StringConst.yesLabel,
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 28.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      width: w,
                      height: 60,
                      child: const Text(StringConst.noThanksLabel,
                          style: TextStyle(fontSize: 16.0, color: Colors.blue),
                          textAlign: TextAlign.center),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(
                  height: 27.0,
                ),
              ],
            ),
          ),
        ));
  }
}
