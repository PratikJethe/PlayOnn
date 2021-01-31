import 'package:flutter/material.dart';
import 'package:playonn/UtilityFunctions/FetchData.dart';
import 'package:carousel_pro/carousel_pro.dart';

class GameListingScreen extends StatefulWidget {
  @override
  _GameListingScreenState createState() => _GameListingScreenState();
}

class _GameListingScreenState extends State<GameListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Game Listings',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Something went wrong...try again!'),
                  FlatButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text('Rety'))
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return ListView(children: [
              ...snapshot.data.map((sport) {
                return sportListElement(sport);
              })
            ]);
          }

          return Container();
        },
      ),
    );
  }
}

Widget sportListElement(sport) {
  print(sport['dayOfWeeksOpen']);
  final openDays = sport['dayOfWeeksOpen'] == null
      ? 'No Days'
      : sport['dayOfWeeksOpen']
          .reduce((value, element) => value + ', ' + element);
  print(openDays);

  print(sport['images']);

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Arena Name: ${sport['name']}', style: TextStyle(fontSize: 20)),
          SizedBox(
            height: 10,
          ),
          Text('Days Open: ${openDays}'),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Open time:${sport['openTime']}',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
              Text('Close time:${sport['closeTime']}',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('slot time size:${sport['slotTimeSize']}'),
              Text('Close time:${sport['costPerSlot']}'),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sport\'s Name:${sport['sports']['name']}  ',
                style: TextStyle(fontSize: 15),
              ),
              Image.network(
                '${sport['sports']['iconBlackUrl']}',
                height: 20,
                width: 20,
              ),
            ],
          ),
          SizedBox(height: 20,),
          sport['images'] != null?
            SizedBox(
                height: 150.0,
                width: 300.0,
                child: Carousel(images: [
                  ...sport['images'].map((link) {
                    return NetworkImage('${link}');
                  })
                ])):Text('No Images available',style: TextStyle(color: Colors.red),),
        ],
      ),
    ),
  );
}
