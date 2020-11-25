import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momobill/core/presentation/util/alert.dart';
import 'package:momobill/features/vehicle/add/presentation/bloc/add_vehicle_bloc.dart';

import '../../../../../injection_container.dart';

class AddVehiclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<AddVehicleBloc>(),
        child: FormInput());
  }
}

class FormInput extends StatefulWidget {
  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  String _selectedType, _selectedBrand, _selectedManufacture;
  List _myFriends = ['Yonji', 'Sanji', 'Niji'];

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<AddVehicleBloc>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Tambah Kendaraan')),
        body: BlocListener<AddVehicleBloc, AddVehicleState>(
          listener: (context, state) {
            if (state is AddVehicleSuccess) {
              successSnackBar(context, 'sukses');
            } else if (state is AddVehicleFailure) {
              errorSnackBar(context, state.message);
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  DropdownButton(
                    isExpanded: true,
                    hint: Text("Pilih Tipe"),
                    value: _selectedType,
                    items: _myFriends.map((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButton(
                    isExpanded: true,
                    hint: Text("Pilih Brand"),
                    value: _selectedBrand,
                    items: _myFriends.map((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedBrand = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButton(
                    isExpanded: true,
                    hint: Text("Pilih Manufaktur"),
                    value: _selectedManufacture,
                    items: _myFriends.map((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedManufacture = value;
                      });
                    },
                  ),
                  SizedBox(height: 32),
                  BlocBuilder<AddVehicleBloc, AddVehicleState>(
                      builder: (context, state) {
                    if (state is AddVehicleLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          padding: EdgeInsets.all(16),
                          child: Text('Simpan'),
                          color: Theme.of(context).accentColor,
                          textTheme: ButtonTextTheme.primary,
                          onPressed: () {
                            bloc.add(AddVehicle(_selectedType, _selectedBrand,
                                _selectedManufacture));
                          },
                        ),
                      );
                    }
                  })
                ],
              ),
            ),
          ),
        ));
  }
}
