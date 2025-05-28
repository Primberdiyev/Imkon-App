import 'package:flutter/material.dart';
import 'package:imkon/features/statistics/models/competitor_model.dart';

class Statics extends StatefulWidget {
  const Statics({super.key});

  @override
  State<Statics> createState() => _StaticsState();
}

class _StaticsState extends State<Statics> {
  String selectedField = fields[0];

  @override
  Widget build(BuildContext context) {
    final filteredCompetitors = competitors
        .where(
          (comp) =>
              comp.joinedFields.toLowerCase() == selectedField.toLowerCase(),
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Raqobat Jadvali',
          style: TextStyle(fontFamily: 'myFirstFont'),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.orange.shade100,
                filled: true,
              ),
              value: selectedField,
              items: fields
                  .map(
                    (field) =>
                        DropdownMenuItem(value: field, child: Text(field)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedField = value ?? fields[0];
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCompetitors.length,
              itemBuilder: (context, index) {
                final comp = filteredCompetitors[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(comp.imagePath),
                          radius: 30,
                        ),
                        title: Text(
                          comp.fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${comp.score} ball',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
