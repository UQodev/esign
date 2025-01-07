import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
// import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.home_outlined,
    title: 'Beranda',
  ),
  TabItem(
    icon: Icons.contact_page_outlined,
    title: 'Kontak',
  ),
  TabItem(
    icon: Icons.edit_document,
    title: 'Dokumen',
  ),
  TabItem(
    icon: Icons.notifications_outlined,
    title: 'Notifikasi',
  ),
  TabItem(
    icon: Icons.person_outline,
    title: 'Profil',
  )
];

class CustomBottomNavbar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;
  // final String title;

  const CustomBottomNavbar({
    Key? key,
    // required this.title,
    required this.onItemSelected,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return BottomBarCreative(
      items: items,
      backgroundColor: Colors.white,
      color: Colors.grey.shade600,
      colorSelected: const Color(0XFF3391CD),
      iconSize: 25,
      indexSelected: widget.currentIndex,
      onTap: widget.onItemSelected,
      titleStyle: GoogleFonts.lexend(
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      paddingVertical: 10,
      bottom: 15,
      top: 20,
    );
    // return Container(
    //   decoration: const BoxDecoration(
    //     gradient: LinearGradient(
    //       colors: [
    //         Color(0xFF3391CD),
    //         Color(0xFF6AD8FF),
    //       ],
    //       begin: Alignment.topCenter,
    //       end: Alignment.bottomCenter,
    //     ),
    //   ),
    //   child: BottomBarCreative(
    //     items: items,
    //     backgroundColor: Colors.transparent,
    //     color: Colors.white,
    //     colorSelected: Colors.black,
    //     iconSize: 25,
    //     indexSelected: widget.currentIndex,
    //     onTap: widget.onItemSelected,
    //     titleStyle: GoogleFonts.lexend(
    //       textStyle: const TextStyle(
    //         fontSize: 15,
    //         fontWeight: FontWeight.w500,
    //       ),
    //     ),
    //     paddingVertical: 10,
    //     bottom: 15,
    //     top: 20,
    //   ),
    // );
  }
}
