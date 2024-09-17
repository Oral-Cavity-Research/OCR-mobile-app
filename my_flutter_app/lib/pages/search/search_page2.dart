import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PatientsProvider extends ChangeNotifier {
  List patients = [];
  bool loading = false;
  bool noMore = false;
  int page = 1;
  String search = '';
  String filter = 'Updated Date';
  bool sort = false;

  Future<void> getData() async {
    loading = true;
    notifyListeners();
    final response = await http.get(
      Uri.parse(
          'https://your-api-url.com/user/patient/get?page=$page&search=$search&filter=$filter&sort=$sort'),
      headers: {
        'Authorization': 'Bearer your_token',
        'email': 'your_email',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      patients = data['patients'];
      noMore = data['patients'].length < 20;
    } else {
      // Handle error
    }
    loading = false;
    notifyListeners();
  }

  void loadMore() async {
    if (noMore) return;
    page++;
    await getData();
  }

  void setSearch(String value) {
    search = value;
    page = 1;
    getData();
  }

  void setFilter(String value) {
    filter = value;
    page = 1;
    getData();
  }

  void toggleSort() {
    sort = !sort;
    page = 1;
    getData();
  }
}

class PatientsTable extends StatelessWidget {
  const PatientsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PatientsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          provider.setSearch('');
                        },
                      ),
                    ),
                    onChanged: (value) {
                      provider.setSearch(value);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    // Show filter options
                  },
                ),
                IconButton(
                  icon: provider.sort
                      ? Icon(Icons.arrow_upward)
                      : Icon(Icons.arrow_downward),
                  onPressed: () {
                    provider.toggleSort();
                  },
                ),
              ],
            ),
            Expanded(
              child: provider.loading
                  ? Center(child: SpinKitCircle(color: Colors.blue))
                  : ListView.builder(
                      itemCount: provider.patients.length,
                      itemBuilder: (context, index) {
                        final patient = provider.patients[index];
                        return ListTile(
                          title: Text(patient['patient_name']),
                          subtitle: Text('ID: ${patient['patient_id']}'),
                          onTap: () {
                            // Navigate to patient details
                          },
                        );
                      },
                    ),
            ),
            if (!provider.noMore)
              ElevatedButton(
                onPressed: provider.loadMore,
                child: provider.loading
                    ? CircularProgressIndicator()
                    : Text('Load More'),
              ),
          ],
        ),
      ),
    );
  }
}
