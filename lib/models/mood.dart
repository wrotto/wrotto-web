enum Mood { crying, sad, neutral, happy, grin }

Mood fromEmoji(String emoji) {
  print(emoji);
  switch (emoji) {
    case '😢':
      return Mood.crying;
    case '🙁':
      return Mood.sad;
    case '😐':
      return Mood.neutral;
    case '🙂':
      return Mood.happy;
    case '😁':
      return Mood.grin;
    default:
      return null;
  }
}

fromEmojiInt(int emoji) {
  switch (emoji) {
    case 0:
      return Mood.crying;
    case 1:
      return Mood.sad;
    case 2:
      return Mood.neutral;
    case 3:
      return Mood.happy;
    case 4:
      return Mood.grin;
      
  }
}

extension MoodExtensions on Mood {
  String toEmoji() {
    switch (this) {
      case Mood.crying:
        return '😢';
      case Mood.sad:
        return '🙁';
      case Mood.neutral:
        return '😐';
      case Mood.happy:
        return '🙂';
      case Mood.grin:
        return '😁';
      default:
        return null;
    }
  }

  String toShortString() {
    return this.toString().substring(this.toString().indexOf('.') + 1);
  }
}
