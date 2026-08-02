import 'package:flutter/material.dart';

/// Domain models for the multi-tour event app. Each tour group has its own
/// itinerary keyed by a unique tour code.

enum DayStatus { done, today, upcoming }

class Activity {
  final String id;
  final String time; // "2:30 PM"
  final String title;
  final String venue;
  final IconData icon;
  final String? meetingPoint; // "Hotel Lobby, coach bay 3"
  final String? category; // "Match", "Meal", "Transfer", "Tour"
  final String? heroLabel; // optional hero label for detail
  final List<String> bringList;
  final String? section; // seat/section info

  const Activity({
    required this.id,
    required this.time,
    required this.title,
    required this.venue,
    required this.icon,
    this.meetingPoint,
    this.category,
    this.heroLabel,
    this.bringList = const [],
    this.section,
  });
}

class DayPlan {
  final int dayNumber;
  final String dateLabel; // "Thu 26 Feb"
  final String city;
  final String headline; // headline activity
  final String hotelName;
  final DayStatus status;
  final List<Activity> activities;

  const DayPlan({
    required this.dayNumber,
    required this.dateLabel,
    required this.city,
    required this.headline,
    required this.hotelName,
    required this.status,
    required this.activities,
  });
}

class Hotel {
  final String name;
  final String city;
  final String checkIn;
  final String checkOut;
  final String address;
  final String phone;

  const Hotel({
    required this.name,
    required this.city,
    required this.checkIn,
    required this.checkOut,
    required this.address,
    required this.phone,
  });
}

class Transfer {
  final String time;
  final String from;
  final String to;
  final String mode; // "Coach", "Ferry"

  const Transfer({
    required this.time,
    required this.from,
    required this.to,
    required this.mode,
  });
}

class MeetingPoint {
  final String label;
  final String location;
  final String time;

  const MeetingPoint(
      {required this.label, required this.location, required this.time});
}

class UpdateItem {
  final String id;
  final String title;
  final String body;
  final String timeAgo;
  final String staffName;
  final bool pinned;
  bool read;

  UpdateItem({
    required this.id,
    required this.title,
    required this.body,
    required this.timeAgo,
    required this.staffName,
    this.pinned = false,
    this.read = false,
  });
}

class MapPoint {
  final String name;
  final String kind; // "hotel", "venue", "meeting", "food"
  final IconData icon;
  final String distance;
  final String eta;
  final Offset position; // relative 0..1 position on the mock map

  const MapPoint({
    required this.name,
    required this.kind,
    required this.icon,
    required this.distance,
    required this.eta,
    required this.position,
  });
}

class Delegate {
  final String name;
  final String groupLabel; // "Group C"
  final String tourCode; // "ASH-42K"
  final String dietary;
  final String emergencyContact;

  const Delegate({
    required this.name,
    required this.groupLabel,
    required this.tourCode,
    required this.dietary,
    required this.emergencyContact,
  });
}

class TourGroup {
  final String code;
  final String groupLabel; // "Group C"
  final String tourName; // "Ashes Tour - Australia 2026"
  final int cities;
  final int days;
  final int delegates;
  final List<DayPlan> itinerary;
  final List<Hotel> hotels;
  final List<Transfer> transfers;
  final List<MeetingPoint> meetingPoints;

  const TourGroup({
    required this.code,
    required this.groupLabel,
    required this.tourName,
    required this.cities,
    required this.days,
    required this.delegates,
    required this.itinerary,
    required this.hotels,
    required this.transfers,
    required this.meetingPoints,
  });
}
