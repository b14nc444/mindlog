import 'package:flutter/material.dart';
import 'package:mindlog_app/const/visual.dart';

class renderAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const renderAppBarHome({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      //secondaryColor1,
      padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: SizedBox(
              width: 90,
              child: typoTransparentColor
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: (){
              },
              icon: Image.asset('assets/icons/settings.png')
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(500);
}

// PreferredSize renderAppBarHome() {
//   return PreferredSize(
//     preferredSize: Size.fromHeight(100),
//     child: AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       leading: typoTransparentColor,
//       actions: const [iconSettings]
//     ),
//   );
// }