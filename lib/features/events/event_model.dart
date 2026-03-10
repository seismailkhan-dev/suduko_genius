// lib/features/events/event_model.dart

class Event {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String trophyImageUrl;
  final List<EventMilestone> milestones;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.trophyImageUrl,
    required this.milestones,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      trophyImageUrl: json['trophyImageUrl'] as String,
      milestones: (json['milestones'] as List<dynamic>)
          .map((e) => EventMilestone.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class EventMilestone {
  final int trophiesRequired;
  final String rewardName;
  final String rewardIcon;

  EventMilestone({
    required this.trophiesRequired,
    required this.rewardName,
    required this.rewardIcon,
  });

  factory EventMilestone.fromJson(Map<String, dynamic> json) {
    return EventMilestone(
      trophiesRequired: json['trophiesRequired'] as int,
      rewardName: json['rewardName'] as String,
      rewardIcon: json['rewardIcon'] as String,
    );
  }
}
