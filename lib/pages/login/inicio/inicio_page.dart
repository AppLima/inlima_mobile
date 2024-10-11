import 'package:flutter/material.dart';
import 'package:inlima_mobile/components/customtextfield.dart';
import 'package:inlima_mobile/components/large_button.dart';
import 'package:inlima_mobile/components/tab.dart';
import 'package:inlima_mobile/configs/colors.dart';
import 'inicio_controller.dart';

class InicioPage extends StatelessWidget {
  final InicioController control = InicioController();
  final bool isRegister;

  InicioPage({super.key, required this.isRegister}) {
    control.isLogin.value = !isRegister;
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      top: false,
      child: Stack(
        children: [
          Container(
            color: AppColors.primaryColorInlima,
          ),
          Opacity(
            opacity: 0.4,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/login/fondo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/login/inlima_icon.png',
                      height: 80,
                    ),
                    const SizedBox(height: 10),
                    Image.asset(
                      'assets/login/inlima.png',
                      height: 40,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ValueListenableBuilder<bool>(
                        valueListenable: control.isLogin,
                        builder: (context, isLogin, child) {
                          return isLogin
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  child:
                                      _buildLoginContent(constraints, context),
                                )
                              : SingleChildScrollView(
                                  padding: EdgeInsets.only(
                                    left: 30,
                                    top: 20,
                                    bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom +
                                        20,
                                    right: 30,
                                  ),
                                  child: _buildRegisterContent(
                                      constraints, context),
                                );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginContent(BoxConstraints constraints, BuildContext context) {
    return Column(
      children: [
        Tabs(
          isLogin: true,
          onLoginTap: () {},
          onRegisterTap: () {
            control.isLogin.value = false;
          },
        ),
        const SizedBox(height: 20),
        Text(
          control.getWelcomeText(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        CustomTextField(labelText: 'Correo',inputType: TextInputType.emailAddress,controller: control.emailController,),
        CustomTextField(labelText: 'Contraseña',inputType: TextInputType.text,controller: control.passwordController,obscureText: true,),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: LargeButton(
            title: control.getButtonText(),
            onPressed: () {
              FocusScope.of(context).unfocus();
              control.handleAction(context);
            },
            backgroundColor: AppColors.primaryColorInlima,
            borderRadius: BorderRadius.circular(30),
            textColor: Colors.white,
            height: 50.0,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterContent(
      BoxConstraints constraints, BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          Tabs(
            isLogin: false,
            onLoginTap: () {
              control.isLogin.value = true;
            },
            onRegisterTap: () {},
          ),
          const SizedBox(height: 20),
          Text(
            control.getWelcomeText(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(labelText: 'Correo',inputType: TextInputType.emailAddress,controller: control.emailController,),
          CustomTextField(labelText: 'Contraseña',inputType: TextInputType.text,controller: control.passwordController,obscureText: true,),
          CustomTextField(labelText: 'DNI',inputType: TextInputType.number,controller: control.dniController,),
          CustomTextField(labelText: 'Nombres',inputType: TextInputType.text,controller: control.nombresController,),
          CustomTextField(labelText: 'Apellido Paterno',inputType: TextInputType.text,controller: control.apellidoPaternoController,),
          CustomTextField(labelText: 'Apellido Materno',inputType: TextInputType.text,controller: control.apellidoMaternoController,),
          CustomTextField(labelText: 'Teléfono',inputType: TextInputType.phone,controller: control.telefonoController,),
          CustomTextField(labelText: 'Distrito Actual',inputType: TextInputType.text,controller: control.distritoController,),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: LargeButton(
              title: control.getButtonText(),
              onPressed: () {
                FocusScope.of(context).unfocus();
                control.handleAction(context);
              },
              backgroundColor: AppColors.primaryColorInlima,
              borderRadius: BorderRadius.circular(30),
              textColor: Colors.white,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
    );
  }
}
