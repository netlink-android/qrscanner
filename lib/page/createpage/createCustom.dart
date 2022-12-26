import 'package:flutter/material.dart';

import '../../const.dart';

class CreateCustomPage extends StatefulWidget {
  String type;
  String icontype;
  CreateCustomPage({Key? key, required this.type, required this.icontype})
      : super(key: key);

  @override
  State<CreateCustomPage> createState() => _CreateCustomPageState();
}

class _CreateCustomPageState extends State<CreateCustomPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: GestureDetector(
                onTap: () {
                  print(widget.type);
                },
                child: Image.asset('assets/iconcustom/' + widget.icontype)),
          ),
        ),
        Text(
          widget.type,
          style: textType.copyWith(fontSize: 18, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
