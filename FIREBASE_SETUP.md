# DS Fun Learning — Firebase Setup Guide

## Account: developer.techotd@gmail.com

---

## Step 1: Create Firebase Project

1. Go to https://console.firebase.google.com
2. Sign in as **developer.techotd@gmail.com**
3. Click **"Add project"** → Name it `ds-fun-learning`
4. Disable Google Analytics (optional) → **Create project**

---

## Step 2: Enable Authentication

1. In Firebase console → **Authentication** → **Get started**
2. **Sign-in method** tab → Enable:
   - ✅ **Email/Password**
   - ✅ **Google** (set project support email to developer.techotd@gmail.com)

---

## Step 3: Create Firestore Database

1. **Firestore Database** → **Create database**
2. Choose **"Start in production mode"** → Select region (e.g. `asia-south1` for India)
3. Paste these **Security Rules**:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Users can read/write their own document
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
      // Admin can write all user docs
      allow write: if request.auth != null
        && get(/databases/$(database)/documents/users/$(request.auth.uid)).data.isAdmin == true;
    }

    // Certificates — user can read own, admin can write
    match /certificates/{certId} {
      allow read: if request.auth != null
        && (resource.data.userId == request.auth.uid
            || get(/databases/$(database)/documents/users/$(request.auth.uid)).data.isAdmin == true);
      allow write: if request.auth != null;
    }

    // Leaderboard — anyone logged in can read
    match /leaderboard/{docId} {
      allow read: if request.auth != null;
      allow write: if false; // written by Cloud Functions only
    }

    // Videos — anyone can read, only admin can write
    match /videos/{videoId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null
        && get(/databases/$(database)/documents/users/$(request.auth.uid)).data.isAdmin == true;
    }

    // Announcements — anyone can read, only admin can write
    match /announcements/{docId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null
        && get(/databases/$(database)/documents/users/$(request.auth.uid)).data.isAdmin == true;
    }
  }
}
```

---

## Step 4: Create Storage Bucket

1. **Storage** → **Get started** → Production mode → Select region
2. Paste Storage Rules:

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /profile_photos/{userId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId && request.resource.size < 5 * 1024 * 1024;
    }
  }
}
```

---

## Step 5: Add Apps

### Android
1. **Project settings** → **Add app** → Android
2. Package name: `com.dsfunlearning.app`
3. Download `google-services.json` → place in `android/app/`

### iOS
1. **Add app** → iOS
2. Bundle ID: `com.dsfunlearning.app`
3. Download `GoogleService-Info.plist` → add to `ios/Runner/` via Xcode

---

## Step 6: Run FlutterFire CLI

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure (signs in as developer.techotd@gmail.com)
flutterfire configure --account developer.techotd@gmail.com

# This overwrites lib/firebase_options.dart with real credentials
```

---

## Step 7: Set Admin Account

After first login with developer.techotd@gmail.com, the app auto-sets `isAdmin: true`
because the email matches `AppConstants.adminEmail`.

To manually set any user as admin:
1. Firestore → `users` collection → find the user document
2. Add/edit field: `isAdmin` = `true` (boolean)

---

## Step 8: Android Minimum SDK

In `android/app/build.gradle.kts`, ensure:
```kotlin
minSdk = 23   // required by Firebase Auth
```

---

## Points System Summary

| Action | Points |
|--------|--------|
| Daily login | +5 |
| Complete a topic | +10 |
| Complete a subject | +50 |
| Earn a certificate | +200 |
| Successful referral | +100 |

---

## Features Implemented

- ✅ Firebase Email/Password authentication
- ✅ Google Sign-In
- ✅ Password reset via email
- ✅ User registration with referral code support
- ✅ Firestore user profiles with real-time sync
- ✅ Learning progress tracking (topic/subject completion)
- ✅ YouTube video player per topic
- ✅ Quiz → marks topic complete + awards points
- ✅ PDF certificate generation on subject completion
- ✅ Certificate download & print sharing
- ✅ Global leaderboard with podium (top 3)
- ✅ Referral system with QR code & share link
- ✅ Daily login streak tracking
- ✅ Admin panel (user management, video management, announcements)
- ✅ Profile screen with stats dashboard
- ✅ Bottom navigation (Home, Learning Path, Leaderboard, Profile)
- ✅ Admin FAB button (visible only to isAdmin users)
