import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../componets/app_collors.dart';
import '../componets/text.dart';
import '../componets/textfieald.dart';
import '../widgets/drawer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? taskContent;
  String? query;
  QuerySnapshot? querySnapshot;
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescController = TextEditingController();
  final tskAddformkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    taskContent;
    query;
    taskTitleController;
    taskDescController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text("Taskel - To Do",
              style: TextStyle(
                  fontFamily: 'SansSemiBold',
                  fontSize: MediaQuery.of(context).size.width * 0.045)),
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: 100,
        ),
        drawer: const TdDrawer(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              taskTitleController.clear();
              taskDescController.clear();
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Form(
                    key: tskAddformkey,
                    child: Container(
                      height: height * 0.35,
                      width: width * 1,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const CommonText(
                                    text: "Add Task",
                                    size: 22,
                                    fontweight: FontWeight.w500),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: height * 0.06,
                                  width: double.infinity,
                                  child: CommonTextfieald(
                                    controller: taskTitleController,
                                    borderradious: 25,
                                    conentpading: EdgeInsets.only(
                                        top: 10, left: 15, bottom: 5),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Title";
                                      }
                                    },
                                    prefixicon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      child: CommonText(
                                          text: "Title : ",
                                          color: Colors.grey.withOpacity(0.8)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: height * 0.06,
                                  child: CommonTextfieald(
                                    controller: taskDescController,
                                    // validator: (value) {
                                    //   // if(value!.isEmpty)
                                    //   //   {
                                    //   //     setState(() {
                                    //   //       value = ' ';
                                    //   //     });
                                    //   //   }
                                    // },
                                    borderradious: 25,
                                    conentpading: EdgeInsets.only(
                                        top: 10, left: 15, bottom: 5),
                                    prefixicon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      child: CommonText(
                                          text: "Desc : ",
                                          color: Colors.grey.withOpacity(0.8)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        if (tskAddformkey.currentState!
                                            .validate()) {
                                          FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection("Notes")
                                              .add({
                                            "title": taskTitleController.text,
                                            "desc": taskDescController.text,
                                            "createdDate": "${DateTime.now()}"
                                          });
                                          taskTitleController.clear();
                                          taskDescController.clear();
                                          Navigator.pop(context);
                                        }
                                      },
                                      color: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: SizedBox(
                                          height: height * 0.055,
                                          width: width * 0.2,
                                          child: const Center(
                                            child: CommonText(
                                                text: "Add Task",
                                                color: Colors.white),
                                          )),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      color: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: SizedBox(
                                        height: height * 0.055,
                                        width: width * 0.2,
                                        child: const Center(
                                          child: CommonText(
                                              text: "Cancel",
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Icon(Icons.add)),
        backgroundColor: Colors.green.shade50,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("Notes")
              .orderBy("createdDate")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
            if(snapshots.hasData)
              {
                final tasks = snapshots.data!.docs;
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),

                      /// Search
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.060,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  border:
                                  Border.all(color: Colors.grey, width: 0.4)),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                      MediaQuery.of(context).size.height *
                                          0.015),
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        query = value;
                                      });
                                    },
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.search,
                                    cursorColor: AppColors.blackColor,
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.020,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.none),
                                    decoration: InputDecoration(
                                        hintText: "Search Tasks",
                                        hintStyle: TextStyle(
                                            fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.017,
                                            color: AppColors.greyColor
                                                .withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                            FluentIcons.search_32_regular,
                                            color: Colors.grey.shade400),
                                        contentPadding: EdgeInsets.only(
                                            top:
                                            MediaQuery.of(context).size.height *
                                                0.014)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            /// All to-Do's
                            CommonText(
                              text: "All TSKs",
                              color: AppColors.blackColor,
                              size: width * 0.06,
                              fontfamily: 'SansSemiBold',
                            ),
                          ],
                        ),
                      ),

                      /// to-do list

                      ListView.builder(
                        itemCount: tasks.length,
                        primary: false,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        itemBuilder: (BuildContext context, int index) {
                          if(snapshots.hasData && snapshots.data!= null)
                          {
                            if (query == null) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      Center(
                                        child: Row(
                                          children: [
                                            const CommonText(
                                                text: "Title : ",
                                                color: Colors.grey),
                                            Expanded(
                                              child: CommonText(
                                                  text:
                                                  "${tasks[index].get("title")}",
                                                  maxlines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  color: Colors.green.shade700,
                                                  size: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: [
                                      const CommonText(
                                          text: "Description : ",
                                          color: Colors.grey),
                                      Expanded(
                                        child: CommonText(
                                            text: " ${tasks[index].get("desc")}",
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  style: ListTileStyle.list,
                                  tileColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                          color: Colors.grey.withOpacity(0.5))
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            taskTitleController =
                                                TextEditingController(
                                                    text: tasks[index]
                                                        .get("title"));
                                            taskDescController =
                                                TextEditingController(
                                                    text: tasks[index]
                                                        .get("desc"));
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        15)),
                                                child: Container(
                                                  height: height * 0.35,
                                                  width: width * 1,
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            const CommonText(
                                                                text:
                                                                "Update Task",
                                                                size: 22,
                                                                fontweight:
                                                                FontWeight
                                                                    .w500),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              height * 0.06,
                                                              child:
                                                              CommonTextfieald(
                                                                controller:
                                                                taskTitleController,
                                                                conentpading:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    left:
                                                                    15,
                                                                    bottom:
                                                                    5),
                                                                borderradious:
                                                                25,
                                                                prefixicon:
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                      15,
                                                                      horizontal:
                                                                      10),
                                                                  child: CommonText(
                                                                      text:
                                                                      "Title : ",
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                          0.5)),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              height * 0.06,
                                                              child:
                                                              CommonTextfieald(
                                                                controller:
                                                                taskDescController,
                                                                conentpading:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    left:
                                                                    15,
                                                                    bottom:
                                                                    5),
                                                                borderradious:
                                                                25,
                                                                prefixicon:
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                      15,
                                                                      horizontal:
                                                                      10),
                                                                  child: CommonText(
                                                                      text:
                                                                      "Desc : ",
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                          0.5)),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                              children: [
                                                                MaterialButton(
                                                                  onPressed:
                                                                      () {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                        "Users")
                                                                        .doc(FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                                        .collection(
                                                                        "Notes")
                                                                        .doc(tasks[index]
                                                                        .id)
                                                                        .update({
                                                                      "title":
                                                                      taskTitleController
                                                                          .text,
                                                                      "desc":
                                                                      taskDescController
                                                                          .text
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  color: Colors
                                                                      .green,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          25)),
                                                                  child: SizedBox(
                                                                      height: height * 0.055,
                                                                      width: width * 0.2,
                                                                      child: const Center(
                                                                        child: CommonText(
                                                                            text:
                                                                            "Update",
                                                                            color:
                                                                            Colors.white),
                                                                      )),
                                                                ),
                                                                MaterialButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  color: Colors
                                                                      .red,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          25)),
                                                                  child:
                                                                  SizedBox(
                                                                    height:
                                                                    height *
                                                                        0.055,
                                                                    width:
                                                                    width *
                                                                        0.2,
                                                                    child:
                                                                    const Center(
                                                                      child: CommonText(
                                                                          text:
                                                                          "Cancel",
                                                                          color:
                                                                          Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          splashRadius: 20,
                                          icon: Icon(
                                            FluentIcons.edit_24_filled,
                                            size: 20,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        15)),
                                                child: Container(
                                                  height: height * 0.2,
                                                  width: width * 1,
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            const CommonText(
                                                                text:
                                                                "Do You Want a Delete Task?",
                                                                size: 16,
                                                                fontweight:
                                                                FontWeight
                                                                    .w400),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                              children: [
                                                                MaterialButton(
                                                                  onPressed:
                                                                      () {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                        "Users")
                                                                        .doc(FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                                        .collection(
                                                                        "Notes")
                                                                        .doc(tasks[index]
                                                                        .id)
                                                                        .delete();
                                                                    taskTitleController
                                                                        .clear();
                                                                    taskDescController
                                                                        .clear();
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  color: Colors
                                                                      .green,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          25)),
                                                                  child: SizedBox(
                                                                      height: height * 0.055,
                                                                      width: width * 0.2,
                                                                      child: const Center(
                                                                        child: CommonText(
                                                                            text:
                                                                            "Yes",
                                                                            color:
                                                                            Colors.white),
                                                                      )),
                                                                ),
                                                                MaterialButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  color: Colors
                                                                      .red,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          25)),
                                                                  child:
                                                                  SizedBox(
                                                                    height:
                                                                    height *
                                                                        0.055,
                                                                    width:
                                                                    width *
                                                                        0.2,
                                                                    child:
                                                                    const Center(
                                                                      child: CommonText(
                                                                          text:
                                                                          "No",
                                                                          color:
                                                                          Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          splashRadius: 20,
                                          icon: Icon(
                                              FluentIcons.delete_24_filled,
                                              size: 20)),
                                    ],
                                  ),
                                ),
                              );
                            }
                            if (tasks[index]
                                .get("title")
                                .toString()
                                .startsWith(query!.toLowerCase()) ||
                                tasks[index]
                                    .get("title")
                                    .toString()
                                    .startsWith(query!.toUpperCase())) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const CommonText(
                                              text: "Title : ",
                                              color: Colors.grey),
                                          CommonText(
                                              text:
                                              "${tasks[index].get("title")}",
                                              color: Colors.green.shade700,
                                              size: 16),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: [
                                      const CommonText(
                                          text: "Description : ",
                                          color: Colors.grey),
                                      CommonText(
                                          text: " ${tasks[index].get("desc")}",
                                          color: Colors.black),
                                    ],
                                  ),
                                  style: ListTileStyle.list,
                                  tileColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                          color: Colors.grey.withOpacity(0.5))),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            taskTitleController =
                                                TextEditingController(
                                                    text: tasks[index]
                                                        .get("title"));
                                            taskDescController =
                                                TextEditingController(
                                                    text: tasks[index]
                                                        .get("desc"));
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        15)),
                                                child: Container(
                                                  height: height * 0.35,
                                                  width: width * 1,
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            const CommonText(
                                                                text:
                                                                "Update Task",
                                                                size: 22,
                                                                fontweight:
                                                                FontWeight
                                                                    .w500),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              height * 0.06,
                                                              child:
                                                              CommonTextfieald(
                                                                controller:
                                                                taskTitleController,
                                                                conentpading:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    left:
                                                                    15,
                                                                    bottom:
                                                                    5),
                                                                borderradious:
                                                                25,
                                                                prefixicon:
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                      15,
                                                                      horizontal:
                                                                      10),
                                                                  child: CommonText(
                                                                      text:
                                                                      "Title : ",
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                          0.5)),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              height * 0.06,
                                                              child:
                                                              CommonTextfieald(
                                                                controller:
                                                                taskDescController,
                                                                conentpading:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    left:
                                                                    15,
                                                                    bottom:
                                                                    5),
                                                                borderradious:
                                                                25,
                                                                prefixicon:
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                      15,
                                                                      horizontal:
                                                                      10),
                                                                  child: CommonText(
                                                                      text:
                                                                      "Desc : ",
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                          0.5)),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                              children: [
                                                                MaterialButton(
                                                                  onPressed:
                                                                      () {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                        "Users")
                                                                        .doc(FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                                        .collection(
                                                                        "Notes")
                                                                        .doc(tasks[index]
                                                                        .id)
                                                                        .update({
                                                                      "title":
                                                                      taskTitleController
                                                                          .text,
                                                                      "desc":
                                                                      taskDescController
                                                                          .text
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  color: Colors
                                                                      .green,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          25)),
                                                                  child: SizedBox(
                                                                      height: height * 0.055,
                                                                      width: width * 0.2,
                                                                      child: const Center(
                                                                        child: CommonText(
                                                                            text:
                                                                            "Update",
                                                                            color:
                                                                            Colors.white),
                                                                      )),
                                                                ),
                                                                MaterialButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  color: Colors
                                                                      .red,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          25)),
                                                                  child:
                                                                  SizedBox(
                                                                    height:
                                                                    height *
                                                                        0.055,
                                                                    width:
                                                                    width *
                                                                        0.2,
                                                                    child:
                                                                    const Center(
                                                                      child: CommonText(
                                                                          text:
                                                                          "Cancel",
                                                                          color:
                                                                          Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          splashRadius: 20,
                                          icon: Icon(
                                            FluentIcons.edit_24_filled,
                                            size: 20,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        15)),
                                                child: Container(
                                                  height: height * 0.2,
                                                  width: width * 1,
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            const CommonText(
                                                                text:
                                                                "Do You Want a Delete Task?",
                                                                size: 16,
                                                                fontweight:
                                                                FontWeight
                                                                    .w400),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                              children: [
                                                                MaterialButton(
                                                                  onPressed:
                                                                      () {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                        "Users")
                                                                        .doc(FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                                        .collection(
                                                                        "Notes")
                                                                        .doc(tasks[index]
                                                                        .id)
                                                                        .delete();
                                                                    taskTitleController
                                                                        .clear();
                                                                    taskDescController
                                                                        .clear();
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  color: Colors
                                                                      .green,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          25)),
                                                                  child: SizedBox(
                                                                      height: height * 0.055,
                                                                      width: width * 0.2,
                                                                      child: const Center(
                                                                        child: CommonText(
                                                                            text:
                                                                            "Yes",
                                                                            color:
                                                                            Colors.white),
                                                                      )),
                                                                ),
                                                                MaterialButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  color: Colors
                                                                      .red,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          25)),
                                                                  child:
                                                                  SizedBox(
                                                                    height:
                                                                    height *
                                                                        0.055,
                                                                    width:
                                                                    width *
                                                                        0.2,
                                                                    child:
                                                                    const Center(
                                                                      child: CommonText(
                                                                          text:
                                                                          "No",
                                                                          color:
                                                                          Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          splashRadius: 20,
                                          icon: Icon(
                                              FluentIcons.delete_24_filled,
                                              size: 20)),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return Container();
                          }
                          else{
                            return Center(child: CircularProgressIndicator(),);
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                    ],
                  ),
                );
              }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ));
  }
}
