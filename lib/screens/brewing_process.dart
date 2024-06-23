import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sornaplo/screens/public_recipes_screen.dart';
import 'package:sornaplo/screens/signin_screen.dart';
import 'package:sornaplo/utils/colors_utils.dart';
import 'event_screen.dart';
import 'home_screen.dart';

class BrewingProcessScreen extends StatelessWidget {
  const BrewingProcessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: hexStringToColor("EC9D00"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text("Sörfőzés folyamata"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sörfőzés folyamata',
              style: TextStyle(fontSize: 26,
                  fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(height: 8),
            Image.asset('assets/images/different_beers.png'),
            SizedBox(height: 8),

            Text(
              'Kezdjük azzal, hogy mi is a sör?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Text(
              'A sör olyan erjesztett szén-dioxidban dús alkoholos ital, mely vízből, malátából és komlóból áll, és az erjesztéshez sörélesztőt használnak. A sörkészítéshez tehát 4 alapanyagra van szükségünk:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: 'Víz – ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'ez a sör alapja',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: 'Maláta – ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'ez tartalmazza az erjeszthető cukrokat, ebből lesz az alkohol a sörben. Minél több malátát adunk a sörhöz, annál magasabb lesz az „extrakt-tartalma” (= Balling fok, Plato) és ezáltal az alkoholtartalma is.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: 'Komló – ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'ez adja a sör keserűségét, illetve aromáját: több komló = keserűbb és/vagy aromásabb sör.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: 'Sörélesztő – ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'az élesztő alakítja át a malátában lévő oldható cukrokat alkohollá. Alapvetően két fajtája van: alsóerjesztésű (ale sörök élesztője) és felsőerjesztésű (láger sörök élesztője).',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Alapanyagok',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Image.asset('assets/images/beer_ingredients.png'),
            SizedBox(height: 16),
            Text(
              'A sör alapanyagai a következők: ivóvíz, maláta, komló, sörélesztő. A fentieken kívül még más alapanyagokat is használhatnak a sör készítéséhez (pl. ipari sörökhöz kukoricadara, belga sörök: gyümölcsök, kandiscukor), de alapvetően ez a 4 alkotórész az, ami szükséges a sörkészítéshez.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Hogyan néz ki a sörkészítés folyamata',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            Text.rich(
              TextSpan(
                text: 'Eszközök tisztítása –',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text:'Eszközök tisztítása – hogy ne fertőződjön be a sör, minden sörfőzés az eszközök alapos eltisztításával kezdődik.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: 'Malátaroppantás – ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text:'a maláta egész, sértetlen malátázott árpaszemeket tartalmaz. Ahhoz, hogy a cefrézővíz '
                        'jobban ki tudja oldani a szemek belsejéből az oldható cukrokat, a magvakat meg kell törni, „roppantani” kell, de nem szabad teljesen lisztté őrölni. Ha lisztté őrölnénk, a cefretörköly nem akadna fenn a szűrés során a szűrőrácson.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: 'Sörfőzés: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: ' \n1. cefrézés, \n2. szűrés, \n3. máslás, \n4. komlóforralás, \n5. hűtés és komlószűrés, \n6. beélesztőzés.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: 'Erjesztés – ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'ezt főerjedésnek is nevezzük, mivel főként ekkor zajlik a cukor alkohollá történő alakítása. Jellemzően '
                        'egy hétig tart. A főerjedés végén kapott sör az ún. „fickósör”.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: 'Palackozás – ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'a legtöbb otthonfőző palackokba fejti a sört a főerjedés után.'
                        ' Ehhez vagy kupakos – koronazáras – üvegeket, vagy csatosüvegeket lehet használni.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: 'Utóerjedés/Ászokolás – ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'az utóerjedés, ászokolás jellemzően a palackban zajlik le. '
                        'Célja a sörben lévő maradékcukrok lebontása, a sör telítése szén-dioxiddal, és a sör érlelése, '
                        'ízeinek összeérése. Jellemzően 2-3 hétig tart minimum. Palackozáskor sokan adagolnak még cukrot a fickósörhöz, '
                        'így mindenképpen lesz még cukor, amit az élesztő el tud bontani, és így biztosan lesz szén-dioxid a kész sörben.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Text(
              'Sörfőzés lépésről lépésre',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Image.asset('assets/images/brewing_process.png'),
            SizedBox(height: 16),


            Text.rich(
              TextSpan(
                text: 'Cefrézés: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'a legtöbb otthonfőző ma már sörfőző készülékkel dolgozik, amely automatikusan fűti a vizet és keveri a cefrét. A lépcsőzetes '
                        'cefrézés során 2-3 hőmérsékleti lépcsőt alkalmaznak, de nagyon sokan az egylépcsős cefrézést alkalmazzák.'
                        '\nEgylépcsős cefrézés esetén 65-67 oC-on pihentetik a cefrét. Azt a hőmérsékletet, amikor, a malátát hozzáadjuk a cefrézővízhez „becefrézési hőmérsékletnek”'
                        ' nevezzük. A cefrézés célja, hogy optimális körülményeket biztosítson azoknak az enzimeknek – elsősorban a béta-amiláznak -, amelyek'
                        ' a maláta tartaléktápanyagát, a keményítőt, az élesztő számára már hozzáférhető, erjeszthető cukrokká alakítják.'
                        '\nAz utolsó, legmagasabb hőmérsékletet, amelyen még megpihentetjük a malátát „elcukrosítási” hőmérsékletnek nevezzük. Amennyiben géppel főzünk, úgy csak be'
                        ' kell programozunk a cefrézési lépcsőket – milyen hőmérsékleten, mennyi ideig pihenjen a maláta -, és utána csak a vizet és malátát'
                        ' kell betölteni, a többit a készülék elvégzi.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),


            SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: 'Szűrés: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'célja, hogy a cefretörkölyt – a maláta oldhatatlan anyagait – a tiszta folyadék „sörlétől” elválasszuk. Ha nem készülékben,'
                        ' hanem üstben főzünk, akkor úgy végezzük, hogy a sörlét a cefrével együtt átmerjük egy szűrőfenékkel ellátott edénybe, mely leeresztőcsappal rendelkezik. '
                        '\nA leeresztőcsapon a tisztasörlét egy másik edénybe engedjük, míg a szűrőfenéken a cefre fennmarad. A sörfőzőgépek általában ún. malátahengert tartalmaznak, '
                        'ami azt jelenti, hogy a malátát nem közvetlenül a vízbe, hanem egy ún. perforált malátahengerbe helyezzük: a perforáción a maláta nem, csak a víz tud átjutni, '
                        'így a szűrés mindössze annyiból áll, hogy a malátahengert kiemeljük az üstből.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: 'Máslás: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'máslás során a leszűrt cefretörkölyt melegvízzel átmossuk, és az így kapott levet a sörléhez öntjük. A máslás célja, hogy a cefrézés során a '
                        'cefretörkölyből még ki nem mosott cukrot is oldatba vigyük – semmi se vesszen kárba! A recept során általában megszokták adni, '
                'hogy hány fokos, és milyen mennyiségű máslóvizet használjunk a másláshoz.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            Text.rich(
              TextSpan(
                text: 'Komlóforralás: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'a komlóforralás során a komlót hozzáadjuk a sörléhez, és vele együtt főzzük sörlét. A komlóforralás célja: a sörlé sterilizálása '
                        'forralással, és a komló keserű és aromaanyagok beoldódásának elősegítése a sörbe, azaz a sör ízesítése és tartósítása. A tartósításról '
                        'elsősorban az antimikrobiális hatású keserűanyagok – alfa-sav – gondoskodik, míg az aromáról a komlóban lévő illóolajok. A keserűanyagok '
                        'sörlébe oldódásához időre van szükség, és fontos, hogy forrjon a sörlé. Ezért ha keserű sört szeretnénk, minimum egy órán át kell '
                        'forralni a komlóval a sört. Ha azonban azt szeretnénk, hogy aromás legyen a sör, akkor a forralás végén kell a komlót adagolni. Emiatt '
                        'ha keserű és aromás sört szeretnénk, akkor minimum két adagban kell hozzáadni a komlót: első adagot korán, a keserűanyagok miatt, a másik '
                        'adagot későn, a forralás végén, az aromák miatt.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            Text.rich(
              TextSpan(
                text: 'Hűtés és komlószűrés: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'mivel a magas hőmérséklet elpusztítja az élesztősejteket, ezért ezen lépés célja, hogy arra a hőmérsékletre '
                        'hűtsük a sörlevet, amely már optimális az élesztők számára. A komlómaradványokat azért kell eltávolítani, hogy ne tegyék kellemetlenül zavarossá a sört.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: 'Beélesztőzés: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'amint a sörlé hőmérséklete elérte az alkalmazott sörélesztő működésének felső határát, az élesztőt '
                        'hozzáadjuk a sörléhez, és elkeverjük. Ezt követően – élesztő típusától függően – 5-10 napot vesz igénybe a '
                        'főerjedés, melynek során az élesztő az erjeszthető cukrokat alkohollá alakítja.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Recipes',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: hexStringToColor("EC9D00"),
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        },
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.fromLTRB(50, 10 , 140, 50),
              decoration: BoxDecoration(
                color: hexStringToColor("EC9D00"),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Sörnapló',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Recipes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PublicRecipesScreen()),
                );
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.person_pin_rounded),
            //   title: Text('Profil'),
            //   onTap: () {
            //     // profil
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.scatter_plot_outlined),
              title: Text('Sörfőzés folyamata'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BrewingProcessScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today_outlined),
              title: Text('Esemény naptár'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventScreen(),
                  ),
                );
              },
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
