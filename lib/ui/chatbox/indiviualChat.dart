import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasq/ui/widgets/shared/my_app_bar.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class IndividualChat extends StatefulWidget {
  String name;
  IndividualChat({this.name});

  @override
  _IndividualChatState createState() => _IndividualChatState();
}

class _IndividualChatState extends State<IndividualChat> {
  TextEditingController searchCtrl = TextEditingController();
  File image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colors.smokeWhite,
      appBar: MyAppbar(
        title: "${widget.name}",
        showChatIcon: false,
        trailing: trailing,
        autoImplyLeading: true,
      ),
      body: Container(
        width: Get.width,
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.03),
            Align(
              alignment: Alignment.center,
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: Get.height * 0.005),
                  width: Get.width * 0.6,
                  height: 37.0,
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        offset: Offset(0, 6.0),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: Get.width * 0.04),
                      Container(
                        width: 12,
                        height: 12,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: AppConfig.colors.saffronYellow,
                        ),
                      ),
                      SizedBox(width: Get.width * 0.08),
                      Text(
                        'Active 15 minutes ago',
                        style: MyTextStyles.montsNormal16.copyWith(
                          fontSize: 13.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: Get.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: Get.width * 0.04),
                CircularProfileAvatar(
                  "",
                  child: Image.asset(
                    AppConfig.images.starBux,
                    fit: BoxFit.cover,
                  ),
                  borderWidth: 1,
                  radius: Get.width * 0.05,
                ),
                SizedBox(width: Get.width * 0.08),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.name}',
                          style: MyTextStyles.montsNormal16.copyWith(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: Get.width * 0.01),
                        Text(
                          '11:05 AM',
                          style: MyTextStyles.montsNormal16.copyWith(
                            fontSize: 11.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      width: Get.width * 0.7,
                      child: Text(
                        'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                        style: MyTextStyles.montsNormal16.copyWith(
                          fontSize: 11.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            // bottonTextFormField(),
          ],
        ),
      ),
      bottomNavigationBar: bottonTextFormField(),
    );
  }

  Widget bottonTextFormField() {
    return SingleChildScrollView(
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
          color: AppConfig.colors.smokeWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 5.0,
            ),
          ],
        ),
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            TextField(
              textAlign: TextAlign.start,
              controller: searchCtrl,
              onChanged: (val) {
                // model.voidSearchFunction(val);
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "type your message",
                hintStyle: TextStyle(fontSize: 12, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(0),
                fillColor: AppConfig.colors.smokeWhite,
                isDense: true,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _imgFromCamera();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.add_comment,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _imgFromGallery();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.photo_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _imgFromGallery();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.attach_file_sharp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _imgFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }

  _imgFromGallery() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }

  Widget trailing = IconButton(
    icon: Icon(
      Icons.more_vert,
      color: Colors.white,
      size: 18,
    ),
    onPressed: () {},
  );
}
