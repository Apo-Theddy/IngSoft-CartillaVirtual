import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_card_desktop/components/categories_component.dart';
import 'package:digital_card_desktop/constants/contants_vars.dart';
import 'package:digital_card_desktop/models/category_model.dart';
import 'package:digital_card_desktop/models/dish_model.dart';
import 'package:digital_card_desktop/screens/dish_add_screen.dart';
import 'package:digital_card_desktop/screens/dish_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:pretty_animated_buttons/pretty_animated_buttons.dart";

class DishContentComponent extends StatefulWidget {
  const DishContentComponent(
      {Key? key,
      required this.dish,
      required this.closeDishInformation,
      required this.removeDishOfList,
      required this.updateListDish})
      : super(key: key);

  final Dish dish;
  final VoidCallback closeDishInformation;
  final Function(int dishID) removeDishOfList;
  final Function(int dishID, Dish? newDish) updateListDish;

  @override
  _DishContentComponentState createState() => _DishContentComponentState();
}

class _DishContentComponentState extends State<DishContentComponent> {
  bool _isEditingText = false;
  late String _dishName, _description, _unitPrice, _quantityAvailable;
  late TextEditingController _dishNameController,
      _descriptionController,
      _unitPriceController,
      _quantityAvailableController;
  Category? _categorySelected;
  List<Category> _categoriesAcumulates = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final dish = widget.dish;
    _dishNameController = TextEditingController(text: dish.dishName);
    _descriptionController = TextEditingController(
        text: dish.description != null ? dish.description!.trim() : "");
    _unitPriceController = TextEditingController(text: "${dish.unitPrice}");
    _quantityAvailableController =
        TextEditingController(text: "${dish.quantityAvailable}");
  }

  @override
  void dispose() {
    _dishNameController.dispose();
    _descriptionController.dispose();
    _unitPriceController.dispose();
    _quantityAvailableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              spreadRadius: 1,
            )
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: widget.closeDishInformation,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 40),
                      ),
                    ),
                  ],
                ),
                verifyImage(size),
                CategoriesComponent(
                  categories: widget.dish.categories ?? [],
                  dishID: widget.dish.dishID,
                ),
                _buildTextOrTextField(
                  _dishNameController,
                  30,
                  widget.dish.dishName,
                  "Nombre del platillo",
                ),
                _buildTextOrTextField(
                  _descriptionController,
                  20,
                  widget.dish.description ?? "",
                  "Descripcion del platillo",
                ),
                const SizedBox(height: 20),
                if (_isEditingText)
                  _buildTextOrTextField(
                    _unitPriceController,
                    20,
                    "${widget.dish.unitPrice}",
                    "Precio del platillo",
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Cantidades disponibles: ",
                          style: TextStyle(fontSize: 20)),
                      _buildTextOrTextField(
                          _unitPriceController,
                          20,
                          "${widget.dish.quantityAvailable}",
                          "Precio del platillo"),
                    ],
                  ),
                const SizedBox(height: 10),
                if (_isEditingText)
                  Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownButtonFormField(),
                        ),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: (_categorySelected != null &&
                                  !_categoriesAcumulates
                                      .contains(_categorySelected!))
                              ? () {
                                  setState(() {
                                    _categoriesAcumulates
                                        .add(_categorySelected!);
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
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
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
                    )
                  ]),
                if (_isEditingText)
                  _buildTextOrTextField(
                      _quantityAvailableController,
                      20,
                      "${widget.dish.quantityAvailable}",
                      "Platillos Disponibles")
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Precio: ", style: TextStyle(fontSize: 20)),
                      Flexible(
                        child: _buildTextOrTextField(
                            _quantityAvailableController,
                            20,
                            "${widget.dish.quantityAvailable}",
                            "Platillos Disponibles"),
                      ),
                    ],
                  ),
                const SizedBox(height: 10),
                if (_isEditingText) _buildSaveButton(),
              ]),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDeleteButton(),
                  _buildEditButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showMessageAlert(String property) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Verifique el campo $property"),
      ),
    );
  }

  Widget _buildTextOrTextField(
    TextEditingController controller,
    double fontSize,
    String value,
    String hintText,
  ) {
    if (_isEditingText) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 2),
              )
            ],
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          child: TextField(
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            onSubmitted: (newValue) {
              setState(() {
                value = newValue;
              });
            },
            autofocus: true,
            controller: controller,
            style: GoogleFonts.roboto(
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    }
    return Text(
      value,
      style: GoogleFonts.roboto(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
      ),
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

  Widget _buildSaveButton() {
    return PrettyShadowButton(
      onPressed: () {
        Future.delayed(Duration(milliseconds: 200)).then((_) {
          _saveChanges();
        });
      },
      label: "Guardar",
      icon: Icons.save,
      bgColor: Colors.greenAccent,
    );
  }

  void _saveChanges() {
    if (_dishNameController.text.trim().isEmpty) {
      showMessageAlert("Nombre del platillo");
      return;
    } else if (_quantityAvailableController.text.trim().isEmpty) {
      showMessageAlert("Cantidades Disponibles");
      return;
    } else if (_unitPriceController.text.trim().isEmpty) {
      showMessageAlert("Precio del platillo");
      return;
    } else {
      setState(() {
        _isEditingText = false;
        widget.dish.dishName = _dishNameController.text;
        widget.dish.description = _descriptionController.text;
        widget.dish.unitPrice = double.parse(_unitPriceController.text);
        widget.dish.categories = _categoriesAcumulates.isNotEmpty
            ? _categoriesAcumulates
            : widget.dish.categories;
        widget.dish.quantityAvailable =
            int.parse(_quantityAvailableController.text);
        dishService.updateDish(widget.dish).then((newDish) {
          widget.updateListDish(widget.dish.dishID, newDish);
        });
      });
    }
  }

  Widget _buildDeleteButton() {
    return PrettyShadowButton(
      onPressed: () {
        Future.delayed(const Duration(milliseconds: 200)).then((_) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Eliminar"),
                content:
                    Text("¿Estás seguro de que deseas eliminar este platillo?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar",
                        style: TextStyle(color: Colors.redAccent)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.removeDishOfList(widget.dish.dishID);
                      dishService.removeDish(widget.dish.dishID).then((_) {
                        widget.closeDishInformation();
                      });
                    },
                    child: const Text("Continuar"),
                  ),
                ],
              );
            },
          );
        });
      },
      label: "Eliminar",
      icon: Icons.delete,
      shadowColor: Colors.redAccent,
    );
  }

  Widget _buildEditButton() {
    return PrettyShadowButton(
      label: "Editar",
      onPressed: () {
        setState(() {
          _isEditingText = true;
        });
      },
      icon: Icons.edit,
      shadowColor: Colors.blueAccent,
    );
  }

  Widget verifyImage(Size size) {
    Widget wig = Image.asset(
      "assets/default-image.png",
      height: size.height * 0.3,
    );
    if (widget.dish.images!.isNotEmpty) {
      wig = CarouselSlider(
        options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 0.9,
            initialPage: 0,
            enlargeCenterPage: true,
            enlargeFactor: 1,
            height: 400,
            aspectRatio: 16 / 9),
        items: widget.dish.images!
            .map((image) => Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/background-dish.jpg"))),
                      child: Stack(
                        children: [
                          Row(children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white24),
                              child: InkWell(
                                onTap: () {
                                  print(image.imageID);
                                },
                                child: const Icon(Icons.delete,
                                    color: Colors.redAccent, size: 40),
                              ),
                            )
                          ]),
                          Center(
                            child: Image.network("$url/${image.path}",
                                width: size.width * 0.35),
                          ),
                        ],
                      )),
                ))
            .toList(),
      );
    }
    return wig;
  }
}
