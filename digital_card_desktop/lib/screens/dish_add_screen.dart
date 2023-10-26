import 'package:digital_card_desktop/models/category_model.dart';
import 'package:digital_card_desktop/models/dish_model.dart';
import 'package:digital_card_desktop/screens/dish_screen.dart';
import 'package:digital_card_desktop/services/categories_service.dart';
import 'package:flutter/material.dart';

final categoryService = CategoriesService();

class DishAddPage extends StatefulWidget {
  const DishAddPage({Key? key}) : super(key: key);

  @override
  _DishAddPageState createState() => _DishAddPageState();
}

class _DishAddPageState extends State<DishAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _dishNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityAvailableController = TextEditingController();
  final _priceController = TextEditingController();

  Category? _categorySelected;
  List<Category> _categoriesAcumulates = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTextFormField(
            controller: _dishNameController,
            labelText: 'Nombre del plato',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          _buildTextFormField(
            controller: _descriptionController,
            labelText: 'Descripción (opcional)',
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: _buildTextFormField(
                  controller: _quantityAvailableController,
                  labelText: 'Cantidad',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null) {
                      return 'Por favor ingrese una cantidad válida';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: _buildTextFormField(
                  controller: _priceController,
                  labelText: 'Precio',
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.tryParse(value) == null) {
                      return 'Por favor ingrese un precio válido';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: _buildDropdownButtonFormField(),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: (_categorySelected != null &&
                        !_categoriesAcumulates.contains(_categorySelected!))
                    ? () {
                        setState(() {
                          _categoriesAcumulates.add(_categorySelected!);
                        });
                      }
                    : null,
                child: Text('Agregar Categoría'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Categorías seleccionadas:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            children: _categoriesAcumulates.map((categoria) {
              return Container(
                margin: const EdgeInsets.all(5),
                child: Chip(
                  label: Text(categoria.categoryName),
                  onDeleted: () {
                    setState(() {
                      _categoriesAcumulates.remove(categoria);
                    });
                  },
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String? description;
                  if (_descriptionController.text.trim().isNotEmpty) {
                    description = _descriptionController.text.trim();
                  }

                  Dish dish = Dish(
                      0,
                      _dishNameController.text.trim(),
                      description,
                      double.parse(_priceController.text.trim()),
                      null,
                      null,
                      int.parse(_quantityAvailableController.text.trim()),
                      _categoriesAcumulates, []);

                  dishService.addDish(dish);
                }
              },
              child: Text('Guardar Plato'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildDropdownButtonFormField() {
    return FutureBuilder(
        future: categoryService.getCategories(),
        builder: (context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snap.hasError) {
            return const Center(
                child: Text("No se pudieron cargar las categorias"));
          }
          List<Category> categorias = snap.data;
          return DropdownButtonFormField<String>(
            value: _categorySelected?.categoryName,
            items: categorias.map<DropdownMenuItem<String>>((categoria) {
              return DropdownMenuItem<String>(
                value: categoria.categoryName,
                child: Text(categoria.categoryName),
              );
            }).toList(),
            decoration: const InputDecoration(
              labelText: 'Categoría',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                int indexCategory = categorias
                    .indexWhere((category) => category.categoryName == value);
                Category category = categorias[indexCategory];

                _categorySelected = Category(category.categoryID, value!,
                    category.isActive, category.creationDate);
              });
            },
          );
        });
  }
}
