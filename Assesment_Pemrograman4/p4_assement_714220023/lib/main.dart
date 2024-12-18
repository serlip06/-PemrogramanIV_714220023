import 'package:flutter/material.dart';
import 'package:p4_assement_714220023/bottom_navbar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: DynamicBottomNavbar(),
    );
  }
}

class HollywoodScreen extends StatefulWidget {
  const HollywoodScreen({super.key});

  @override
  State<HollywoodScreen> createState() => HollywoodScreenState();
}

class HollywoodScreenState extends State<HollywoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hollywood'),
        backgroundColor: const Color.fromARGB(255, 160, 118, 109),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Hollywood Description
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 160, 118, 109), // Soft Coklat
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text(
                  'Hollywood is the center of the American film industry, located in Los Angeles, California. It is renowned for producing some of the world\'s most successful films and has become synonymous with the global entertainment industry.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Actor 1 Data
              actorCard(
                'Sebastian Stan',
                'Sebastian Stan is a Romanian-American actor best known for his role as Bucky Barnes / The Winter Soldier in the Marvel Cinematic Universe (MCU).',
                'sebastianstan.jpg',
                'Film: Captain America: The Winter Soldier (2014),Avengers: Endgame (2019)',
              ),
              // Actor 2 Data
              actorCard(
                'Tom Holland',
                'Tom Holland is a British actor widely known for his role as Peter Parker / Spider-Man in the Marvel Cinematic Universe (MCU)..',
                'tomholland.jpg',
                'Film: Spider-Man: Homecoming (2017), Avengers: Infinity War (2018)',
              ),
              // Actor 3 Data
              actorCard(
                'Robert Downey Junior',
                'Robert Downey Jr. is one of the most famous and successful actors in Hollywood, best known for his iconic role as Tony Stark / Iron Man in the Marvel Cinematic Universe (MCU).',
                'RDJ.jpg',
                'Film: Iron Man (2008), Avengers: Endgame (2019)',
              ),
              actorCard(
                'Benedict Cumberbatch',
                'Benedict Cumberbatch is a British actor known for his diverse roles and his ability to portray complex characters. One of his most famous roles is as Doctor Strange in the Marvel Cinematic Universe (MCU).',
                'doctorstrange.jpg',
                'Film: Doctor Strange (2016), The Imitation Game (2014)',
              ),
              actorCard(
                'Mark Wahlkberg',
                'Mark Wahlberg is an American actor, producer, and entrepreneur known for his long career in the entertainment industry. In addition to being a film star, he is also recognized as a former member of the music group Marky Mark and the Funky Bunch.',
                'markwahlkberg.jpg',
                'Film: Transformers: Age of Extinction (2014), The Fighter (2010)',
              ),
              // Film Slideshow at the bottom
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Hollywood Films',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Image Slider bagiain bawah
              SizedBox(
                height: 250.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Image.asset('images/winterfalcon.jpg', width: 150, fit: BoxFit.cover),
                    Image.asset('images/thunderbolts.jpg', width: 150, fit: BoxFit.cover),
                    Image.asset('images/postter_uncharted.jpg', width: 150, fit: BoxFit.cover),
                    Image.asset('images/postter_nowayhome.jpg', width: 150, fit: BoxFit.cover),
                    Image.asset('images/ironman.jpg', width: 150, fit: BoxFit.cover),
                    Image.asset('images/jumanji.jpg', width: 150, fit: BoxFit.cover),
                    Image.asset('images/film_endgame.jpg', width: 150, fit: BoxFit.cover),
                    Image.asset('images/film_farhome.jpg', width: 150, fit: BoxFit.cover),
                    Image.asset('images/film_moana.jpg', width: 150, fit: BoxFit.cover),
                    Image.asset('images/film_narnia1.jpg', width: 150, fit: BoxFit.cover),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable widget for Actor Data
  Widget actorCard(String name, String description, String image, String films) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              // Actor Image clipprrect fungsinya untuk membulatkan ujung gambarnya 
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'images/$image', // Replace with the image path
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0), // Spacer between image and text
              // Actor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      films,
                      style: const TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
