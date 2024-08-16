class MusicsModel {
  final String name;
  final String singer;
  final String path;
  final String image;

  MusicsModel({
    required this.name,
    required this.singer,
    required this.path,
    required this.image,
  });
}

List<MusicsModel> songsList = [
  MusicsModel(
    name: "asmak ah1",
    singer: "Amier1",
    path: "sounds/1.mp3",
    image: "assets/images/amir1.jpg",
  ),
  MusicsModel(
    name: "asmak ah2",
    singer: "Amier2",
    path: "sounds/2.mp3",
    image: "assets/images/amir2.jpg",
  ),
  MusicsModel(
    name: "asmak ah3",
    singer: "Amier1",
    path: "sounds/1.mp3",
    image: "assets/images/amir1.jpg",
  ),
  MusicsModel(
    name: "asmak ah4",
    singer: "Amier2",
    path: "sounds/2.mp3",
    image: "assets/images/amir2.jpg",
  ),
  MusicsModel(
    name: "asmak ah5",
    singer: "Amier1",
    path: "sounds/1.mp3",
    image: "assets/images/amir1.jpg",
  ),
  MusicsModel(
    name: "asmak ah6",
    singer: "Amier2",
    path: "sounds/2.mp3",
    image: "assets/images/amir2.jpg",
  ),
];

String selectedTopic = "";
