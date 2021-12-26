class Question {
  final String title;
  final String imagePath;
  final String rightAnswer;
  final List<String> variants;

  static checkValid(Question q) {
    return q.title != '-' &&
        q.imagePath != '-' &&
        q.rightAnswer != '-' &&
        q.variants != [];
  }

  static get emptyQuestion {
    return const Question();
  }

  const Question({
    this.title = '-',
    this.imagePath = '-',
    this.rightAnswer = '-',
    this.variants = const [],
  });
}
