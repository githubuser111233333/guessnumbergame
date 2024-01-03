import 'package:flutter/material.dart';
import './hits.dart';


void main() {
  runApp(const MaterialApp(
    home: LeaderboardsStateful(),
    debugShowCheckedModeBanner: false,
  ));
}

class LeaderboardsStateful extends StatefulWidget {
  const LeaderboardsStateful({Key? key}) : super(key: key);

  @override
  LeaderboardsState createState() => LeaderboardsState();
}

class LeaderboardsState extends State<LeaderboardsStateful> {
  List<Hits> _hits = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    try {
      List<Hits> hits = await Hits.fetchHits();
      print(hits);

      setState(() {
        _hits = hits;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching hits: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to fetch hits. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Global Leaderboards'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/backgroundIMG.jpeg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  if (_isLoading) ...[
                    const CircularProgressIndicator(),
                  ] else if (_hits.isNotEmpty) ...[
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: FittedBox(
                        child: DataTable(
                          headingRowColor:
                          MaterialStateColor.resolveWith((states) => Colors.black87),
                          dataRowColor:
                          MaterialStateColor.resolveWith((states) => Colors.black54),
                          columns: const [
                            DataColumn(
                              label: Text('Player ID', style: TextStyle(color: Colors.white)),
                            ),
                            DataColumn(
                              label: Text('Total Hits', style: TextStyle(color: Colors.white)),
                            ),
                            DataColumn(
                              label: Text('Attempts', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                          rows: _hits.map((Hits) {
                            return DataRow(cells: [
                              DataCell(Text(Hits.playerId.toString(), style: TextStyle(color: Colors.white))),
                              DataCell(Text(Hits.totalHits.toString(), style: TextStyle(color: Colors.white))),
                              DataCell(Text(Hits.attempts.toString(), style: TextStyle(color: Colors.white))),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
