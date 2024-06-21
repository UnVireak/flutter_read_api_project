import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _buildBody(context, screenHeight),
    );
  }

  Widget _buildBody(BuildContext context, double screenHeight) {
    return Stack(
      children: [
        Container(
          height: screenHeight * 0.3, // Corrected typo: use 0.3 instead of 03
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                "https://www.investopedia.com/thmb/XJDLdvCuNbcWk_EVZzXx84ae82c=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-1258889149-1f50bb87f9d54dca87813923f12ac94b.jpg", // Replace with your image URL
                fit: BoxFit.cover,
              ),
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    IconButton(
                      onPressed: () {}, 
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {}, 
                      icon: Icon(Icons.share, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  
                ),
                child:
               
                DecoratedBox(
                  decoration: BoxDecoration(
                    
                  ),
                  child: Text("djfh", style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
        // Add additional widgets here as needed
      ],
    );
  }
}
