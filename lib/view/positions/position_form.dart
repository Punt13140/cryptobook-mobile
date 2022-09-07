import 'package:cryptobook/blocs/bloc_cryptocurrency.dart';
import 'package:cryptobook/blocs/position/bloc_position_form.dart';
import 'package:cryptobook/model/cryptocurrency/cryptocurrency.dart';
import 'package:cryptobook/model/position/position.dart';
import 'package:cryptobook/utils/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class PositionForm extends StatelessWidget {
  const PositionForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Position'),
      ),
      bottomNavigationBar: const BottomBar(
        position: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<PositionFormBloc>(
          create: (_) => PositionFormBloc(),
          child: const BodyPositionForm(),
        ),
      ),
    );
  }
}

class BodyPositionForm extends StatelessWidget {
  const BodyPositionForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: BlocBuilder<PositionFormBloc, PositionFormBlocState>(
      //buildWhen: (oldState, newState) => oldState.groupedPosStableOpened.isEmpty,
      builder: (_, PositionFormBlocState state) {
        return Column(
          children: [
            const ListTile(
              title: Text('coin'),
/*              subtitle: Visibility(
                visible: state.coin != null,
                child: Text(state.coin!.libelle),
              ),
              leading: Visibility(
                visible: state.coin != null,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    state.coin!.urlImgThumb,
                  ),
                ),
              ),*/
            ),
            FormBuilderDateTimePicker(
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_month),
                hintText: 'dd/mm/yyyy',
                labelText: 'Date',
              ),
              name: 'date',
              inputType: InputType.date,
              format: DateFormat('dd/MM/yyyy'),
              onChanged: (date) {
                if (date != null) {
                  BlocProvider.of<PositionFormBloc>(context).add(
                    OpenedatChangedEvent(date),
                  );
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.tag),
                labelText: 'Nombre',
              ),
              onChanged: (value) {
                if (double.tryParse(value) != null) {
                  BlocProvider.of<PositionFormBloc>(context).add(
                    NbcoinsChangedEvent(double.parse(value)),
                  );
                }
              },
            ),
            TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.attach_money),
                  hintText: 'dd/mm/yyyy',
                  labelText: 'Coût',
                ),
                onChanged: (value) {
                  if (double.tryParse(value) != null) {
                    BlocProvider.of<PositionFormBloc>(context).add(
                      EntrycostChangedEvent(double.parse(value)),
                    );
                  }
                }),
            FormBuilderSwitch(
              name: 'isOpened',
              title: const Text('Position ouverte'),
              onChanged: (value) {
                if (value != null) {
                  BlocProvider.of<PositionFormBloc>(context).add(
                    IsOpenedChangedEvent(value),
                  );
                }
              },
            ),
            FormBuilderSwitch(
              name: 'dca',
              title: const Text('DCA'),
              onChanged: (value) {
                if (value != null) {
                  BlocProvider.of<PositionFormBloc>(context).add(
                    IsDcaChangedEvent(value),
                  );
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              onChanged: (value) {
                BlocProvider.of<PositionFormBloc>(context).add(
                  DescriptionChangedEvent(value),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<PositionFormBloc>(context).add(const SubmitFormEvent());
              },
              child: const Text('Submit'),
            )
          ],
        );
      },
    ));
  }
}

class PositionFormOld extends StatefulWidget {
  const PositionFormOld({Key? key, this.position}) : super(key: key);
  final Position? position;

  @override
  State<PositionFormOld> createState() => _PositionFormState();
}

class _PositionFormState extends State<PositionFormOld> {
  Cryptocurrency? _cryptocurrency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Position'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FormBuilderDateTimePicker(
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_month),
                hintText: 'dd/mm/yyyy',
                labelText: 'Date',
              ),
              name: 'date',
              inputType: InputType.date,
              format: DateFormat('dd/MM/yyyy'),
            ),
            BlocProvider<CryptocurrenciesBloc>(
              create: (_) => CryptocurrenciesBloc(),
              child: BlocBuilder<CryptocurrenciesBloc, CryptocurrenciesBlocState>(
                buildWhen: (oldState, newState) => oldState.cryptocurrencies.isEmpty,
                builder: (_, CryptocurrenciesBlocState state) {
                  if (state.cryptocurrencies.isNotEmpty) {
                    _cryptocurrency ??= state.cryptocurrencies.elementAt(0);
                    return SmartSelect<Cryptocurrency>.single(
                      selectedValue: _cryptocurrency!,
                      title: 'Coin',
                      choiceItems: Cryptocurrency.buildListChoice(state.cryptocurrencies),
                      onChange: (selected) {
                        setState(() => _cryptocurrency);
                      },
                      modalFilter: true,
                      modalFilterAuto: true,
                      tileBuilder: (context, state) => S2Tile(
                        title: const Text('Coin'),
                        value: state.selected.toWidget(),
                        isTwoLine: true,
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            _cryptocurrency!.urlImgThumb,
                          ),
                        ),
                        onTap: state.showModal,
                      ),
                    );
                  }
                  return const CircularProgressIndicator.adaptive();
                },
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.tag),
                labelText: 'Nombre',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.attach_money),
                hintText: 'dd/mm/yyyy',
                labelText: 'Coût',
              ),
            ),
            FormBuilderSwitch(
              name: 'isOpened',
              title: const Text('Position ouverte'),
            ),
            FormBuilderSwitch(
              name: 'dca',
              title: const Text('DCA'),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(
        position: 1,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _cryptocurrency = null;
          });
        },
        tooltip: 'Ajouter une position',
        child: const Icon(Icons.add),
      ),
    );
  }
}
