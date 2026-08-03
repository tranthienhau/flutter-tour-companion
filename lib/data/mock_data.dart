import 'package:flutter/material.dart';
import '../models/models.dart';

/// Mock content for the Ashes Tour Australia 2026. In production this comes from
/// the staff web portal / backend; here it is baked in so the app is demoable
/// offline with no backend. Six tour groups exist; three are wired with codes.

const kDelegate = Delegate(
  name: 'Alex Morgan',
  groupLabel: 'Group C',
  tourCode: 'ASH-42K',
  dietary: 'Vegetarian, no nuts',
  emergencyContact: 'Sam Morgan +61 400 112 233',
);

final _groupCActivities4 = <Activity>[
  const Activity(
    id: 'a1',
    time: '8:00 AM',
    title: 'Breakfast at Crown',
    venue: 'Crown Melbourne, Level 1',
    icon: Icons.restaurant_outlined,
    category: 'Meal',
  ),
  const Activity(
    id: 'a2',
    time: '10:00 AM',
    title: 'City walking tour',
    venue: 'Federation Square',
    icon: Icons.directions_walk_outlined,
    category: 'Tour',
  ),
  const Activity(
    id: 'a3',
    time: '1:30 PM',
    title: 'Coach transfer to MCG',
    venue: 'Hotel Lobby',
    icon: Icons.directions_bus_outlined,
    category: 'Transfer',
    meetingPoint: 'Hotel Lobby, coach bay 3',
  ),
  const Activity(
    id: 'a4',
    time: '2:30 PM',
    title: 'Ashes Test - Day 1',
    venue: 'Melbourne Cricket Ground',
    icon: Icons.sports_cricket_outlined,
    category: 'Match',
    heroLabel: 'Ashes Test - Day 1',
    meetingPoint: 'Hotel Lobby, 1:30 PM, coach bay 3',
    section: 'Section M12, Row 8',
    bringList: [
      'Ticket on app',
      'Hat and sunscreen',
      'Light jacket for evening',
      'Refillable water bottle',
    ],
  ),
  const Activity(
    id: 'a5',
    time: '8:00 PM',
    title: 'Group dinner',
    venue: 'Nobu Melbourne',
    icon: Icons.dinner_dining_outlined,
    category: 'Meal',
  ),
];

List<Activity> _simpleDay(String city, String headline, IconData icon) => [
      Activity(
          id: '${city}1',
          time: '8:00 AM',
          title: 'Breakfast',
          venue: 'Hotel restaurant',
          icon: Icons.restaurant_outlined,
          category: 'Meal'),
      Activity(
          id: '${city}2',
          time: '11:00 AM',
          title: headline,
          venue: city,
          icon: icon,
          category: 'Tour'),
      Activity(
          id: '${city}3',
          time: '7:30 PM',
          title: 'Group dinner',
          venue: 'City centre',
          icon: Icons.dinner_dining_outlined,
          category: 'Meal'),
    ];

final _groupCItinerary = <DayPlan>[
  DayPlan(
      dayNumber: 1,
      dateLabel: 'Mon 23 Feb',
      city: 'Melbourne',
      headline: 'Welcome reception',
      hotelName: 'Crown Melbourne',
      status: DayStatus.done,
      activities: _simpleDay('Melbourne', 'Welcome reception', Icons.celebration_outlined)),
  DayPlan(
      dayNumber: 2,
      dateLabel: 'Tue 24 Feb',
      city: 'Melbourne',
      headline: 'Great Ocean Road',
      hotelName: 'Crown Melbourne',
      status: DayStatus.done,
      activities: _simpleDay('Melbourne', 'Great Ocean Road day trip', Icons.landscape_outlined)),
  DayPlan(
      dayNumber: 3,
      dateLabel: 'Wed 25 Feb',
      city: 'Melbourne',
      headline: 'Yarra Valley wines',
      hotelName: 'Crown Melbourne',
      status: DayStatus.done,
      activities: _simpleDay('Yarra Valley', 'Winery tour', Icons.wine_bar_outlined)),
  DayPlan(
      dayNumber: 4,
      dateLabel: 'Thu 26 Feb',
      city: 'Melbourne',
      headline: 'Ashes Test - Day 1',
      hotelName: 'Crown Melbourne',
      status: DayStatus.today,
      activities: _groupCActivities4),
  DayPlan(
      dayNumber: 5,
      dateLabel: 'Fri 27 Feb',
      city: 'Melbourne',
      headline: 'Ashes Test - Day 2',
      hotelName: 'Crown Melbourne',
      status: DayStatus.upcoming,
      activities: _simpleDay('MCG', 'Ashes Test - Day 2', Icons.sports_cricket_outlined)),
  DayPlan(
      dayNumber: 6,
      dateLabel: 'Sat 28 Feb',
      city: 'Sydney',
      headline: 'Flight to Sydney',
      hotelName: 'Sofitel Sydney',
      status: DayStatus.upcoming,
      activities: _simpleDay('Sydney', 'Harbour cruise', Icons.directions_boat_outlined)),
  DayPlan(
      dayNumber: 7,
      dateLabel: 'Sun 1 Mar',
      city: 'Sydney',
      headline: 'Bondi and coastal walk',
      hotelName: 'Sofitel Sydney',
      status: DayStatus.upcoming,
      activities: _simpleDay('Bondi', 'Coastal walk', Icons.surfing_outlined)),
  DayPlan(
      dayNumber: 8,
      dateLabel: 'Mon 2 Mar',
      city: 'Sydney',
      headline: 'Ashes Test - SCG Day 1',
      hotelName: 'Sofitel Sydney',
      status: DayStatus.upcoming,
      activities: _simpleDay('SCG', 'Ashes Test - SCG Day 1', Icons.sports_cricket_outlined)),
];

