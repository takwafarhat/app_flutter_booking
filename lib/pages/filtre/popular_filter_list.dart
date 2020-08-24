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

  static List<PopularFilterListData> equipementChamberList =
      <PopularFilterListData>[
    PopularFilterListData(
      titleTxt: 'card',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'chaud',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'climatiseur',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'dinner',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'interdit',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'piscine',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'salledebain',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'telephone',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'tv',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'wifi',
      isSelected: true,
    ),
  ];
}
