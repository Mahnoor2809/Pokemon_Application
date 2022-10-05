import 'package:flutter/material.dart';
import 'package:poke_app/pokemon.dart';

class pokeDetails extends StatelessWidget {
  late final Pokemon pokemon;

  pokeDetails({required this.pokemon});

  bodyWidget(BuildContext context) => Stack(
    children: [
      Positioned(
        height: MediaQuery.of(context).size.height/1.5,
        width: MediaQuery.of(context).size.width-20,
        left: 10.0,
        top: MediaQuery.of(context).size.height*0.1,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 50,),
              Text(pokemon.name.toString(),style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
              Text("Height: ${pokemon.height}"),
              Text("Weight: ${pokemon.weight}"),
              Text("Types"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.type!.map((t) => FilterChip(label: Text(t),
                    backgroundColor:Colors.amber,
                    onSelected: (b){})).toList(),
              ),
              Text("Weaknesses"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.weaknesses!.map((t) => FilterChip(label: Text(t,style: TextStyle(
                  color: Colors.white
                ),),
                    backgroundColor:Colors.red,
                    onSelected: (b){})).toList(),
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment:Alignment.topCenter ,
        child: Hero(
          tag: pokemon.img.toString(), child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(pokemon.img.toString()),fit: BoxFit.cover),
          ),
        ),
        ),
      )
    ],

  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(pokemon.name.toString()),
      ),
      body: bodyWidget(context),
    );
  }
}