const _groupCHotels = <Hotel>[
  Hotel(
    name: 'Crown Melbourne',
    city: 'Melbourne',
    checkIn: '23 Feb',
    checkOut: '28 Feb',
    address: '8 Whiteman St, Southbank VIC 3006',
    phone: '+61 3 9292 8888',
  ),
  Hotel(
    name: 'Sofitel Sydney',
    city: 'Sydney',
    checkIn: '28 Feb',
    checkOut: '4 Mar',
    address: '12 Darling Dr, Sydney NSW 2000',
    phone: '+61 2 8388 8888',
  ),
];

const _groupCTransfers = <Transfer>[
  Transfer(time: 'Thu 26 Feb, 1:30 PM', from: 'Crown Lobby (bay 3)', to: 'MCG Gate 3', mode: 'Coach'),
  Transfer(time: 'Sat 28 Feb, 9:00 AM', from: 'Crown Lobby', to: 'Melbourne Airport', mode: 'Coach'),
  Transfer(time: 'Sat 28 Feb, 2:00 PM', from: 'Sydney Airport', to: 'Sofitel Sydney', mode: 'Coach'),
];

const _groupCMeetingPoints = <MeetingPoint>[
  MeetingPoint(label: 'MCG match transfer', location: 'Crown Lobby, coach bay 3', time: 'Thu 26 Feb, 1:30 PM'),
  MeetingPoint(label: 'Airport transfer', location: 'Crown Lobby main entrance', time: 'Sat 28 Feb, 9:00 AM'),
];

final _groupCUpdates = <UpdateItem>[
  UpdateItem(
    id: 'u1',
    title: 'Transfer moved to 2:45 PM',
    body: 'Today\'s coach to the MCG now departs at 2:45 PM from bay 3. Please be in the lobby by 2:35 PM.',
    timeAgo: '25m ago',
    staffName: 'Tour Desk',
    pinned: true,
  ),
  UpdateItem(
    id: 'u2',
    title: 'Dinner dress code: smart casual',
    body: 'Tonight\'s group dinner at Nobu is smart casual. No sportswear please.',
    timeAgo: '2h ago',
    staffName: 'Priya (Host)',
  ),
  UpdateItem(
    id: 'u3',
    title: 'Weather alert - bring a jacket',
    body: 'Evening temperatures at the MCG drop to 14C. Pack a light jacket for the match.',
    timeAgo: '5h ago',
    staffName: 'Tour Desk',
  ),
  UpdateItem(
    id: 'u4',
    title: 'Match tickets now in your app',
    body: 'Your Section M12 tickets are loaded. Show the QR at Gate 3.',
    timeAgo: 'Yesterday',
    staffName: 'Ticketing',
    read: true,
  ),
];

const _groupCMapPoints = <MapPoint>[
  MapPoint(name: 'Crown Melbourne', kind: 'hotel', icon: Icons.hotel_outlined, distance: '0.0 km', eta: 'You are here', position: Offset(0.30, 0.62)),
  MapPoint(name: 'MCG - Gate 3', kind: 'venue', icon: Icons.stadium_outlined, distance: '1.2 km', eta: '6 min walk', position: Offset(0.68, 0.34)),
  MapPoint(name: 'Coach bay 3', kind: 'meeting', icon: Icons.directions_bus_outlined, distance: '0.1 km', eta: '1 min walk', position: Offset(0.40, 0.50)),
  MapPoint(name: 'Nobu Melbourne', kind: 'food', icon: Icons.restaurant_outlined, distance: '0.3 km', eta: '4 min walk', position: Offset(0.55, 0.72)),
];

/// The tour group unlocked by the current tour code.
final kGroupC = TourGroup(
  code: 'ASH-42K',
  groupLabel: 'Group C',
  tourName: 'Ashes Tour - Australia 2026',
  cities: 6,
  days: 12,
  delegates: 24,
  itinerary: _groupCItinerary,
  hotels: _groupCHotels,
  transfers: _groupCTransfers,
  meetingPoints: _groupCMeetingPoints,
);

/// Valid tour codes -> group. Six groups exist on the tour; a few are wired here.
final Map<String, TourGroup> kTourCodes = {
  'ASH-42K': kGroupC,
  'ASH-18B': kGroupC,
  'ASH-77M': kGroupC,
};

/// Live update feed (mutable, per session).
final List<UpdateItem> kUpdates = _groupCUpdates;

const List<MapPoint> kMapPoints = _groupCMapPoints;
