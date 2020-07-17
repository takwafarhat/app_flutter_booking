import 'package:app_flat/pages/Avis/Avis.dart';
import 'package:app_flat/pages/Avis/custom_button.dart';
import 'package:app_flat/pages/Avis/custom_checkbox.dart';
import 'package:app_flat/pages/Avis/product_review.dart';
import 'package:app_flat/pages/Avis/product_review_item.dart';
import 'package:app_flat/pages/Avis/rating_summary.dart';
import 'package:flutter/material.dart';

class ApartmentModelReviewRatingScreen extends StatefulWidget {
  final List<Avis> avisList;

  const ApartmentModelReviewRatingScreen({
    @required this.avisList,
  });

  @override
  State<StatefulWidget> createState() {
    return ApartmentModelReviewRatingScreenState();
  }
}

class ApartmentModelReviewRatingScreenState
    extends State<ApartmentModelReviewRatingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: ApartmentModelReviewWrapper(
                avisList: widget.avisList,
              ),
            ),
            // Container(
            //   alignment: Alignment.bottomCenter,
            //   child: _buildFooter(context),
            // ),
          ],
        ),
      ),
    );
  }

//   Widget _buildFooter(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Positioned(
//           height: 80.0,
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.white,
//                   Colors.white12,
//                 ],
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//               ),
//             ),
//           ),
//         ),
//         Container(
//           alignment: Alignment.bottomRight,
//           child: OpenFlutterButton(
//             title: 'Rédiger un avis',
//             icon: Icons.edit,
//             width: MediaQuery.of(context).size.width * 0.5,
//             onPressed: () => {},
//           ),
//         ),
//       ],
//     );
//   }
}

class ApartmentModelReviewWrapper extends StatefulWidget {
  final List<Avis> avisList;
  final summaryAndFilterIndex = 2;

  const ApartmentModelReviewWrapper({
    this.avisList,
  });

  @override
  State<StatefulWidget> createState() {
    return ApartmentModelReviewWrapperState();
  }
}

