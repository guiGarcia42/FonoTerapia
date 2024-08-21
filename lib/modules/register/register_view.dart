import 'package:flutter/material.dart';
import 'package:fono_terapia/data/auth_repository.dart';
import 'package:fono_terapia/modules/register/register_viewmodel.dart';
import 'package:fono_terapia/modules/startup/loading_view.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/custom_header.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(authRepository: AuthRepository()),
      child: Scaffold(
        body: Consumer<RegisterViewModel>(
          builder: (context, viewModel, child) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomHeader(text: "Cadastro de usuário"),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: responsiveSize.scaleSize(50),
                      horizontal: responsiveSize.scaleSize(20),
                    ),
                    child: MyText(
                      "Bem vindo ao FonoTerapia, Precisamos confirmar alguns dados:",
                      textAlign: TextAlign.start,
                      style: TextStyles.textField.copyWith(
                        fontSize: responsiveSize.scaleSize(TextStyles.textField.fontSize!),
                        color: AppColors.darkGray,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveSize.scaleSize(40),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              "Como você gostaria de ser chamado?",
                              textAlign: TextAlign.start,
                              style: TextStyles.textField.copyWith(
                                fontSize: responsiveSize.scaleSize(TextStyles.textField.fontSize!),
                                color: AppColors.darkGray,
                              ),
                            ),
                            _buildNameField(viewModel),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.03,
                      top: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedTextButton(
                          widthRatio: MediaQuery.of(context).size.width * 0.25,
                          textStyle: TextStyles.buttonLargeText.copyWith(
                            fontSize: 18,
                          ),
                          text: "Sair",
                          onPressed: () async {
                            await viewModel.signOut();
                            Navigator.pushReplacementNamed(context, '/startup');
                          },
                        ),
                        ElevatedTextButton(
                          widthRatio: MediaQuery.of(context).size.width * 0.30,
                          textStyle: TextStyles.buttonLargeText.copyWith(
                            fontSize: 18,
                          ),
                          text: "Cadastrar",
                          onPressed: () async {
                            if (_formKey.currentState?.validate() == true) {
                              await viewModel.saveUserLocally();
                              await viewModel.registerUserInDatabase();
                              Navigator.pushReplacementNamed(context, '/goPremium');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNameField(RegisterViewModel viewModel) {
    return TextFormField(
      controller: viewModel.nameController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      maxLength: 30,
      style: TextStyles.textField.copyWith(
        fontSize: responsiveSize.scaleSize(TextStyles.textField.fontSize!),
        color: AppColors.darkGray,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkOrange, width: 2.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe seu Nome';
        }
        return null;
      },
    );
  }
}