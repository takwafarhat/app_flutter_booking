import 'package:app_flat/pages/Avis/Avis.dart';
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

  // Widget _buildFooter(BuildContext context) {
  //   return Stack(
  //     children: <Widget>[
  //       Positioned(
  //         height: 100.0,
  //         bottom: 0,
  //         left: 0,
  //         right: 0,
  //         child: Container(
  //           decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //               colors: [
  //                 Colors.white,
  //                 Colors.white12,
  //               ],
  //               begin: Alignment.bottomCenter,
  //               end: Alignment.topCenter,
  //             ),
  //           ),
  //         ),
  //       ),
  //       Container(
  //         alignment: Alignment.bottomRight,
  //         child: OpenFlutterButton(
  //           title: 'Write a review',
  //           icon: Icons.edit,
  //           width: MediaQuery.of(context).size.width * 0.5,
  //           onPressed: () => {},
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

class ApartmentModelReviewWrapper extends StatefulWidget {
  final List<Avis> avisList;
  final summaryAndFilterIndex = 2;

  const ApartmentModelReviewWrapper({
    Key key,
    this.avisList,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ApartmentModelReviewWrapperState();
  }
}

class ApartmentModelReviewWrapperState
    extends State<ApartmentModelReviewWrapper> {
  List<ApartmentModelReview> comments = [];
  int reviewCount = 5;
  bool withPhotos = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildRatingSummary(context),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: _getApartmentModelReview()
                .map((e) => _buildApartmentModelReviewItem(e))
                .toList(),
          ),
        ],
      ),
    );
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

Widget _buildRatingSummary(BuildContext context) {
  var ratingCount = 5;
  var averageRating = 3.0;
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 8.0,
    ),
    child: OpenFlutterRatingSummary(
      barColor: Theme.of(context).accentColor,
      ratingQuantity: ratingCount,
      rating: averageRating,
      ratingDetail: [
        StarQuantity(quantity: 2, rating: 5),
        StarQuantity(rating: 4, quantity: 1),
        StarQuantity(quantity: 3, rating: 3),
        StarQuantity(rating: 0, quantity: 1),
      ],
    ),
  );
}

// Widget _buildTitleCommentAndFilter(BuildContext context) {
//   if (reviewCount > 0) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         bottom: 8.0,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             '$reviewCount reviews',
//             style: Theme.of(context).textTheme.subtitle,
//           ),
//           Expanded(
//             child: OpenFlutterCheckbox(
//               width: MediaQuery.of(context).size.width * 0.5,
//               mainAxisAlignment: MainAxisAlignment.end,
//               checked: withPhotos,
//               title: 'with photos',
//               onTap: (value) {},
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   return SizedBox();
// }

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

Padding _buildIndicator() {
  return Padding(
    padding: const EdgeInsets.only(
      top: 8.0,
    ),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
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
