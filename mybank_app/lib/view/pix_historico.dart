import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/pix_historico_page/pix_historico_bloc.dart';

import '../bloc/pix_historico_page/pix_historico_event.dart';
import '../bloc/pix_historico_page/pix_historico_state.dart';

class PixHistoricoPage extends StatefulWidget {
  const PixHistoricoPage({super.key});

  @override
  State<PixHistoricoPage> createState() => _PixHistoricoPageState();
}

class _PixHistoricoPageState extends State<PixHistoricoPage> {
  late PixHistoricoBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = PixHistoricoBloc();
    bloc.add(InitPageEvent(context: context));
  }

  SingleChildScrollView _body() {
    return SingleChildScrollView(
      child: BlocBuilder<PixHistoricoBloc, PixHistoricoState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is PixHistoricoSuccessState) {
            var teste = state.pixHistorico;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: teste.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("De: ${teste[index].nomePagante}"),
                      Text("Para: ${teste[index].nomeRecebinte}"),
                      Text("Valor: ${teste[index].valor}"),
                      const SizedBox(height: 10),
                    ],
                  );
                });
          }
          if (state is PixHistoricoInitialState) {
            return Text("Initial state");
          }

          return Container();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: 150,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: const Text("Pix page"),
      ),
      body: _body(),
    );
  }
}
