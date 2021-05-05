import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

/** 
 * Uma ideia de como usar ese widget
    TypeAheadFormField<User>(
     hideSuggestionsOnKeyboardHide: false,
     textFieldConfiguration: TextFieldConfiguration(
       controller: _typeAheadController,
       decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
         border: OutlineInputBorder(),
         hintText: 'Search Username',
       ),
     ),
     suggestionsCallback: getSuggestions,
     itemBuilder: (context, User suggestion) {
     final user = suggestion;
       return ListTile(
         leading: Container(
           width: 60,
           height: 60,
           child: Icon(Icons.photo),
            child: Image.network(
               user.imageUrl,
              fit: BoxFit.cover,
            ),
         ),
         title: Text(user.name),
       );
     },
      noItemsFoundBuilder: (context) => Container(
        height: 100,
        child: Center(
          child: Text(
            'No Users Found.',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
     noItemsFoundBuilder: (context) => Container(
       height: 0,
     ),
     validator: (value){
       if(value.isEmpty){
         return 'Please select a city';
       }
       print('Dado selecionado $value');
     },
     onSuggestionSelected: (User suggestion) {
       _typeAheadController.text = suggestion.name;
       setState(() {
         _typeAheadController.text = suggestion.name;
       });
       print(_typeAheadController.text);
     },
   ),

    // LOCAL
   // Idea de como seria la funciona que deseas mapear en el objeto 
   static List<User> getSuggestions(String query){
    print(query);
    if(query == ''){
      return [];
    }
    return List.of(_userOptions).where((user) {
      final userLower = user.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return userLower.contains(queryLower);
    }).toList();
  }


  // API
  class UserApi {
  static Future<List<User>> getUserSuggestions(String query) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => User.fromJson(json)).where((user) {
        final nameLower = user.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
 * **/

class BeInputAutocompleteController<T>  extends StatelessWidget {
  final TextEditingController controller;
  final SuggestionsCallback<T> suggestionsCallback;
  final ItemBuilder<T> itemBuilder;
  final bool hideOnEmpty;
  final Widget noItemsFoundBuilder;
  final bool validator;
  final void Function(T) onSuggestionSelected;
  final bool hideOnLoading;
  final String hintText;

   BeInputAutocompleteController({
    Key key,
    this.controller,
    @required this.suggestionsCallback,
    @required this.itemBuilder,
    this.hideOnEmpty = false,
    this.noItemsFoundBuilder,
    this.validator=false,
    this.hideOnLoading = false,
    @required this.onSuggestionSelected,
    this.hintText = ''
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TypeAheadFormField<T>(
        hideSuggestionsOnKeyboardHide: false,
        textFieldConfiguration: TextFieldConfiguration(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
          ),
        ),
        suggestionsCallback: suggestionsCallback,
        itemBuilder: itemBuilder,
        hideOnEmpty: hideOnEmpty,
        noItemsFoundBuilder: (context) => noItemsFoundBuilder,
        hideOnLoading: hideOnLoading,
        loadingBuilder: (context) => Container(
          height: 2,
          child:LinearProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
          ),
        ),
        validator: (value){
          if(value.isEmpty && validator){
            return 'Please select a city';
          }
          print('Dado selecionado $value');
        },
        onSuggestionSelected: onSuggestionSelected
      ),
      
    );
  }
}