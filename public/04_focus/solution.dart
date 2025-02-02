import 'package:flutter/material.dart';

void main() {
  runApp(const WorkshopApp());
}

const _name = 'Workshop: From Mobile to Web/Desktop';

class WorkshopApp extends StatelessWidget {
  const WorkshopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _name,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WorkshopPage(),
    );
  }
}

//Main layout widget
class WorkshopPage extends StatefulWidget {
  const WorkshopPage({Key? key}) : super(key: key);

  @override
  State<WorkshopPage> createState() => _WorkshopPageState();
}

class _WorkshopPageState extends State<WorkshopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_name),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: List.generate(
          8,
              (index) {
            return Cell(index: index);
          },
        ),
      ),
    );
  }
}

//Grid element widget
class Cell extends StatefulWidget {
  final int index;

  const Cell({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  _CellState createState() => _CellState();
}

class _CellState extends State<Cell> {
  static const _hoverDuration = Duration(milliseconds: 300);

  var _isHovered = false;
  var _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: InkWell(
        onLongPress: () => _showDialogInfo(context, widget.index),
        onTap: () => _showInfoPage(context, widget.index),
        mouseCursor: SystemMouseCursors.click,
        onHover: _onChangeHover,
        autofocus: widget.index == 0,
        onFocusChange: _onChangeFocus,
        focusColor: Colors.transparent,
        child: AnimatedScale(
          scale: _isHovered ? 1.1 : 1.0,
          duration: _hoverDuration,
          child: AnimatedPhysicalModel(
            borderRadius: BorderRadius.circular(15),
            color: _isFocused ? Colors.blueGrey : Colors.blue,
            shape: BoxShape.rectangle,
            elevation: _isHovered ? 25 : 10,
            shadowColor: Colors.black,
            duration: _hoverDuration,
            curve: Curves.fastOutSlowIn,
            child: Center(
              child: Text(
                '${widget.index}',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Callback to change hovering state
  void _onChangeHover(bool isHovered) => setState(() {
    _isHovered = isHovered;
  });

  //Callback to change focusing state
  void _onChangeFocus(bool isFocused) => setState(() {
    _isFocused = isFocused;
  });
}

//Full element info widget
class InfoPage extends StatelessWidget {
  final int index;

  const InfoPage({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed information $index'),
      ),
      body: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

//Method shows dialog with info about grid element
void _showDialogInfo(BuildContext context, int index) => showDialog<void>(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: const Text('Info'),
      content: Text('Cell number $index'),
    );
  },
);

//Method opens new page with full info about the element
void _showInfoPage(BuildContext context, int index) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => InfoPage(
      index: index,
    ),
  ),
);
