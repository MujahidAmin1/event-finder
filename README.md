# Event Finder

A Flutter app that lets users browse, search, and explore local events fetched from a remote API.

---

## Screenshots

> _Add screenshots here_

---

## Features

- Splash/onboarding screen with auto-navigation after 2.5 seconds
- Browse a list of events fetched from a live REST API
- Dedicated search screen — search by event title on submit
- Event detail screen with date, time, location, and description
- Add event form with title, category dropdown, date & time picker, and location
- Flushbar feedback on ticket booking and event creation
- Cached network images for smooth, efficient loading
- Dark and Light theme implemented

---

## Tech Stack

| Layer | Package |
|---|---|
| HTTP client | [dio](https://pub.dev/packages/dio) |
| Image caching | [cached_network_image](https://pub.dev/packages/cached_network_image) |
| In-app notifications | [another_flushbar](https://pub.dev/packages/another_flushbar) |
| Localization utils | [intl](https://pub.dev/packages/intl) |

---

## Project Structure

```
lib/
├── main.dart                  # App entry point
├── models/
│   └── event.dart             # Event data model
├── screens/
│   ├── onboarding_screen.dart # Splash screen
│   ├── homescreen.dart        # Event list with pull-to-refresh
│   ├── search_screen.dart     # Dedicated search screen
│   ├── detail_screen.dart     # Event detail screen
│   └── add_event_screen.dart  # Add event form
├── services/
│   └── event_service.dart     # API calls via Dio
└── widgets/
    ├── event_tile.dart        # Event card widget
    └── info_card.dart         # Detail info row widget
```

---

## Getting Started

**Prerequisites:** Flutter SDK `^3.11.4`

```bash
flutter pub get
flutter run
```

---

## API

Events are fetched from:

```
GET https://events-finder.free.beeceptor.com/events
```

Expected response — array of event objects:

```json
[
  {
    "id": 1,
    "title": "Flutter Conference 2025",
    "category": "Tech",
    "date": "May 10, 2025",
    "time": "10:00 AM",
    "location": "San Francisco, CA",
    "imageUrl": "https://...",
    "distance": "2.4 km",
    "description": "..."
  }
]
```
