
import 'package:flutter_login/flutter_login.dart';

LoginMessages _loginMessages = LoginMessages(
    loginButton: 'Ingresar',
    signupButton: 'Registrarse',
    forgotPasswordButton: '¿Olvidaste tu contraseña?',
    usernameHint: 'Usuario',
    passwordHint: 'Contraseña',
    recoverPasswordButton: 'Recuperar',
    recoverPasswordIntro: 'Restablece tu contraseña aqui',
    recoverPasswordDescription: 'Te enviaremos una contraseña nueva a tu cuenta de correo',
    confirmPasswordHint: 'Confirmar contraseña',
    confirmPasswordError: 'Contraseña no coincide',

);

LoginMessages get loginMessages => _loginMessages;