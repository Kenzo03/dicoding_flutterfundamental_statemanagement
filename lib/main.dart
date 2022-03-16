import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/done_module_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DoneModuleProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const ModulePage(),
      ),
    );
  }
}

class ModulePage extends StatefulWidget {
  const ModulePage({Key? key}) : super(key: key);

  @override
  State<ModulePage> createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  final List<String> doneModuleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Memulai Pemrograman Dengan Dart'),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.done),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoneModuleList(),
                        ));
                  })
            ]),
        body: ModuleList(doneModuleList: doneModuleList));
  }
}

class ModuleList extends StatefulWidget {
  final List<String> doneModuleList;

  const ModuleList({required this.doneModuleList});

  @override
  State<ModuleList> createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> {
  final List<String> moduleList = [
    'Modul 1 - Pengenalan Dart',
    'Modul 2 - Memulai Pemrograman dengan Dart',
    'Modul 3 - Dart Fundamental',
    'Modul 4 - Control Flow',
    'Modul 5 - Collections',
    'Modul 6 - Object Oriented Programming',
    'Modul 7 - Functional Styles',
    'Modul 8 - Dart Type System',
    'Modul 9 - Dart Futures',
    'Modul 10 - Effective Dart',
  ];

  // const ModuleList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: moduleList.length,
        itemBuilder: (context, index) {
          return Consumer<DoneModuleProvider>(
              builder: (context, DoneModuleProvider data, widget) {
            return ModuleTile(
              moduleName: moduleList[index],
              isDone: data.doneModuleList.contains(moduleList[index]),
              onClick: () {
                setState(() {
                  data.complete(moduleList[index]);
                });
              },
            );
          });
        });
  }
}

class ModuleTile extends StatelessWidget {
  final String moduleName;
  final bool isDone;
  final Function() onClick;

  const ModuleTile(
      {Key? key,
      required this.moduleName,
      required this.isDone,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(moduleName),
        trailing: isDone
            ? const Icon(Icons.done)
            : ElevatedButton(child: const Text('Done'), onPressed: onClick));
  }
}

class DoneModuleList extends StatelessWidget {
  // final List<String> doneModuleList;

  const DoneModuleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doneModuleList =
        Provider.of<DoneModuleProvider>(context, listen: false).doneModuleList;
    return Scaffold(
        appBar: AppBar(title: const Text('Done Module List')),
        body: ListView.builder(
            itemCount: doneModuleList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(doneModuleList[index]),
              );
            }));
  }
}
