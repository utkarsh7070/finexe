import 'package:finexe/feature/base/dialog/logout_dialog.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PdDrawer extends StatelessWidget {
  const PdDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'Mohit Verma',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text('ID: 2343437'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png'),
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          // Row(
          //   children: [
          //     // Image(image: AssetImage('assetName'),
          //     // ),
          //     Icon(Icons.chat),
          //     SizedBox(
          //       width: displayWidth(context) * 0.02,
          //     ),
          //     Text('PD Reporting')
          //   ],
          // ),
          // SizedBox(
          //   height: displayHeight(context) * 0.2,
          // ),
          ListTile(
            leading: Icon(Icons.chat_outlined),
            title: Text('PD Reporting'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),

          Container(
            padding: EdgeInsets.only(left: displayWidth(context) * 0.15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                GestureDetector(
                  onTap: () {},
                  child: Text('Refused'),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.bodscreen);
                  },
                  child: Text('BOD List'),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.eodscreen);
                  },
                  child: Text('EOD List'),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.getalltask);
                  },
                  child: Text('All Task'),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, AppRoutes.pdformscreen);
                    LogOutDialog.logOutDialog(context: context);
                  },
                  child: Text('logout'),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
