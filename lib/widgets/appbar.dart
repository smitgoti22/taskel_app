import 'package:flutter/material.dart';

import '../componets/app_collors.dart';


class TdAppbar extends StatefulWidget {
  const TdAppbar({Key? key}) : super(key: key);

  @override
  State<TdAppbar> createState() => _TdAppbarState();
}

class _TdAppbarState extends State<TdAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("To-Do Daily",style: TextStyle(fontFamily: 'SansSemiBold',fontSize: MediaQuery.of(context).size.width * 0.045)),
      backgroundColor: AppColors.primaryColor,
      toolbarHeight: 100,
    );
  }
}
