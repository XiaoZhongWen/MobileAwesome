import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'recipe.dart';

class RecipeDetail extends StatefulWidget {

  RecipeDetail({Key key, this.recipe}):super(key:key);

  final Recipe recipe;

  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _sliderVal = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.label),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image(image: AssetImage(widget.recipe.imageUrl),),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.recipe.label,
              style: const TextStyle(
                fontSize: 18
              ),
            ),

            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(7.0),
                  itemCount: widget.recipe.ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = widget.recipe.ingredients[index];
                    return Text('${ingredient.quantity * _sliderVal} '
                        '${ingredient.measure} '
                        '${ingredient.name}');
                  }
              ),
            ),

            Slider(
              // 10
              min: 1,
              max: 10,
              divisions: 10,
              // 11
              label: '${_sliderVal * widget.recipe.servings} servings',
              // 12
              value: _sliderVal.toDouble(),
              // 13
              onChanged: (newValue) {
                setState(() {
                  _sliderVal = newValue.round();
                });
              },
              // 14
              activeColor: Colors.green,
              inactiveColor: Colors.black,
            ),

          ],
        ),
      ),
    );
  }
}