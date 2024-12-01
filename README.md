# ShelterApp

A mobile application designed for the Lee County Humane Society to streamline donations, sponsorships, volunteer sign-ups, and supply contributions. 
The app provides users with a way to sponsor animals, donate supplies via Amazon, sign up to volunteer, and log in to view their personal sponsorships.

---

## Features

### User Authentication
- Users can log in and sign up to access the app using Firebase Authentication.

### Main Screen
- Displays the shelter's name, location, mission statement, and description.
- Links for:
  - **Sign Up to Volunteer**
  - **Donate Supplies via Amazon**
  - **Sponsor an Animal**
  - **Log Out**

### Animal Sponsorship
- Allows users to sponsor animals.
- Displays the animal's details (name, breed, age, and description).
- Accepts donation details including amount and payment information.
- Sends sponsorship data to the Firestore database (`donations` collection).

### Volunteer Sign-Up
- Users can sign up to volunteer at the shelter.
- Accepts user details (name, email, phone number, availability).
- Saves volunteer information to the Firestore database (`volunteers` collection).

### Firestore Integration
- **`donations` collection**:
  - `animalName`: Name of the sponsored animal.
  - `donationAmount`: Amount donated by the user.
  - `creditCardNumber`: User's credit card number (for demonstration only).
  - `expirationDate`: Expiration date of the credit card.
  - `cvv`: Security code of the credit card (for demonstration only).
  - `timestamp`: Date and time of the donation.
- **`volunteers` collection**:
  - `name`: Volunteer’s name.
  - `email`: Volunteer’s email address.
  - `phone`: Volunteer’s phone number.
  - `availability`: Volunteer’s available days or times.
  - `timestamp`: Date and time of the sign-up.

---

## Technologies Used

- **SwiftUI**: For building user interfaces.
- **Firebase**: For authentication and Firestore database.
- **PetFinder API**: For fetching animal data dynamically.
- **NavigationView & NavigationLink**: For navigation within the app.
- **Swift**: Language used for app development.
  
