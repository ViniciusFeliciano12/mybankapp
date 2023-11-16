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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 15.0),
                  child: Text("Transações feitas",
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 1,
                  color: Colors.teal,
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: teste.length,
                    itemBuilder: (context, index) {
                      return teste[index].pagante
                          ? Column(
                              children: [
                                Container(
                                  height: 1,
                                  color: Colors.teal,
                                ),
                                ListTile(
                                  tileColor:
                                      const Color.fromARGB(255, 240, 239, 239),
                                  title:
                                      Text("De: ${teste[index].nomePagante}"),
                                  subtitle: Text(
                                      "Para: ${teste[index].nomeRecebinte}"),
                                  trailing:
                                      Text("Valor: ${teste[index].valor}"),
                                ),
                              ],
                            )
                          : Container();
                    }),
                Container(
                  height: 2,
                  color: Colors.teal,
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text("Transações recebidas",
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 1,
                  color: Colors.teal,
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: teste.length,
                    itemBuilder: (context, index) {
                      return teste[index].pagante
                          ? Container()
                          : Column(
                              children: [
                                Container(
                                  height: 1,
                                  color: Colors.teal,
                                ),
                                ListTile(
                                  tileColor:
                                      const Color.fromARGB(255, 240, 239, 239),
                                  title:
                                      Text("De: ${teste[index].nomePagante}"),
                                  subtitle: Text(
                                      "Para: ${teste[index].nomeRecebinte}"),
                                  trailing:
                                      Text("Valor: ${teste[index].valor}"),
                                ),
                              ],
                            );
                    }),
              ],
            );
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
