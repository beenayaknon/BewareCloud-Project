import 'package:flutter/material.dart';

class WeatherShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/Weather');
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a city',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Color.fromARGB(255, 238, 238, 238),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
              children: <Widget>[
                ProductBox(
                  name: "Cloudy",
                  location: "Bangkok",
                  degree: 33,
                  isNetworkImage: false,
                  image: "cloudy.jpeg",
                  onDelete: () {
                    // Implement delete functionality here
                    print("Delete button pressed for Cloudy");
                  },
                ),
                ProductBox(
                  name: "Sunny",
                  location: "Chonburi",
                  degree: 35,
                  isNetworkImage: false,
                  image: "sunny.jpeg",
                  onDelete: () {
                    // Implement delete functionality here
                    print("Delete button pressed for Sunny");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({
    Key? key,
    required this.name,
    required this.location,
    required this.degree,
    required this.isNetworkImage,
    required this.image,
    required this.onDelete,
  }) : super(key: key);

  final String name;
  final String location;
  final int degree;
  final bool isNetworkImage;
  final String image;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 160,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Stack(
          children: [
            Positioned.fill(
              child: isNetworkImage
                  ? Image.network(
                      image,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "assets/appimages/" + image,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            this.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            this.location,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            this.degree.toString() + "℃",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: onDelete,
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Delete this pin',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
