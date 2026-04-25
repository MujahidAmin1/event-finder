# Event Finder

A Flutter app that lets users browse and explore local events fetched from a remote API. Tap any event to view its full details including date, time, location, and description.

---

## Screenshots

> _Add screenshots here_

---

## Features

- Browse a list of events fetched from a live REST API
- Cached network images for smooth, efficient loading
- Event detail screen with date, time, location, and description
- Clean card-based UI with category badges
- Error states and loading indicators

---

## Tech Stack

| Layer | Package |
|---|---|
| HTTP client | [dio](https://pub.dev/packages/dio) |
| Image caching | [cached_network_image](https://pub.dev/packages/cached_network_image) |
| Localization utils | [intl](https://pub.dev/packages/intl) |

---

## Project Structure

```
lib/
├── main.dart               # App entry point
├── models/
│   └── event.dart          # Event data model
├── screens/
│   ├── homescreen.dart     # Event list screen
│   └── detail_screen.dart  # Event detail screen
├── services/
│   └── event_service.dart  # API calls via Dio
└── widgets/
    ├── event_tile.dart     # Event card widget
    └── info_card.dart      # Detail info row widget
```

---

## Getting Started

**Prerequisites:** Flutter SDK `^3.11.4`

```bash
# Install dependencies
flutter pub get

# Run the app
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
