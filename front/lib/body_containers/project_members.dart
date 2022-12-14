import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildProjectMembersPage() {
  return SingleChildScrollView(
    child: Container(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.fromLTRB(40, 40, 35, 10),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Color(0xff353445), Color(0xff1b1d2a)])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildMemberCard("Member 1",
              'https://imageio.forbes.com/specials-images/dam/imageserve/1129869424/0x0.jpg?format=jpg&width=1200'),
          const SizedBox(
            height: 20,
          ),
          buildMemberCard("Member 2",
              'https://imageio.forbes.com/specials-images/dam/imageserve/1129869424/0x0.jpg?format=jpg&width=1200'),
          const SizedBox(
            height: 20,
          ),
          buildMemberCard("Member 3",
              'https://imageio.forbes.com/specials-images/dam/imageserve/1129869424/0x0.jpg?format=jpg&width=1200'),
        ],
      ),
    ),
  );
}

Widget buildMemberCard(String memberName, String imageURL) => Card(
    color: const Color.fromARGB(255, 31, 31, 42),
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: InkWell(
      onTap: () {},
      child: Column(
        children: [
          Ink.image(
            image: NetworkImage(
              imageURL,
            ),
            height: 100,
            width: 350,
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              memberName,
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ],
      ),
    ));
