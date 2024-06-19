import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {

  const DetailScreen({super.key});
  
//  Size size = MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: _buildBody()
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
          height: 250,
          color: Colors.orange,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
                IconButton(onPressed: (){}, icon: Icon(Icons.share))
              ],
            ),
          ),
        )
      ],
    );
  }
}