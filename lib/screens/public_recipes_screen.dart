import 'package:flutter/material.dart';
import '../utils/colors_utils.dart';
import '../utils/utils.dart';
import '../utils/publicLogPopUpEdit.dart';

class PublicRecipesScreen extends StatefulWidget {
  const PublicRecipesScreen({Key? key}) : super(key: key);

  @override
  _PublicRecipesScreenState createState() => _PublicRecipesScreenState();
}
class _PublicRecipesScreenState extends State<PublicRecipesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Public Recipes'),
        backgroundColor: hexStringToColor("EC9D00"),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            showLogoutConfirmationDialog(context);
          },
        ),
      ),
      body: _buildRecipeList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        onPressed: () {
          _showPublicLogPopUpEdit(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRecipeList() {

    List<String> recipes = [
      'Recipe 1',
      'Recipe 2',
      'Recipe 3',
    ];

    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(recipes[index]),
          onTap: () {
            // Recept részleteinek megnyitása
          },
        );
      },
    );
  }

  void _showPublicLogPopUpEdit(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 1.0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: PublicLogPopUpEdit(
              type: MapEntry('New Recipe', Icons.add),
              onSave: (type, description, image) {
                print('New recipe saved: $description');
                return Future.value(true);
              },
            ),
          ),
        );
      },
    );
  }

}
