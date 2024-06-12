import 'package:flutter/material.dart';
import 'package:mindlog_app/const/visual.dart';

class RenderAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final int index;

  const RenderAppBarHome({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (index == 0) ? secondaryColor1 : Colors.transparent,
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
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
              icon: Icon(Icons.settings,
                color: (index == 0) ? typographyGray3 : typographyGray1,)
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(400);
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