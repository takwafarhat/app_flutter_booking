class PopularFilterListData {
  PopularFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  String titleTxt;
  bool isSelected;

  static List<PopularFilterListData> equipementFList = <PopularFilterListData>[
    PopularFilterListData(
      titleTxt: 'Bar',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Aquapark',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Beach',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Golf',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Piscine',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Wifi',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Tennis',
      isSelected: false,
    ),
  ];

  static List<PopularFilterListData> accomodationList = [
    PopularFilterListData(
      titleTxt: 'tous',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Appartement',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: "Maison d'hôte",
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Hotel',
      isSelected: false,
    ),
  ];
}
