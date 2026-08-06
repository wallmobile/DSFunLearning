/// Sample YouTube video IDs mapped to subject|topic keys.
/// Admin can override/add via Firestore (AppConstants.videosCollection).
/// Format: key = "SubjectName|TopicName", value = YouTube video ID
class VideoData {
  static const Map<String, String> _defaultVideoIds = {
    // Mathematics
    'Mathematics|Numbers & Counting': 'dQw4w9WgXcQ',
    'Mathematics|Addition & Subtraction': 'dQw4w9WgXcQ',
    'Mathematics|Multiplication & Division': 'dQw4w9WgXcQ',
    'Mathematics|Shapes & Geometry': 'dQw4w9WgXcQ',
    'Mathematics|Fractions & Decimals': 'dQw4w9WgXcQ',
    'Mathematics|Algebra Basics': 'dQw4w9WgXcQ',

    // English
    'English|Alphabet & Phonics': 'dQw4w9WgXcQ',
    'English|Reading': 'dQw4w9WgXcQ',
    'English|Grammar Basics': 'dQw4w9WgXcQ',
    'English|Writing': 'dQw4w9WgXcQ',

    // Science
    'Science|Plants Around Us': 'dQw4w9WgXcQ',
    'Science|Animals & Habitats': 'dQw4w9WgXcQ',
    'Science|Human Body': 'dQw4w9WgXcQ',
    'Science|Force & Motion': 'dQw4w9WgXcQ',
    'Science|Light & Sound': 'dQw4w9WgXcQ',
    'Science|Matter & Materials': 'dQw4w9WgXcQ',

    // Social Studies
    'Social Studies|My Family': 'dQw4w9WgXcQ',
    'Social Studies|My Community': 'dQw4w9WgXcQ',
    'Social Studies|Maps & Directions': 'dQw4w9WgXcQ',

    // Physics
    'Physics|Motion & Laws': 'dQw4w9WgXcQ',
    'Physics|Electricity': 'dQw4w9WgXcQ',
    'Physics|Waves': 'dQw4w9WgXcQ',

    // Chemistry
    'Chemistry|Atoms & Molecules': 'dQw4w9WgXcQ',
    'Chemistry|Chemical Reactions': 'dQw4w9WgXcQ',
    'Chemistry|Acids & Bases': 'dQw4w9WgXcQ',

    // Biology
    'Biology|Cell Biology': 'dQw4w9WgXcQ',
    'Biology|Genetics': 'dQw4w9WgXcQ',
    'Biology|Ecosystem': 'dQw4w9WgXcQ',
  };

  /// Returns a YouTube video ID for the given subject+topic, or null if none.
  static String? getDefaultVideoId(String subject, String topic) {
    return _defaultVideoIds['$subject|$topic'];
  }
}
