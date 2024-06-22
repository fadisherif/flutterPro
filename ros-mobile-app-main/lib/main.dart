// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ros_app/injection.dart';
// import 'package:ros_app/motorCommand/application/bloc/motor_control_bloc.dart';
// import 'package:ros_app/presentation/screens/mapPage.dart';
// import 'package:ros_app/presentation/screens/homepage.dart';
// import 'package:ros_app/presentation/screens/motor_controller_page.dart';

// import 'cameraVisualization/application/bloc/camera_node_bloc.dart';

// void main() {
//   configureDependencies();
//   runApp(RosApp());
// }

// class RosApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => getIt<MotorControlBloc>(),
//         ),
//         BlocProvider(
//           create: (context) => getIt<CameraNodeBloc>(),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         routes: {
//           '/': (context) => HomePage(),
//           '/controller': (context) => MotorControlPage(),
//           '/map': (context) => MapPage(),
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ros_app/injection.dart';
import 'package:ros_app/motorCommand/application/bloc/motor_control_bloc.dart';
import 'package:ros_app/presentation/screens/mapPage.dart';
import 'package:ros_app/presentation/screens/homepage.dart';
import 'package:ros_app/presentation/screens/motor_controller_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Import Google Maps Flutter

import 'cameraVisualization/application/bloc/camera_node_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widgets binding
  configureDependencies();
  runApp(RosApp());
}

class RosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MotorControlBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<CameraNodeBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => HomePage(),
          '/controller': (context) => MotorControlPage(),
          '/map': (context) => MapPage(),
        },
      ),
    );
  }
}
