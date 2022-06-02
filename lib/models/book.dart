



class Book{

  final String imageUrl;
  final String title;
  final String summary;
  final String ratingStar;
  final String genre;


  Book({
    required this.imageUrl,
    required this.title,
    required this.genre,
    required this.ratingStar,
    required this.summary
});



}

List<Book>  books = [

  Book(
      imageUrl: 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcR4BwYfcsXoaALzCCvGYu9vAH35ni549OMEHUOIFO8BSUsRomdy',
      title: 'To Kill a Mockingbird',
      genre: ' Legal Story',
      ratingStar: '⭐⭐⭐⭐',
      summary: 'To Kill a Mockingbird is a novel by the American author Harper Lee. It was published in 1960 and was instantly successful. In the United States, it is widely read in high schools and middle schools. To Kill a Mockingbird has become a classic of modern American literature, winning the Pulitzer Prize.'),
  Book(
      imageUrl: 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRba9A6pjrNcGkN_qBIa19R3SIzBp0Rs1wra54eXAWPWiN7h7V3',
      title: 'The Great Gatsby',
      genre: 'Tragedy',
      ratingStar: '⭐⭐⭐⭐⭐',
      summary: 'The Great Gatsby is a 1925 novel by American writer F. Scott Fitzgerald. Set in the Jazz Age on Long Island, near New York City, the novel depicts first-person narrator Nick Carraway\'s interactions with mysterious millionaire Jay Gatsby and Gatsby\'s obsession to reunite with his former lover'
  ),
  Book(
      imageUrl: 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRMMFpXlQU4lFejF0H2Fsxx3RvbXP_bt4JsErFVft_jD8d3ECDe',
      title: 'The Lovely Bones',
      genre: 'Novel',
      ratingStar: '⭐⭐⭐⭐',
      summary: 'The Lovely Bones is a 2002 novel by American writer Alice Sebold. It is the story of a teenage girl who, after being raped and murdered, watches from her personal Heaven as her family and friends struggle to move on with their lives while she comes to terms with her own death'
  ),
];
