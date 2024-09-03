import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stubudget/screens/settings/blocs/bloc/create_expense_bloc.dart';
import 'package:stubudget/screens/settings/blocs/create_categorybloc/create_category_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:stubudget/screens/settings/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:uuid/uuid.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController amountController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isLoading = false;
  //DateTime selectDate = DateTime.now();
  late Expense expense;

  @override
  void initState() {
    dateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    expense = Expense.empty;
    expense.expenseId = Uuid().v1();
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          Navigator.pop(context, expense);
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.teal[100],
        appBar: AppBar(
          title: const Text(
            "StuBudget",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.teal[200],
          actions: [
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Category Settings",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          "Expense Category Form",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.teal[50],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          labelText: "Amount"),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: categoryController,
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: true,
                      onTap: () {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: expense.category == Category.empty
                            ? Colors.white
                            : Color(expense.category.color),
                        prefixIcon: Icon(Icons.list),
                        suffixIcon: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    Color categoryColor = Colors.teal;
                                    TextEditingController
                                        categoryNameController =
                                        TextEditingController();
                                    TextEditingController
                                        categoryColorController =
                                        TextEditingController();
                                    bool isLoading = false;

                                    return BlocProvider.value(
                                      value: context.read<CreateCategoryBloc>(),
                                      child: BlocListener<CreateCategoryBloc,
                                          CreateCategoryState>(
                                        listener: (context, state) {
                                          if (state is CreateCategorySuccess) {
                                            Navigator.pop(ctx);
                                          } else if (state
                                              is CreateCategoryLoading) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                          }
                                          // TODO: implement listener
                                        },
                                        child: StatefulBuilder(
                                            builder: (ctx, setState) {
                                          return AlertDialog(
                                            title: Text("New Expense"),
                                            backgroundColor: Colors.teal[600],
                                            content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextField(
                                                    controller:
                                                        categoryNameController,
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor:
                                                            Colors.teal[50],
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        labelText:
                                                            "Category Name"),
                                                  ),
                                                  SizedBox(height: 16),
                                                  TextField(
                                                    controller:
                                                        categoryColorController,
                                                    readOnly: true,
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (ctx2) {
                                                            return AlertDialog(
                                                                content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                ColorPicker(
                                                                    pickerColor:
                                                                        Colors
                                                                            .blue,
                                                                    onColorChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        categoryColor =
                                                                            value;
                                                                      });
                                                                    }),
                                                                SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 40,
                                                                  child: TextButton(
                                                                      onPressed: () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      style: ButtonStyle(
                                                                        backgroundColor:
                                                                            WidgetStatePropertyAll(Colors.black),
                                                                      ),
                                                                      child: Text(
                                                                        "Save C",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.white),
                                                                      )),
                                                                ),
                                                              ],
                                                            ));
                                                          });
                                                    },
                                                    decoration: InputDecoration(
                                                        suffixIcon: Icon(Icons
                                                            .arrow_drop_down),
                                                        filled: true,
                                                        fillColor:
                                                            categoryColor,
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        labelText:
                                                            "Category Color"),
                                                  ),
                                                  SizedBox(height: 10),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: isLoading == true
                                                        ? Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          )
                                                        : TextButton(
                                                            onPressed: () {
                                                              // create category object and pop

                                                              Category
                                                                  category =
                                                                  Category
                                                                      .empty;
                                                              category.categoryId =
                                                                  Uuid().v1();
                                                              category.name =
                                                                  categoryNameController
                                                                      .text;
                                                              category.color =
                                                                  categoryColor
                                                                      .value;
                                                              context
                                                                  .read<
                                                                      CreateCategoryBloc>()
                                                                  .add(CreateCategory(
                                                                      category));
                                                            },
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  WidgetStatePropertyAll(
                                                                      Colors
                                                                          .grey),
                                                            ),
                                                            child: Text(
                                                              "Save",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                  )
                                                ]),
                                          );
                                        }),
                                      ),
                                    );
                                  });
                            },
                            child: Text(
                              "Add",
                              style: TextStyle(
                                color: Colors.cyan[700],
                              ),
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: "Category",
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                          builder: (context, state) {
                            if (state is GetCategoriesSuccess) {
                              return ListView.builder(
                                  itemCount: state.categories.length,
                                  itemBuilder: (context, int i) {
                                    return Card(
                                      child: ListTile(
                                        onTap: () {
                                          setState(() {
                                            expense.category =
                                                state.categories[i];
                                            categoryController.text =
                                                expense.category.name;
                                          });
                                        },
                                        title: Text(state.categories[i].name),
                                        tileColor:
                                            Color(state.categories[i].color),
                                      ),
                                    );
                                  });
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: expense.date,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)));
                        if (newDate != null) {
                          setState(() {
                            dateController.text =
                                DateFormat('dd/MM/yy').format(newDate);
                            //selectDate = newDate;
                            expense.date = newDate;
                          });
                        }
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.teal[50],
                          prefixIcon: Icon(Icons.punch_clock),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          labelText: "Date"),
                    ),
                    SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: isLoading
                          ? Center(child: CircularProgressIndicator())
                          : TextButton(
                              onPressed: () {
                                setState(() {
                                  expense.amount =
                                      int.parse(amountController.text);
                                });
                                context
                                    .read<CreateExpenseBloc>()
                                    .add(CreateExpense(expense));
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.teal[300]),
                              ),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )
                              ),
                    )
                
                  ],
                ),
              
          )
         
            
              ),
               
        
        ),
      ),
    );
  }
}
