import 'package:audio/src/app/widgets/play_button.dart';
import 'package:audio/src/app/widgets/waveform_item.dart';
import 'package:audio/src/services/audio_player_service.dart';
import 'package:audio/src/app/bloc/bloc.dart';
import 'package:audio/src/services/models/models.dart';
import 'package:audio/src/services/utils/free_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerItem extends StatelessWidget {
  final Tune tune;
  final PlayerBloc _playerBloc;

  PlayerItem({
    @required this.tune,
    Key key,
  })  : _playerBloc =
            PlayerBloc(audioPlayerService: AudioPlayerService(tune: tune)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final rowHeight = 40.0;
    return BlocBuilder<PlayerBloc, PlayerState>(
      bloc: _playerBloc,
      builder: (context, state) {
        final _screenWidth = screenWidth(context);
        return Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          height: _screenWidth,
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.grey[200],
                child: Image.network(
                  tune.artwork,
                  fit: BoxFit.cover,
                  height: _screenWidth,
                  width: double.infinity,
                  color: Colors.black38,
                  colorBlendMode: BlendMode.hardLight,
                ),
              ),
              Positioned(
                top: 0,
                child: SizedBox(
                  width: _screenWidth,
                  child: Row(
                    children: <Widget>[
                      PlayButton(
                        stream: _playerBloc,
                        playerState: state,
                        onPressed: () => _playerBloc.toggle(tune),
                      ),
                      SizedBox(
                        width: _screenWidth - 135,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: rowHeight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      tune.artist,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    iconSize: 30,
                                    color: Colors.orange,
                                    icon: const Icon(Icons.cloud_download),
                                    onPressed: () {
                                      print('IconButton Pressed');
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: rowHeight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      tune.title,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    iconSize: 30,
                                    color: Colors.orange,
                                    icon: const Icon(Icons.share),
                                    onPressed: () {
                                      print('IconButton Pressed');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                left: 8,
                right: 8,
                child: Container(
                  child: WaveFormItem(
                    waveform: Waveform(tune.audioFile.waveformResponse),
                    bloc: _playerBloc,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
