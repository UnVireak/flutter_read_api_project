import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_read_api_project/news_api_module/screens/home.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key, required this.ref});

  final Function(int)? ref;

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImage(context, screenSize, screenWidth, screenHeight),
            _buildCard(context, screenSize, screenWidth, screenHeight),
            _buildDescription(context, screenSize, screenWidth, screenHeight),
            _buildTeamMember(context, screenSize, screenWidth, screenHeight),
            _buildFooter(context, screenSize, screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(context, screenSize, screenWidth, screenHeight) {
    return Container(
      margin: EdgeInsets.zero, // No margin
      width: screenWidth,
      height: screenHeight * 0.3,
      child: Image.network(
        "https://us.123rf.com/450wm/peopleimages12/peopleimages122202/peopleimages12220204728/182031577-i-like-this-cropped-shot-of-a-creative-businessperson-working-in-the-office.jpg?ver=6",
        fit: BoxFit.cover, // Ensure the image covers the container
      ),
    );
  }

  Widget _buildCard(context, screenSize, screenWidth, screenHeight) {
    return Container(
      margin: EdgeInsets.zero, // No margin
      width: screenWidth,
      height: screenHeight * 0.3,
      child: Row(
        children: [
          Container(
             color: Color.fromARGB(124, 86, 98, 124),
            width: screenWidth * 0.5,
            height: screenHeight * 0.3,
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              // child: Transform.translate(
              //   offset: Offset(60, 0), // Adjust the horizontal offset as needed
              //   child: Transform.rotate(
                  // angle: -1.5708, // -90 degrees in radians
                  child: Text(
                    'ABOUT US',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            
          
          Container(
            width: screenWidth * 0.4,
            height: screenHeight * 0.3,
            child: Center(
              child: Text(
                'Founded by a college student during COVID shutdown',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(context, screenSize, screenWidth, screenHeight) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      width: screenWidth,
      // height: screenHeight * 0.4,
      // color: Color.fromARGB(122, 248, 245, 208),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          " Have you ever been part of a team that simply just didn't work, as if everyone was speaking different languages and no one was on the same page? Everyone seems to be talking about the same thing, but nothing seems to get done. Teamwork, as simple as it may sound, is not easy to achieve. It refers to a group of people – in this case, employees – working together to complete a task or attain a common goal. ",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildTeamMember(context, screenSize, screenWidth, screenHeight) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text("OUR TEAM",
          style: TextStyle( 
            fontSize: 14,
            fontWeight: FontWeight.bold
          ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceEvenly, // Ensures even spacing between containers
          children: [
            Container(
              width:
                  screenWidth * 0.4, // Adjusted width for the first container
              // height: screenHeight * 0.5,
              child: Column(children: [
                Stack(
                  children: [
                    // Background container for card details
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        width: screenWidth *
                            0.6, // Adjusted width for the background container
                        height:
                            150, // Adjusted height for the background container
                        decoration: BoxDecoration(
                          color: Color.fromARGB(189, 156, 208, 211),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black26,
                          //     blurRadius: 10,
                          //     offset: Offset(0, 4),
                          //   ),
                          // ],
                        ),
                      ),
                    ),
                    // Positioned image at the top
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 26, left: 60), // Adjusted margin for the image container
                        width: screenWidth *
                            0.3, // Adjusted width for the image container
                        height: screenHeight *
                            0.2, // Adjusted height for the image container
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/team/mi.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Text("Hi")
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Un Vireak",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "iOS Developer",
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ]),
                )
              ]),
            ),
           Container(
          width: screenWidth * 0.4, // Adjusted width for the first container
          // height: screenHeight * 0.5,
          child: Column(children: [
            Stack(
              children: [
                // Background container for card details
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    width: screenWidth *
                        0.6, // Adjusted width for the background container
                    height: 150, // Adjusted height for the background container
                    decoration: BoxDecoration(
                      color: Color.fromARGB(148, 135, 170, 201),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black26,
                      //     blurRadius: 10,
                      //     offset: Offset(0, 4),
                      //   ),
                      // ],
                    ),
                  ),
                ),
                // Positioned image at the top
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 35, ), 
                    width: screenWidth *
                        0.28, // Adjusted width for the image container
                    height: screenHeight *
                        0.19, // Adjusted height for the image container
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/team/mengchan.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Text("Hi")
              ],
            ),
             Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [ 
                         Container(
                          child: Text(
                            "Hong Mengchan",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Mobile app Developer",
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
          ],
          ),
        ),
          ],
        ),
        SizedBox(
            height: 20), // Adds vertical space between the rows of containers

        Container(
          width: screenWidth * 0.4, // Adjusted width for the first container
          // height: screenHeight * 0.5,
          child: Column(children: [
            Stack(
              children: [
                // Background container for card details
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    width: screenWidth *
                        0.6, // Adjusted width for the background container
                    height: 150, // Adjusted height for the background container
                    decoration: BoxDecoration(
                      color: Color.fromARGB(153, 207, 201, 201),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black26,
                      //     blurRadius: 10,
                      //     offset: Offset(0, 4),
                      //   ),
                      // ],
                    ),
                  ),
                ),
                // Positioned image at the top
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 18, right: 0,), 
                    width: screenWidth *
                        0.21, // Adjusted width for the image container
                    height: screenHeight *
                        0.21, // Adjusted height for the image container
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/team/lyheng.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Text("Hi")
              ],
            ),
             Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [ 
                         Container(
                          child: Text(
                            "Kong Sunlyheng",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Web app Developer",
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
          ],
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }

  Widget _buildFooter(context, screenSize, screenWidth, screenHeight) {
    return Container(
      height: screenHeight * 0.5,
      width: screenWidth,
      color: Color.fromARGB(124, 86, 98, 124),
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("CONTACT US"),
            Column(children: [
              TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your message',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: (){},
                child: const Text('Send'),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(
                      fontSize: 18,
                    )),
              ),
            ]),
            Row(
              children: [
                Text("FIND US:"),
                IconButton(onPressed: () {}, icon: Icon(Icons.facebook)),
                IconButton(onPressed: () {}, icon: Icon(Icons.telegram)),
                IconButton(onPressed: () {}, icon: Icon(Icons.email))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("COMPANY"),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('News'),
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            textStyle: const TextStyle(fontSize: 14),
                            padding: EdgeInsets.zero, // Removes default padding
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Trending'),
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            textStyle: const TextStyle(fontSize: 14),
                            padding: EdgeInsets.zero, // Removes default padding
                          ),
                        ),
                          TextButton(
                          onPressed: () {},
                          child: const Text('Blogs'),
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            textStyle: const TextStyle(fontSize: 14),
                            padding: EdgeInsets.zero, // Removes default padding
                          ),
                          
                        ),
                          TextButton(
                          onPressed: () {},
                          child: const Text('FAQs'),
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            textStyle: const TextStyle(fontSize: 14),
                            padding: EdgeInsets.zero, // Removes default padding
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("LEGALS"),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Terms'),
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            textStyle: const TextStyle(fontSize: 14),
                            padding: EdgeInsets.zero, // Removes default padding
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Privacy policy'),
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            textStyle: const TextStyle(fontSize: 14),
                            padding: EdgeInsets.zero, // Removes default padding
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Text("Copyright © 2024 TeamZINllBCZINAll. Rights Reserved.")
          ],
        ),
      ),
    );
  }
}
