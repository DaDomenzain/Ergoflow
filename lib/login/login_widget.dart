import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LoginModel>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              focusNode: model.emailAddressFocusNode,
              controller: model.emailAddressTextController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              validator: model.emailAddressValidator,
            ),
            TextFormField(
              focusNode: model.passwordFocusNode,
              controller: model.passwordTextController,
              obscureText: !model.passwordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(model.passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: model.togglePasswordVisibility,
                ),
              ),
              validator: model.passwordValidator,
            ),
            ElevatedButton(
              onPressed: () {
                // Add login logic here
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
