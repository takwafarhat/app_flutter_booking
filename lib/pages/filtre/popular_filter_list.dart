class PopularFilterListData {
  PopularFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
    this.photo = "",
  });

  String titleTxt;
  bool isSelected;
  String photo;

  static List<PopularFilterListData> equipementFList = <PopularFilterListData>[
    PopularFilterListData(
      titleTxt: 'Bar',
      isSelected: true,
      photo:
          'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2Fbar.JPG?alt=media&token=ad1a7208-f29f-47f0-9d40-748b8bf07dc1',
    ),
    PopularFilterListData(
      titleTxt: 'Aquapark',
      isSelected: true,
      photo:
          'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2Faquapark.JPG?alt=media&token=9bd39e4d-acd6-46e0-9b58-22595b93c8c4',
    ),
    PopularFilterListData(
      titleTxt: 'Beach',
      isSelected: true,
      photo:
          'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2Fbeach.JPG?alt=media&token=72cca22b-3f85-47f3-bcb3-40d95b16e1ab',
    ),
    PopularFilterListData(
        titleTxt: 'Golf',
        isSelected: true,
        photo:
            'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2Fgolf.JPG?alt=media&token=f3de2c03-45d3-4fcd-8b3d-1483861c5243'),
    PopularFilterListData(
        titleTxt: 'Piscine',
        isSelected: true,
        photo:
            'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2Fswimmingpool.JPG?alt=media&token=b1a13cc9-569a-43ad-b68a-e56dd96192d9'),
    PopularFilterListData(
        titleTxt: 'Wifi',
        isSelected: true,
        photo:
            'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2Fwifi.JPG?alt=media&token=b615e12e-d08c-404d-ab45-c26f833ffb34'),
    PopularFilterListData(
        titleTxt: 'Tennis',
        isSelected: true,
        photo:
            'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2Fswimmingpool.JPG?alt=media&token=b1a13cc9-569a-43ad-b68a-e56dd96192d9'),
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
        photo:
            'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2FChambre%2Fcard.PNG?alt=media&token=614ca5ef-7cc6-4564-94ad-5c35d8f3e022'),
    PopularFilterListData(
        titleTxt: 'chaud',
        isSelected: true,
        photo:
            'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2FChambre%2Fchaud.PNG?alt=media&token=d613bd9f-90e7-4762-a807-0f48e1de78de'),
    PopularFilterListData(
        titleTxt: 'climatiseur',
        isSelected: true,
        photo:
            'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2FChambre%2Fclimatiseur.PNG?alt=media&token=7b6f383f-e166-4bb1-aca3-3d06fa641975'),
    PopularFilterListData(
        titleTxt: 'interdit',
        isSelected: true,
        photo:
            'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2FChambre%2Finterdit.PNG?alt=media&token=c07ba4fe-e5dd-4e76-bc96-4dc79504c7b9'),
    PopularFilterListData(
        titleTxt: 'piscine',
        isSelected: true,
        photo:
            'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2FChambre%2Fpiscine.PNG?alt=media&token=9673dd78-5402-4199-be46-ef3a46dd7ed4'),
    PopularFilterListData(
        titleTxt: 'salledebain',
        isSelected: true,
        photo:
            'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2FChambre%2Fsalledebain.PNG?alt=media&token=8bbf4267-7323-4fe5-8282-546d37dbcc61'),
    PopularFilterListData(
        titleTxt: 'telephone',
        isSelected: true,
        photo:
            'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2FChambre%2Ftelephone.PNG?alt=media&token=3c74072e-93c6-49d5-bcce-d11ee726bf23'),
    PopularFilterListData(
        titleTxt: 'tv',
        isSelected: true,
        photo:
            'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2FChambre%2Ftv.PNG?alt=media&token=d1dd1a14-d7f7-431c-8dc0-7e11685204bf'),
    PopularFilterListData(
        titleTxt: 'wifi',
        isSelected: true,
        photo:
            'https://firebasestorage.googleapis.com/v0/b/map-projet-222ea.appspot.com/o/equipement%2FChambre%2Fwifi.PNG?alt=media&token=080f7986-e2ac-4418-b6ff-eea1b40ef412'),
  ];
}
