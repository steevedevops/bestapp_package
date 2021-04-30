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
 * **/

class BeInputAutocompleteController<T>  extends StatelessWidget {
  final TextEditingController controller;
  final SuggestionsCallback<T> suggestionsCallback;
  final ItemBuilder<T> itemBuilder;
  final bool showNoitemsFoundBuilder;
  final Widget noItemsFoundBuilder;
  final bool validator;
  final void Function(T) onSuggestionSelected;

   BeInputAutocompleteController({
    Key key,
    this.controller,
    @required this.suggestionsCallback,
    @required this.itemBuilder,
    this.showNoitemsFoundBuilder = false,
    this.noItemsFoundBuilder,
    this.validator=false,
    @required this.onSuggestionSelected
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
            hintText: 'Search Username',
          ),
        ),
        suggestionsCallback: suggestionsCallback,
        itemBuilder: itemBuilder,
        noItemsFoundBuilder: showNoitemsFoundBuilder ? 
        (context) => noItemsFoundBuilder :
        (context) => Container(
          height: 0,
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