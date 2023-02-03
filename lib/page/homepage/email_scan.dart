import 'package:flutter/material.dart';

import '../../const.dart';

class EmailScan extends StatefulWidget {
  const EmailScan({super.key});

  @override
  State<EmailScan> createState() => _EmailScanState();
}

class _EmailScanState extends State<EmailScan> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Navigator.of(context).push(
                        //   new MaterialPageRoute(builder: (ctx) => MainPage()),
                        // );
                        Navigator.of(context).pop(true);
                      });
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 35,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 15,
                      ),
                      Text(
                        'Data',
                        style: textType,
                      ),
                    ],
                  ),
                  Container(),
                ],
              ),
            ),
            Container(
              height: 250,
              width: double.infinity,
              color: blue.withOpacity(0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'To:',
                            style: textType.copyWith(fontSize: 18),
                          ),
                          Text(
                            'Subject:',
                            style: textType.copyWith(fontSize: 18),
                          ),
                          Text(
                            'Content:',
                            style: textType.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            'dungmoi2000@gmail.com',
                            style: textType.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            'hhheee',
                            style: textType.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'kakakddddddddddddddddddddddddddđ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textType.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 70,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color?>(
                                        blue.withOpacity(0.8)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  // side: BorderSide(color: Colors.red)
                                ))),
                            onPressed: () {},
                            child: Image.asset('assets/iconcustom/email.png')),
                      ),
                      Text(
                        'Send email',
                        style: textType.copyWith(fontSize: 18),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 70,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color?>(
                                        blue.withOpacity(0.8)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  // side: BorderSide(color: Colors.red)
                                ))),
                            onPressed: () {},
                            child: Icon(
                              Icons.share,
                              color: black,
                              size: 40,
                            )),
                      ),
                      Text(
                        'Share',
                        style: textType.copyWith(fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
