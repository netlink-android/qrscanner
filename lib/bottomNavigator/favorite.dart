import 'package:flutter/material.dart';

import '../const.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Favorite', style: textType),
              Container(
                child: IconButton(
                  onPressed: () {
                    setState(() {});
                    // print(controller.torchState.value);
                  },
                  icon: Icon(
                    Icons.filter_list_alt,
                    size: 25,
                  ),
                ),
                decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.text_fields,
                            size: 30,
                          ),
                          SizedBox(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: textType.copyWith(fontSize: 16),
                              ),
                              Text(
                                'Text',
                                style: textType.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_right,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            size: 30,
                          ),
                          SizedBox(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'dung.can@gmail.com',
                                style: textType.copyWith(fontSize: 16),
                              ),
                              Text(
                                'Email',
                                style: textType.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_right,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
