import 'package:flutter/material.dart';

class TelaHome extends StatelessWidget{
  TelaHome({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Seja bem vindo Usuário")),
      body: const Center(
      child: Text("Tela de Home"),
      ),
    );
  }
}