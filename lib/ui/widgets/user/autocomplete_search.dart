import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tasq/models/organizationData.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AutoCompleteSearch extends StatelessWidget {
  final Function onSelected;
  AutoCompleteSearch({this.onSelected});

  final List<Organization> items =
      Provider.of<AuthProvider>(Get.context, listen: false).allOrgaizations;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<AuthProvider>(
          builder: (context, p, _) => TypeAheadField(
                getImmediateSuggestions: true,
                textFieldConfiguration: TextFieldConfiguration(
                  controller: controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 3)),
                ),
                suggestionsCallback: (String pattern) async {
                  return items
                      .where((item) => item.name
                          .toLowerCase()
                          .startsWith(pattern.toLowerCase()))
                      .toList();
                },
                itemBuilder: (context, Organization suggestion) {
                  return ListTile(
                    title: Text(suggestion.name),
                    onTap: () {
                      controller.text = suggestion.name;
                    },
                  );
                },
                onSuggestionSelected: (Organization suggestion) {
                  p.orgToSet = suggestion;
                  onSelected(suggestion);
                },
              )),
    );
  }
}
