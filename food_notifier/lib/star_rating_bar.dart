import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class StarRatingBar extends StatefulWidget {
  final int _starCount;
  final double _spacing;
  final double _size;
  final Color _color;
  final void Function(double) _onRatingChanged;

  StarRatingBar({
    int starCount,
    double spacing,
    double size,
    Color color,
    void Function(double) onRatingChanged
  })
  : this._starCount = starCount ?? 5,
    this._spacing = spacing ?? 0.1,
    this._size = size ?? 40.0,
    this._color = color ?? Colors.orange[300],
    this._onRatingChanged = onRatingChanged ?? ((v) {});

  @override
  _StarRatingBarState createState() => _StarRatingBarState();
}

class _StarRatingBarState extends State<StarRatingBar> {
  double _rating = 0.0;

  Widget buildStar(int index) {
    int curStarCnt = _rating.floor();
    double remain = _rating - curStarCnt;

    if(index < curStarCnt) return Icon(Icons.star, color: widget._color, size: widget._size);
    if(index == curStarCnt && remain >= 0.5) return Icon(Icons.star_half, color: widget._color, size: widget._size);
    return Icon(Icons.star_border, color: widget._color, size: widget._size);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: widget._size,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            widget._starCount, buildStar
          )
        )
      ),
      onHorizontalDragUpdate: (details) {
        Offset rawPosition = details.localPosition;

        double screenWidth = MediaQuery.of(context).size.width;
        double contentSize = widget._size * widget._starCount;
        double padding = (screenWidth - contentSize) / 2;

        double localX = rawPosition.dx - padding;

        if(localX > contentSize) localX = contentSize;
        if(localX < 0) localX = 0;

        double rawRating = localX / widget._size;

        Decimal rawResult;
        double minDelta = widget._spacing + 1;
        for(int i=0; widget._spacing * i <= widget._starCount; i++) {
          double delta = rawRating - widget._spacing * i;
          if(delta < 0) delta = -delta;

          if(delta < minDelta) {
            minDelta = delta;
            rawResult = Decimal.parse(widget._spacing.toString()) * Decimal.fromInt(i);
          }
        }

        double result = rawResult.toDouble();

        setState(() => _rating = result);
        widget._onRatingChanged(result);
      },
    );
  }
}
