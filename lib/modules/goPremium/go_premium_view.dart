import 'package:flutter/material.dart';
import 'package:fono_terapia/app_initializer.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import 'package:provider/provider.dart';
import 'go_premium_viewmodel.dart';

class GoPremiumView extends StatelessWidget {
  const GoPremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    final responsiveSize = AppInitializer.responsiveSize;

    return ChangeNotifierProvider(
      create: (_) => GoPremiumViewModel(
        authRepository: AppInitializer.authRepository, // Use global authRepository
        userDataStorage: AppInitializer.userDataStorage, // Use global userDataStorage
        iap: AppInitializer.inAppPurchase,
      ),
      child: Consumer<GoPremiumViewModel>(
        builder: (context, viewModel, child) {
          // Handle navigation when the user becomes premium
          if (viewModel.isPremium) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/menu');
            });
          }

          return Scaffold(
            backgroundColor: AppColors.background,
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsiveSize.scaleSize(60),
                      vertical: responsiveSize.height * 0.1,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Seja Premium!',
                          style: TextStyles.title.copyWith(
                            color: AppColors.darkGray,
                            fontSize: responsiveSize.scaleSize(
                              TextStyles.title.fontSize!,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: responsiveSize.scaleSize(40)),
                        Text(
                          'Experimente gratuitamente por 15 dias! Após o período de teste, pague apenas R\$19,90 por mês.',
                          style: TextStyles.textRegular.copyWith(
                            color: AppColors.gray,
                            fontSize: responsiveSize.scaleSize(20),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: responsiveSize.scaleSize(40)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: responsiveSize.scaleSize(40)),
                          child: ElevatedButton(
                            onPressed: () {
                              viewModel.startSubscriptionPurchase(); // Trigger the subscription purchase
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.darkOrange,
                              padding: EdgeInsets.symmetric(
                                vertical: responsiveSize.scaleSize(15),
                                horizontal: responsiveSize.scaleSize(40),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(responsiveSize.scaleSize(8)),
                              ),
                            ),
                            child: Text(
                              'Experimente grátis por 15 dias',
                              textAlign: TextAlign.center,
                              style: TextStyles.buttonTextDialog.copyWith(
                                fontSize: responsiveSize.scaleSize(TextStyles.buttonTextDialog.fontSize!),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: responsiveSize.scaleSize(60)),
                        Container(
                          padding: EdgeInsets.all(responsiveSize.scaleSize(20)),
                          decoration: BoxDecoration(
                            color: AppColors.lightOrange,
                            borderRadius: BorderRadius.circular(responsiveSize.scaleSize(12)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Após o período de teste, será cobrado R\$19,90/mês.',
                                style: TextStyles.textRegular.copyWith(
                                  color: AppColors.lightGray,
                                  fontSize: responsiveSize.scaleSize(TextStyles.textRegular.fontSize!),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: responsiveSize.scaleSize(10)),
                              Text(
                                'Cancelamento fácil e simples.',
                                style: TextStyles.textRegular.copyWith(
                                  color: AppColors.lightGray,
                                  fontSize: responsiveSize.scaleSize(14),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: responsiveSize.height * 0.04),
                  child: ElevatedTextButton(
                    widthRatio: MediaQuery.of(context).size.width * 0.5,
                    textStyle: TextStyles.buttonLargeText.copyWith(
                      fontSize: responsiveSize.scaleSize(TextStyles.buttonLargeText.fontSize!),
                    ),
                    text: "Voltar",
                    onPressed: () async {
                      await AppInitializer.logout();
                      Navigator.pushReplacementNamed(context, '/startup');
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}