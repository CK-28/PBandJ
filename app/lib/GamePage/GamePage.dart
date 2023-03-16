import 'package:flutter/material.dart';
import '../data/Game.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class GamePage extends StatefulWidget {
  final Game game;
  const GamePage({super.key, required this.game});

  @override
  State<GamePage> createState() => _GamePage();
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          color: Colors.white,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 45.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: 90,
          maxDistance: widget.distance * (i + 1),
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.add),
            backgroundColor: Color(0xFF9CEAEF),
            foregroundColor: Colors.black
          ),
        ),
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.label,
  });

  final VoidCallback? onPressed;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialButton(
      onPressed: onPressed,
      child: label,
      height: 30,
      minWidth: 90,
      color: Color(0xFF9CEAEF),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (3.14 / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * 3.14 / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

class _GamePage extends State<GamePage>{
  bool addButVis = false;

  void _showAction() {

  }

  @override
  Widget build(BuildContext context) {
    Game thisGame = widget.game;
    List<String> tags = thisGame.tags();

    DateFormat dateFormat = DateFormat("yyyy/MM/dd");

    int _selectedIndex = 0;

    var stringRating = (thisGame.rating != null) ? thisGame.rating!.toStringAsFixed(2): "N/A";

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color(0xFF875632),
        title: const Text(
          "Game Page",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: 
      Container(
        // color: Color(0xFFF8D5BC),
        child: ListView(
          children:[ 
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [ 
                Stack(
                  children: <Widget>[
                    SizedBox(
                            height: (222),
                            child: Container(
                                color:  Color(0xFFEC4686),//remove color to make it transpatrent
                                child: const Center(child: Text(""))),
                          ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          child:FadeInImage(
                              placeholder: MemoryImage(kTransparentImage),
                            image: NetworkImage((thisGame.imageId == null || thisGame.imageId!.isEmpty)?
                            "https://images.igdb.com/igdb/image/upload/t_1080p/nocover.png":
                            thisGame.getImageFromId("1080p")),
                              width: 135,
                          )           
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(thisGame.name, style: TextStyle(
                                fontSize: 25
                              )),
                              Text("Developer: " + thisGame.developer(), style: TextStyle(
                                fontSize: 16
                              )),
                              Text("Release Date: " + dateFormat.format(thisGame.release)),
                              Text("Platforms: ${thisGame.platformList().take(5).join(", ")}"),
                            ]
                          )
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [ 
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Description", style: TextStyle(
                        fontSize: 18
                      ))
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Container( // needs to be an expanded
                              height: 400,
                              width: 275,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                  ),
                                ]
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text(thisGame.summary)
                            )
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                color: Color(0xFFCE9164),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                  ),
                                ]
                              ),
                              padding: EdgeInsets.all(5),
                              width: 100,
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Review Score:", textAlign: TextAlign.center),
                                  Text(stringRating, textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                  ))
                                ]
                              ),
                            ),
                            SizedBox(height:30),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                color: Color(0xFFCE9164),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                  ),
                                ]
                              ),                              
                              padding: const EdgeInsets.all(5),
                              width: 100,
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Age Rating:", textAlign: TextAlign.center),
                                  Text(thisGame.stringAgeRating(), textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                  ))
                                ]
                              ),
                            ),              
                          ],
                        ) 
                      ],
                    ),
                    Container(
                      width: 350,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Wrap( 
                        children: [
                          for(String t in tags)
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Color(0xFF9CEAEF),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                  ),
                                ]
                              ),       
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              child: Text(t, textAlign: TextAlign.center)
                            ),            
                          ),
                        ],
                      ),       
                    )                      
                  ],
                ),
              ],
            ),
          ]
        ),
      ),
      floatingActionButton: ExpandableFab(
        distance: 50.0,
        children: [
          ActionButton(
            onPressed: () => _showAction(),
            label: const Text("Playing"),
          ),
          ActionButton(
            onPressed: () => _showAction(),
            label: const Text("Backlog"),
          ),
          ActionButton(
            onPressed: () => _showAction(),
            label: const Text("Ongoing"),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFEC4686),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Browse",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}