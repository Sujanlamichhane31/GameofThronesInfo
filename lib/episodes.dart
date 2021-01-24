import 'package:flutter/material.dart';
import 'package:gameofthrones/gameofthronemodel.dart';

// ignore: must_be_immutable
class EpisodesPage extends StatelessWidget {
  
  final List<Episodes> episodes;
  final MyImage image;
  EpisodesPage({this.episodes, this.image});
  BuildContext _context;
  
  showSummary(String summary){
    showDialog(context: _context,
    builder: (_context)=> Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              summary
            ),
          ),
        ),
      ),
    )
    );
  }
  
  Widget myBody(){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
        ),
        itemCount: episodes.length,
        itemBuilder: (context, index){
          return InkWell(
            onTap: (){
              showSummary(episodes[index].summary);
            },
            child: Card (
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    episodes[index].image.original,
                  fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(episodes[index].name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),)
                      ],
                    ),
                  ),
                  Positioned(
                      left: 0.0,
                      top: 0.0,
                      child: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("${episodes[index].season}-${episodes[index].number}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
          
        });
  }
  
  @override
  Widget build(BuildContext context) {
    
    _context= context;
    return Scaffold(
      appBar: AppBar(
      title: Row(
        
        children: [
          Hero(
            tag: "g1",
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  image.medium
              ),
            ),
          ),
          SizedBox(width: 10.0,),
          Center(
            child: Text(
              "All Episodes",
            ),
          ),
        ],
      )
      ),
      body: myBody(),
    );
  }
}
