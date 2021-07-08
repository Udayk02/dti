import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  List<double> accSensor = [0.0, 0.0, 0.0];
  List<double> gyroSensor = [0.0, 0.0, 0.0];

  Position currentPosition = Position(longitude: 0.0, latitude: 0.0, timestamp: null, accuracy: 0.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0);

  // _HomeState({this.currentPosition = const Position(longitude: 0.0, latitude: 0.0, timestamp: null, accuracy: 0.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0)});

  _getCurrentLocation() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event){
      setState(() {
        accSensor[0] = event.x;
        accSensor[1] = event.y;
        accSensor[2] = event.z;
      });
    });
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        gyroSensor[0] = event.x;
        gyroSensor[1] = event.y;
        gyroSensor[2] = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text(
            "Home",
          style: TextStyle(
            color: Color(0xFFEDF0DA),
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0077B6),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Given Contact Information:",
                      style: TextStyle(
                        color: Color(0xFF0096C7),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      "Name: ${data["name"]}\nMobile Number: ${data["number"]}\nEmail Address: ${data["email"]}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        letterSpacing: 1.0
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Latitude: ${currentPosition.latitude}\nLongitude: ${currentPosition.longitude}",
                        style: TextStyle(
                          fontSize: 18.0,
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      ElevatedButton.icon(
                        onPressed: () {
                          _getCurrentLocation();
                        },
                        icon: Icon(
                          Icons.location_on,
                        ),
                        label: Text(
                          "Get Location",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFF0096C7)),
                          fixedSize: MaterialStateProperty.all(Size(250.0, 40.0)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Accelerometer Sensor Details:\nx: ${accSensor[0]}\ny: ${accSensor[1]}\nz: ${accSensor[2]}",
                        style: TextStyle(
                          fontSize: 18.0,
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Text(
                          "Gyroscope Sensor Details:\nx: ${gyroSensor[0]}\ny: ${gyroSensor[1]}\nz: ${gyroSensor[2]}",
                        style: TextStyle(
                          fontSize: 18.0,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/trigger', arguments: {
                    "email": data["email"],
                    "latitude": currentPosition.latitude,
                    "longitude": currentPosition.longitude,
                  });
                },
                child: Text(
                  "Simulate Accident Detection",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF0096C7)),
                  fixedSize: MaterialStateProperty.all(Size(250.0, 40.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
