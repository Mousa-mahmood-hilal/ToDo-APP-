import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/constants.dart';
import 'data/models/todo_model.dart';
import 'data/sources/local_data_source.dart';
import 'logic/blocs/todo_cubit.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoModelAdapter());
  await Hive.openBox<ToDoModel>(AppConstants.hiveBoxName);
  runApp(ToDo());
}

class ToDo extends StatelessWidget {
  final localDataSource = LocalDataSource();

  ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(localDataSource),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
