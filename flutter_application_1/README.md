# flutter_application_1

## 🧠 How It Works

The home_page.dart uses a StatefulWidget to manage the counter value.

setState() updates the UI whenever:

- Increment button is pressed
- Decrement button is pressed
- Reset button is pressed 

 
## 👀 Visuals 
UI is rebuilt automatically using Flutter’s reactive architecture.


<video controls src="counter app.mp4" title="Title">Demo</video>


## 🧠 Basic logic example:
int count = 0;

void increment() => setState(() => count++);
void decrement() => setState(() => count--);
void reset()     => setState(() => count = 0);



## 📦 Technologies Used

- Flutter SDK
- Dart
- Material Design widgets