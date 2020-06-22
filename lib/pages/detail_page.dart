import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';

import '../core/const.dart';
import '../models/apartment_model.dart';

class DetailPage extends StatefulWidget {
  final ApartmentModel data;
  DetailPage(this.data);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var _pageController = PageController();
  var _currentIndex = 0;
  var _maxLines = 3;
  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page.round();
      });
    });
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildWidgetButtonClose(context),
          _buildWidgetPrice(),
          _buildImageSlider(context),
          _buildWidgetIndicator(context),
          _buildWidgetScroll()
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * .15,
          right: MediaQuery.of(context).size.width * .15,
          bottom: 12,
        ),
        //child: CustomSliderWidget(),
      ),
    );
  }

  Widget _buildWidgetScroll() {
    return DraggableScrollableSheet(
        initialChildSize: .5,
        builder: (context, controller) {
          return SingleChildScrollView(
            controller: controller,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 25),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Icon(Icons.drag_handle, color: Colors.black38),
                      ),
                      Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          widget.data.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _buildWidgetSize(
                              "Living Room",
                              widget.data.sizeLivingRoom,
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.black38,
                            ),
                            _buildWidgetSize(
                              "BedRoom",
                              widget.data.sizeBedRoom,
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.black38,
                            ),
                            _buildWidgetSize(
                              "BathRoom",
                              widget.data.sizeBathRoom,
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.black38,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          widget.data.desc,
                          maxLines: _maxLines,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            height: 1.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_maxLines == 3) {
                                _maxLines = 10;
                              } else {
                                _maxLines = 3;
                              }
                            });
                          },
                          child:
                              Text(_maxLines == 3 ? "Read more" : "Read less",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.stylecolor,
                                    height: 1.5,
                                  )),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {},
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Row _buildWidgetSize(String name, int size) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text("${widget.data.sizeLivingRoom} sqft",
                style: TextStyle(
                  color: Colors.black38,
                  height: 1.5,
                  fontSize: 16,
                ))
          ],
        )
      ],
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .6,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.data.images.length,
        itemBuilder: (context, index) {
          return Image.asset(
            "assets/${widget.data.images[index]}.jpg",
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Widget _buildWidgetIndicator(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .45),
        child: SliderIndicator(
          length: widget.data.images.length,
          activeIndex: _currentIndex,
          indicator: Icon(
            Icons.radio_button_unchecked,
            color: Colors.white,
            size: 10,
          ),
          activeIndicator: Icon(
            Icons.fiber_manual_record,
            color: Colors.white,
            size: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetButtonClose(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(right: 24, top: 45),
        child: IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
    );
  }

  Container _buildWidgetPrice() {
    return Container(
      margin: EdgeInsets.only(left: 24, top: 50),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.euro_symbol,
              size: 16,
              color: Colors.white,
            ),
            Text(
              "${widget.data.price.toInt()}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "months",
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ]),
    );
  }
}
