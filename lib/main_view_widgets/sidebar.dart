import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CustomDrawer extends StatefulWidget {
  final Function(AdminMenuItem) onMenuSelected;
  const CustomDrawer({super.key, required this.onMenuSelected});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SideBar(
       header: Container(
        color: Colors.blue,
        height: 150,
        width: double.infinity,
        child: Image.asset('assets/images/logo.png'),
      ),
      footer: Container(
        height: 50,
        width: double.infinity,
        color: Colors.blue,
        child: Center(
          child: Text(
            DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      items: const [
        AdminMenuItem(
          title: 'Announcements',
          route: '/announcements',
          icon: FontAwesomeIcons.bullhorn,    
        ),
        AdminMenuItem(
          title: 'Water Connections',
          icon: FontAwesomeIcons.faucetDrip,
          children: [
            AdminMenuItem(
              title: 'New Water Connection',
              route: '/new-water-connection',
              icon: FontAwesomeIcons.droplet,
            ),
            AdminMenuItem(
              title: 'Reconnection',
              route: '/reconnection',
              icon: FontAwesomeIcons.link,
            ),
            AdminMenuItem(
              title: 'Voluntary Disconnection',
              route: '/disconnection',
              icon: FontAwesomeIcons.dropletSlash,
            ),
          ],
        ),
        AdminMenuItem(
          title: 'Other Services',
          icon: FontAwesomeIcons.handshakeAngle,
          children: [
            AdminMenuItem(
              title: 'Transfer of Ownership',
              route: '/transfer-ownership',
              icon: FontAwesomeIcons.handHoldingDroplet,
            ),
            AdminMenuItem(
              title: 'Water Meter Calibration',
              route: '/water-meter-calibration',
              icon: FontAwesomeIcons.water,
            ),
            AdminMenuItem(
              title: 'Change Water Meter',
              route: '/change-water-meter',
              icon: FontAwesomeIcons.rotate,
            ),
          ],
        ),
        AdminMenuItem(
          title: 'Promos',
           route: '/promo',
          icon: FontAwesomeIcons.tags,
        ),
        AdminMenuItem(
          title: 'About us',
          route: '/about',
          icon: FontAwesomeIcons.message,
        ),
        AdminMenuItem(
          title: 'Customer Feedback',
          route: '/customer-feedback',
          icon: FontAwesomeIcons.commentDots,
        ),
      ], 
      selectedRoute: '/', 
       onSelected: widget.onMenuSelected, 
       
     
    
    );
  }
}