class CommentLike {
  int index;
  String emoji;
  int emojiCount;
  double printPosition;

  CommentLike({
    required this.index,
   required this.emoji,
    required this.emojiCount,
    this.printPosition =0,
  });



 // static List<CommentLike> getDefualtObject(){
 //    List<CommentLike> list =[];
 //    list.add(new CommentLike(emoji: "😇", emojiCount: 0));
 //    list.add(new CommentLike(emoji: "❤", emojiCount: 1275));
 //    list.add(new CommentLike(emoji: "😡", emojiCount: 78660));
 //    list.add(new CommentLike(emoji: "😀", emojiCount: 46666));
 //    list.add(new CommentLike(emoji: "😀", emojiCount: 1666));
 //
 //    return list;
 //  }
}