class ApartmentModelReviewWrapperState
    extends State<ApartmentModelReviewWrapper> {
  int reviewCount;

  bool withPhotos = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Classement et avis ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                      height: 1.5,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: InkWell(
                    child: Text('Tout voir'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return getReviews(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          _buildRatingSummary(context, widget.avisList.length),

          // Divider(
          //   height: 1,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 10.0, bottom: 15),
          //   child: new Expanded(
          //     child: new Row(
          //       children: <Widget>[
          //         Text(
          //           "Toucher pour noter : \t",
          //           style: TextStyle(fontSize: 15.0),
          //         ),
          //         SmoothStarRating(
          //           size: 30,
          //           color: Colors.amber,
          //           borderColor: Colors.grey,
          //           allowHalfRating: true,
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // new Expanded(
          //   child: new Container(
          //       child: new TextFormField(
          //     maxLines: 5,
          //     decoration: new InputDecoration(
          //       border: OutlineInputBorder(),
          //       filled: false,
          //       contentPadding: new EdgeInsets.only(
          //           left: 10.0, top: 80.0, bottom: 20.0, right: 10.0),
          //       hintText: ' Ajouter votre avis',
          //       hintStyle: new TextStyle(
          //         color: Colors.grey.shade500,
          //         fontSize: 12.0,
          //         fontFamily: 'helvetica_neue_light',
          //       ),
          //     ),
          //   )),
          //   flex: 2,
          // ),
        ],
      ),
    );
  }

  Widget getReviews(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blueGrey[50], Colors.teal[200]])),
        ),
        title: Text(
          "Classement et avis",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              _buildRatingSummary(context, widget.avisList.length),
              //_buildTitleCommentAndFilter(context),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: _getApartmentModelReview()
                    .map((e) => _buildApartmentModelReviewItem(e))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleCommentAndFilter(BuildContext context) {
    if (reviewCount > 0) {
      return Padding(
        padding: const EdgeInsets.only(
          bottom: 8.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '${widget.avisList.length} reviews',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Expanded(
              child: OpenFlutterCheckbox(
                width: MediaQuery.of(context).size.width * 0.5,
                mainAxisAlignment: MainAxisAlignment.end,
                checked: withPhotos,
                title: 'with photos',
                onTap: (value) {},
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox();
  }
}

// Widget _buildItem(BuildContext context, int index) {
//   switch (index) {
//     case 0:
//       return _buildRatingSummary(context);
//     case 1:
//       return _buildTitleCommentAndFilter(context);
//     default:
//       return _buildApartmentModelReviewItem(index);
//   }
// }

Widget _buildRatingSummary(BuildContext context, int listLength) {
  var averageRating = 5.0;

  return Padding(
    padding: const EdgeInsets.only(top: 10.0, bottom: 20),
    child: OpenFlutterRatingSummary(
      barColor: Colors.red[900],
      ratingQuantity: listLength,
      rating: averageRating,
      ratingDetail: [
        StarQuantity(rating: 5, quantity: 2),
        StarQuantity(rating: 4, quantity: 4),
        StarQuantity(rating: 3, quantity: 3),
        StarQuantity(rating: 2, quantity: 1),
        StarQuantity(rating: 1, quantity: 4),
      ],
    ),
  );
}

Widget _buildApartmentModelReviewItem(ApartmentModelReview x) {
  return Padding(
    padding: const EdgeInsets.only(
      bottom: 16.0,
    ),
    child: OpenFlutterProductReviewItem(
      rating: x.rating.roundToDouble(),
      writerName: x.authorName,
      isHelpfulMarked: true,
      comment: x.comment,
      avatarUrl: x.authorPhotoUrl,
      withPhotos: true,
      photos: x.photos,
    ),
  );
}

List<ApartmentModelReview> _getApartmentModelReview() {
  return [
    ApartmentModelReview(
        id: 1,
        productId: 2,
        authorName: 'Jhon Doe',
        authorPhotoUrl:
            'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
        rating: 4,
        comment:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
    ApartmentModelReview(
      id: 2,
      productId: 2,
      authorName: 'Flutter Reviewer',
      authorPhotoUrl:
          'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
      rating: 4,
      comment:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      photos: [
        'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
        'http://personal.psu.edu/xqz5228/jpg.jpg'
      ],
    ),
    ApartmentModelReview(
      id: 3,
      productId: 5,
      authorName: 'Juan Agú',
      authorPhotoUrl: 'http://personal.psu.edu/xqz5228/jpg.jpg',
      rating: 5,
      comment:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      photos: [
        'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
        'http://personal.psu.edu/xqz5228/jpg.jpg',
        'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
        'http://personal.psu.edu/xqz5228/jpg.jpg',
        'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
        'http://personal.psu.edu/xqz5228/jpg.jpg'
      ],
    ),
    ApartmentModelReview(
      id: 4,
      productId: 6,
      authorName: 'Flutter Reviewer',
      authorPhotoUrl:
          'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
      rating: 1,
      comment:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
    ),
    ApartmentModelReview(
      id: 5,
      productId: 7,
      authorName: 'Jhon Doe2',
      authorPhotoUrl:
          'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
      rating: 2,
      comment:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      isHelpful: true,
      photos: ['http://personal.psu.edu/xqz5228/jpg.jpg'],
    ),
    ApartmentModelReview(
      id: 6,
      productId: 8,
      authorName: 'Flutter Reviewer2',
      authorPhotoUrl:
          'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
      rating: 3,
      comment:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      photos: [
        'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
        'http://personal.psu.edu/xqz5228/jpg.jpg',
        'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
        'http://personal.psu.edu/xqz5228/jpg.jpg'
      ],
    ),
    ApartmentModelReview(
      id: 7,
      productId: 8,
      authorName: 'Jhon Doe3',
      authorPhotoUrl:
          'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
      rating: 4,
      comment:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      isHelpful: true,
    ),
    ApartmentModelReview(
      id: 8,
      productId: 9,
      authorName: 'Flutter Reviewer3',
      authorPhotoUrl:
          'https://i.pinimg.com/474x/9e/8e/18/9e8e18212e529bb23bcdeb3515b2276a--minions-movie--minion-movie.jpg',
      rating: 5,
      comment:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      isHelpful: false,
    ),
  ];
}

// Widget _buildEmptyCommentsView() {
//   return Padding(
//     padding: const EdgeInsets.only(top: 16.0),
//     child: Center(
//       child: Text(
//         'Without reviews',
//         style: Theme.of(context).textTheme.body1,
//         textAlign: TextAlign.center,
//       ),
//     ),
//   );
// }
// }
