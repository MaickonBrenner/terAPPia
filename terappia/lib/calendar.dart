import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:terappia/TelaInicial.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendário de Pacientes',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Color.fromRGBO(231, 254, 255, 1),
      ),
      home: const Calendario(),
    );
  }
}

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  State<Calendario> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Calendario> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
  }

  TelaInicial telaInicial = new TelaInicial();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: const Text('Calendário de Pacientes'),
              leading: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => telaInicial),
                  );
                },
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.purpleAccent,
                  size: 32,
                ),
              ),
      ),
      body: TableCalendar(
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        focusedDay: _focusedDay,
        firstDay: _firstDay,
        lastDay: _lastDay,
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
        },
        selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarStyle: const CalendarStyle(
          weekendTextStyle: TextStyle(
            color: Colors.purpleAccent,
          ),
          selectedDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.purple,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, day) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(day.toString()),
            );
          },
        ),
      ),
    );
  }
}
