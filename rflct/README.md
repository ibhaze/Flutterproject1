# REFLECT — Audio Journaling App

## Overview
**REFLECT** is a Flutter-based mobile app designed for **audio journaling and reflection**.  
The app guides users into a calm, reflective experience with a simple and minimal UI.

Currently, the app includes:

- **Loading/Intro Animation**: A 2-second fade + scale animation on the "RFLCT" logo with a soft purple background.
- **Smooth Transition**: After 3–4 seconds, the app transitions to the Home Page using a **slide-up + fade animation**.
- **Home Page Placeholder**: Basic Home Page ready for adding audio journaling features.

---

## Project Structure
rflct/
├── lib/
│ ├── main.dart # Entry point of the app
│ └── pages/
│ ├── loading_page.dart # Animated intro / splash page
│ └── home_page.dart # Placeholder Home Page


---

## Screens & Flow

1. **Loading Page**
   - Purple background (`#CABDE6`)  
   - "RFLCT" logo appears with a **fade + scale animation**  
   - Duration: 2 seconds animation + 3-second wait  
   - Automatically transitions to Home Page
   ![alt text](image.png)

2. **Home Page**
   - Simple welcome message  
   - Scaffold ready for app content  
   - Target page after the intro animation  

 



---

## Key Features Implemented

- **TweenAnimationBuilder**: For logo fade + scale effect
- **Timer**: Controls the 3–4 second wait before transitioning
- **PageRouteBuilder**: Custom slide-up + fade transition
- **Google Fonts**: Nunito font used throughout
- **Hex Color Theme**: Background set to `#CABDE6`

---

## How to Run

1. Clone the repo:
```bash
git clone <repo-url>

cd rflct

flutter pub get

flutter run




