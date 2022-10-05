import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:poke_app/pokedetail.dart';
import 'package:poke_app/pokemon.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: "Pokemon App",
  theme: ThemeData(
    primarySwatch: Colors.teal,
  ),
  home: HomePage(),
  ));

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}
class HomePageState extends State<HomePage> {

  var url = 'https://raw.githubusercontent.com/biuni/pokemongo-pokedex/master/pokedex.json';

   PokeHub? pokeHub;
  @override
  void initState() {
    super.initState();

    fetchData();
  }
  Future fetchData() async{
    var res =await http.get(Uri.parse(url));
    var decodedValue = jsonDecode(res.body);

    pokeHub = PokeHub.fromJson(decodedValue);
    setState(() {
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.teal,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        centerTitle: true,
        title: Text('Pokemon App'),
      ),
      body:pokeHub == null? Center(child: CircularProgressIndicator()):
      GridView.count(crossAxisCount: 2,
      children: pokeHub!.pokemon!.map((Pokemon poke) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(
                builder: (context)=> pokeDetails(
                pokemon: poke)));
          },
          child: Card(
            elevation: 3.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Hero(
                  tag: poke.img.toString(),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(poke.img.toString()))),
                  ),
                ),
                Text(
                  poke.name.toString(),style: TextStyle(
                  fontSize:22.0 ,
                  fontWeight: FontWeight.bold
                ),
                ),
              ],
            ),
          ),
        ),
      )).toList(),
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.refresh),
      ),
    );
  }
}


