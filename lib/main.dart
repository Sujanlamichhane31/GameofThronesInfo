import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gameofthrones/episodes.dart';
import 'package:gameofthrones/gameofthronemodel.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  String url = "http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes";
  
 
  
  GotModel gotModel;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEpisodes();
  }
  
  fetchEpisodes() async {
    var result = await http.get(url);
    var decodedResult = jsonDecode(result.body);
    print(decodedResult);
    gotModel= GotModel.fromJson(decodedResult);
    setState(() {
    
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Game of Thrones')),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
        },
      ),
      body:  SingleChildScrollView
        (
        child: gotModel == null ?Center(
          child: CircularProgressIndicator(),
        )
            :Card(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: "g1",
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: NetworkImage(gotModel.image.original),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  gotModel.name,
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Runtime: ${gotModel.runtime.toString()} minutes",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent
                  ),),
                SizedBox(
                  height: 20.0,
                ),
                Text(gotModel.summary),
        
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                    color: Colors.red,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> EpisodesPage(episodes: gotModel.eEmbedded.episodes,
                        image: gotModel.image,)));
                    },
                    child: Text("All Episodes", style: TextStyle(
                      color: Colors.white,
                    ),)
                )
                ,
              ],
            ),
          ),
        ),
        
      )
    );
  }
}

