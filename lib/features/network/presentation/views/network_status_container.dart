import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/network/presentation/bloc/network_bloc.dart';
import 'package:habit_quest/features/network/presentation/bloc/network_state.dart';
import 'package:habit_quest/shared/widgets/network_card.dart';

class NetworkStatusContainer extends StatefulWidget {
  const NetworkStatusContainer({super.key});

  @override
  State<NetworkStatusContainer> createState() => _NetworkStatusContainerState();
}

class _NetworkStatusContainerState extends State<NetworkStatusContainer> {
  bool _isContainerVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkBloc, NetworkState>(
      listener: (context, state) {
        if (state is NetworkDisconnected && !_isContainerVisible) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              setState(() {
                _isContainerVisible = true;
              });
            }
          });
        }
        if (state is NetworkConnected && _isContainerVisible) {
          setState(() {
            _isContainerVisible = false;
          });
        }
      },
      child: AnimatedSwitcher(
        duration: _isContainerVisible
            ? const Duration(milliseconds: 500)
            : const Duration(milliseconds: 300),
        child: _isContainerVisible
            ? const NetworkCard(key: ValueKey('networkCard'))
            : const SizedBox.shrink(key: ValueKey('empty')),
      ),
    );
  }
}
