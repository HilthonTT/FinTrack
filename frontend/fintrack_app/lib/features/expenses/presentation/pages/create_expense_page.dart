import 'package:carousel_slider/carousel_slider.dart';
import 'package:fintrack_app/core/common/utils/toast_helper.dart';
import 'package:fintrack_app/core/common/widgets/loader.dart';
import 'package:fintrack_app/core/common/widgets/primary_button.dart';
import 'package:fintrack_app/core/common/widgets/rounded_dropdown_menu.dart';
import 'package:fintrack_app/core/constants/companies.dart';
import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/expenses/domain/enums/expense_category.dart';
import 'package:fintrack_app/features/expenses/presentation/bloc/expenses_bloc.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/image_button.dart';
import 'package:fintrack_app/core/common/widgets/round_text_field.dart';
import 'package:fintrack_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:fintrack_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

final class CreateExpensePage extends StatefulWidget {
  static MaterialPageRoute<CreateExpensePage> route() => MaterialPageRoute(
        builder: (context) => const CreateExpensePage(),
      );

  const CreateExpensePage({super.key});

  @override
  State<CreateExpensePage> createState() => _CreateExpensePageState();
}

final class _CreateExpensePageState extends State<CreateExpensePage> {
  late FToast fToast;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  Company? _selectedCompany;
  ExpenseCategory? _selectedCategory;

  double _amount = 0.99;

  void submit(String currency) {
    if (_selectedCategory == null || _selectedCompany == null) {
      return;
    }

    if (_formKey.currentState!.validate()) {
      final event = ExpenseCreateExpenseEvent(
        name: _nameController.text.trim(),
        amount: _amount,
        currencyCode: currency,
        category: _selectedCategory!,
        company: _selectedCompany!,
        date: DateTime.now(),
      );

      context.read<ExpensesBloc>().add(event);
    }
  }

  @override
  void initState() {
    super.initState();

    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);

    final event = SettingsGetSettingsEvent();

    context.read<SettingsBloc>().add(event);
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return BlocConsumer<ExpensesBloc, ExpensesState>(
      listener: (context, state) {
        if (state is ExpensesFailure) {
          showToast(fToast, state.error, Icons.error);
        }
      },
      builder: (context, state) {
        if (state is ExpensesLoading) {
          return const Loader();
        }

        return Scaffold(
          backgroundColor: AppPalette.gray,
          body: BlocConsumer<SettingsBloc, SettingsState>(
            listener: (context, state) {
              if (state is SettingsFailure) {
                showToast(fToast, state.error, Icons.error);
              }
            },
            builder: (context, state) {
              if (state is SettingsLoading) {
                return const Loader();
              }

              if (state is SettingsSuccess) {
                final settings = state.settings;

                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: AppPalette.gray70.withValues(alpha: .5),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                          child: SafeArea(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Image.asset(
                                            "assets/images/back.png",
                                            width: 25,
                                            height: 25,
                                            color: AppPalette.gray30,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "New",
                                          style: TextStyle(
                                            color: AppPalette.gray30,
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    "Add new expense",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppPalette.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: media.width,
                                  height: media.height * 0.5,
                                  child: CarouselSlider.builder(
                                    options: CarouselOptions(
                                      autoPlay: false,
                                      aspectRatio: 1,
                                      enlargeCenterPage: true,
                                      enableInfiniteScroll: true,
                                      viewportFraction: 0.65,
                                      enlargeFactor: 0.4,
                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.zoom,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _selectedCompany =
                                              Company.values[index];
                                        });
                                      },
                                    ),
                                    itemCount: companies.length,
                                    itemBuilder:
                                        (context, itemIndex, pageViewIndex) {
                                      final company = companies[itemIndex];

                                      return Container(
                                        margin: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            _buildCompanyIcon(company['icon']),
                                            const SizedBox(height: 25),
                                            Text(
                                              company['name'],
                                              style: TextStyle(
                                                color: AppPalette.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            left: 20,
                            right: 20,
                          ),
                          child: RoundTextField(
                            title: "Name",
                            titleAlign: TextAlign.left,
                            controller: _nameController,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: RoundedDropdownMenu<ExpenseCategory>(
                            selectedValue: _selectedCategory,
                            onChanged: (ExpenseCategory? newCategory) {
                              setState(() {
                                _selectedCategory = newCategory;
                              });
                            },
                            hint: 'Select Expense Category',
                            items: ExpenseCategory.values.toList(),
                            itemToString: (ExpenseCategory category) =>
                                _formatCategoryName(category.name),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 40,
                            horizontal: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ImageButton(
                                image: "assets/images/minus.png",
                                onPressed: () {
                                  setState(() {
                                    _amount -= 0.1;

                                    if (_amount < 0) {
                                      _amount = 0;
                                    }
                                  });
                                },
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Monthly price",
                                    style: TextStyle(
                                        color: AppPalette.gray40,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${settings.currency} ${_amount.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        color: AppPalette.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 1,
                                    color: AppPalette.gray70,
                                  )
                                ],
                              ),
                              ImageButton(
                                image: "assets/images/plus.png",
                                onPressed: () {
                                  setState(() {
                                    _amount += 0.1;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: PrimaryButton(
                            title: "Add expense",
                            onPressed: () => submit(settings.currency),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              }

              return Center(
                child: Text(
                  "Failed to load settings",
                  style: TextStyle(color: AppPalette.white),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCompanyIcon(String? icon) {
    if (icon != null) {
      return Image.asset(
        icon,
        width: 200,
        height: 200,
        fit: BoxFit.fitHeight,
      );
    }

    return Container(
      height: 200,
      width: 200,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppPalette.gray70.withValues(alpha: .5),
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "None",
            style: TextStyle(
              color: AppPalette.gray30,
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCategoryName(String name) {
    // Add spaces between camel case words
    String formattedName = name.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (Match match) => '${match.group(1)} ${match.group(2)}',
    );

    // Capitalize the first letter of the formatted name
    return formattedName[0].toUpperCase() + formattedName.substring(1);
  }
}
