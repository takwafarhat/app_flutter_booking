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
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Aquapark',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Beach',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Golf',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Piscine',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Wifi',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Tennis',
      isSelected: true,
    ),
  ];

  static List<PopularFilterListData> hebergemnetList = [
    PopularFilterListData(
      titleTxt: 'tous',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Appartement',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: "Maison d'hôte",
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Hotel',
      isSelected: true,
    ),
  ];
}
