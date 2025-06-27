String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

// Main screen constants
const String appTitle = 'FitLife';
const String homeLabel = "Home";
const String settingsLabel = "Settings";
const String workoutLabel = "Workout";
const String accountLabel = "Account";

// Settings screen constants
const String logoutLabel = "Logout";

// Account screen constants
const String usernameTextEdit = "Username";
const String nameTextEdit = "Name";
const String surnameTextEdit = "Surname";
const String weightTextEdit = "Weight (kg)";
const String heightTextEdit = "Height (cm)";
const String calculateButton = "Calculate BMI";
const String lowWeightCategory = "Low weight";
const String normalWeightCategory = "Normal weight";
const String overweightCategory = "Overweight";
const String obesityCategory = "Obesity";
const String bmiLabel = "BMI: ";
const String invalidValues = "Invalid values";

// Workout screen constants
const String workoutDetailLabel = "Workout Detail";
