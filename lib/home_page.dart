import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_connectivity/cubit/internet_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: BlocConsumer<InternetCubit, InternetState>(
        listener: (context, state) {
          if (state is NotConnectedState) {
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(state.message,),backgroundColor: Colors.red,));
          }
        },
        builder: (context, state) {
          if (state is ConnectedState) {
            return _buildTextWidget(state.message);
          } else if (state is NotConnectedState) {
            return _buildTextWidget(state.message);
          }
          return SizedBox();
        },
      ),
      //BlocBuilder<InternetBloc, InternetState>(
      //   builder: (context, state) {
      //     if (state is ConnectedState) {
      //       return _buildTextWidget(state.message);
      //     } else if (state is NotConnectedState) {
      //       return _buildTextWidget(state.message);
      //     }
      //     return SizedBox();
      //   },
      // ),
    );
  }
}

Widget _buildTextWidget(String message) {
  return Center(child: Text(message, style: TextStyle(fontSize: 20)));
}
