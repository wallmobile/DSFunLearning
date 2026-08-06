class VideoModel {
  final String subject;
  final String topic;
  final String youtubeVideoId;
  final String title;
  final String? description;
  final int durationMinutes;

  const VideoModel({
    required this.subject,
    required this.topic,
    required this.youtubeVideoId,
    required this.title,
    this.description,
    this.durationMinutes = 5,
  });

  String get key => '$subject|$topic';
}
