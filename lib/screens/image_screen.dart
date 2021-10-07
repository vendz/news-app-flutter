import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ImageScreen extends StatefulWidget {
  final String imageUrl;
  final String headline;
  ImageScreen({required this.imageUrl, required this.headline});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen>
    with TickerProviderStateMixin {
  final controller = TransformationController();
  bool _showConnected = false;
  bool isLightTheme = true;
  late TapDownDetails _doubleTapDetails;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((event) {
      checkConnectivity();
    });
    getTheme();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 150,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    controller.dispose();
  }

  getTheme() async {
    final settings = await Hive.openBox('settings');
    setState(() {
      isLightTheme = settings.get('isLightTheme') ?? false;
    });
  }

  checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    showConnectivitySnackBar(result);
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
    var isConnected = result != ConnectivityResult.none;
    if (!isConnected) {
      _showConnected = true;
      final snackBar = SnackBar(
          content: Text(
            "You are Offline",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (isConnected && _showConnected) {
      _showConnected = false;
      final snackBar = SnackBar(
          content: Text(
            "You are back Online",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222222),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onDoubleTapDown: _handleDoubleTapDown,
                onDoubleTap: _handleDoubleTap,
                child: InteractiveViewer(
                  child: Hero(
                    tag: 'image-${widget.imageUrl}',
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                    ),
                  ),
                  transformationController: controller,
                  maxScale: 3,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              widget.headline,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (controller.value != Matrix4.identity()) {
      final animationReset = Matrix4Tween(
        begin: controller.value,
        end: Matrix4.identity(),
      ).animate(_animationController);

      _animationController.addListener(() {
        controller.value = animationReset.value;
      });
      _animationController.reset();
      _animationController.forward();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a 2x zoom
      var _endMatrix = Matrix4.identity()
        ..translate(-position.dx, -position.dy)
        ..scale(2.0);

      final animationReset = Matrix4Tween(
        begin: controller.value,
        end: _endMatrix,
      ).animate(_animationController);

      _animationController.addListener(() {
        controller.value = animationReset.value;
      });

      _animationController.reset();
      _animationController.forward();
    }
  }
}
