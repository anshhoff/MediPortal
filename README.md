# 🏥 MediPortal

*A modern iOS app in SwiftUI for managing doctor records, with a clean architecture and backend integration (SAP OData).*

---

![App Banner](https://img.shields.io/badge/SwiftUI-✔️-orange?style=flat&logo=swift) ![iOS](https://img.shields.io/badge/iOS-14+-lightgrey?logo=apple) ![Backend](https://img.shields.io/badge/SAP%20OData-Enabled-blue)

---

## ✨ Overview

**MediPortal** lets you:
- 📋 List all doctors
- 🔍 View details about each doctor
- 📝 Register new doctors
- 🛠️ Experience modular, scalable SwiftUI architecture

Whether you're building healthcare apps or learning advanced iOS patterns, MediPortal is your starting point!

---

## 🚀 Features

- Beautiful, modular SwiftUI design
- Core + Feature directory architecture
- Type-safe API client for OData backend
- Live app state management
- Resuable styles and theming

---

## 📁 Folder Structure

MediPortal.xcodeproj/ # Project config
MediPortal/
├─ App/ # App entry point & state
│ ├─ AppState.swift
│ └─ MediPortalApp.swift
├─ Assets.xcassets/ # App icons & assets
├─ Core/
│ ├─ Models/ # Data models
│ └─ Networking/ # API client, endpoints
├─ Features/
│ ├─ Dashboard/ # Main dashboard features
│ ├─ DoctorsList/ # List of doctors
│ ├─ DoctorDetail/ # Doctor profile/details
│ └─ Registration/ # Doctor registration
├─ Shared/
│ └─ Styles/ # App theming (AppTheme.swift)
├─ ContentView.swift # Root SwiftUI view
└─ Info.plist # App config

text

---

## 🛠️ Prerequisites

- macOS with [Xcode](https://developer.apple.com/xcode/) (latest recommended)
- An iOS device or Simulator
- SAP OData backend access

---

## 🏁 Getting Started

**1. Clone the repo**
git clone https://github.com/anshhoff/MediPortal.git

text

**2. Open in Xcode**
open MediPortal.xcodeproj

text

**3. (Optional) Configure Backend**
- Edit files in `Core/Networking` for your backend URL/settings.

**4. Build & Run**
- Choose your device or Simulator and hit ⏵

---

## 💡 Usage

- Launch app → Browse Doctors
- Register, edit, or view details for every doctor
- The UI will update in real time with backend changes

---

## 🖌️ Customization

- Change colors and theme in `Shared/Styles/AppTheme.swift`
- Add new features under `Features/`

---

## 🙌 Contributing

Pull requests welcome! For major changes, open an issue first.

---

## 📄 License

[MIT](LICENSE)

---

> Made with ❤️ using SwiftUI

---
