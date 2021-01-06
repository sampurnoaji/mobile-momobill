import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momobill/core/presentation/util/alert.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_brand.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_type.dart';
import 'package:momobill/features/vehicle/add/presentation/bloc/add_vehicle_bloc.dart';

import '../../../../../injection_container.dart';

class AddVehiclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<AddVehicleBloc>(), child: FormInput());
  }
}

class FormInput extends StatefulWidget {
  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  VehicleType _selectedType;
  VehicleBrand _selectedBrand;
  String _selectedManufacture;
  List _myFriends = ['Yonji', 'Sanji', 'Niji'];
  List<VehicleType> _vehicleTypes = List();
  List<VehicleBrand> _vehicleBrands = List();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddVehicleBloc>(context).add(GetVehicleTypes());
  }

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

            if (state is GetVehicleTypesSuccess) {
              setState(() {
                _vehicleTypes = state.vehicleTypes;
              });
            } else if (state is GetVehicleTypesFailure) {
              errorSnackBar(context, 'Gagal memuat tipe kendaraan');
            } else if (state is GetVehicleBrandsSuccess) {
              setState(() {
                _vehicleBrands = state.vehicleBrands;
              });
            } else if (state is GetVehicleBrandsFailure) {
              errorSnackBar(context, 'Gagal memuat merk kendaraan');
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        hintText: 'Pilih jenis kendaraan',
                        labelText:
                            _selectedType != null ? 'Jenis kendaraan' : null),
                    isExpanded: true,
                    items: _vehicleTypes.map((value) {
                      return DropdownMenuItem(
                          child: value.name != null
                              ? Text(value.name)
                              : Text("null"),
                          value: value);
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value;
                      });
                      bloc.add(GetVehicleBrands());
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        hintText: 'Pilih merk kendaraan',
                        labelText:
                        _selectedBrand != null ? 'Merk kendaraan' : null),
                    isExpanded: true,
                    items: _vehicleBrands.map((value) {
                      return DropdownMenuItem(
                        child: value.name != null
                            ? Text(value.name)
                            : Text("null"),
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
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        hintText: 'Pilih model kendaraan',
                        labelText:
                        _selectedBrand != null ? 'Model kendaraan' : null),
                    isExpanded: true,
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
                            bloc.add(AddVehicle(_selectedType.name,
                                _selectedBrand.name, _selectedManufacture));
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
