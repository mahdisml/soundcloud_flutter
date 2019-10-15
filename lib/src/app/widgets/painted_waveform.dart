import 'package:audio/src/services/models/waveform.dart';
import 'package:audio/src/services/models/waveform_painter.dart';
import 'package:flutter/material.dart';

class PaintedWaveform extends StatefulWidget {
  final Waveform sampleData;

  PaintedWaveform({
    Key key,
    @required this.sampleData,
  }) : super(key: key);

  @override
  _PaintedWaveformState createState() => _PaintedWaveformState();
}

class _PaintedWaveformState extends State<PaintedWaveform> {
  var _startPosition = 1.0;
  var _zoomLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 4,
            child: LayoutBuilder(
              builder: (context, BoxConstraints constraints) {
                // adjust the shape based on parent's orientation/shape
                // the waveform should always be wider than taller
                double height;
                if (constraints.maxWidth < constraints.maxHeight) {
                  height = constraints.maxWidth;
                } else {
                  height = constraints.maxHeight;
                }

                return Container(
                  child: Row(
                    children: [
                      CustomPaint(
                        size: Size(
                          constraints.maxWidth,
                          height,
                        ),
                        foregroundPainter: WaveformPainter(
                          color: Color(
                            0xff3994DB,
                          ),
                          zoomLevel: _zoomLevel,
                          startingFrame: widget.sampleData
                              .frameIdxFromPercent(_startPosition),
                          data: widget.sampleData,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Flexible(
            child: Slider(
              activeColor: Colors.indigoAccent,
              min: 1.0,
              max: 95.0,
              divisions: 42,
              onChanged: (newzoomLevel) {
                setState(() => _zoomLevel = newzoomLevel);
              },
              value: _zoomLevel,
            ),
          ),
          Flexible(
            child: Slider(
              activeColor: Colors.indigoAccent,
              min: 1.0,
              max: 95.0,
              divisions: 42,
              onChanged: (newstartPosition) {
                setState(() => _startPosition = newstartPosition);
              },
              value: _startPosition,
            ),
          )
        ],
      ),
    );
  }
}