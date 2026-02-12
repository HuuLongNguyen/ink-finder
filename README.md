# 🖋️ InkFinder

### *The Premium Tattoo Discovery & Management Ecosystem for Vietnam*

![InkFinder Hero](inkfinder_readme_hero_1770909997665.png)

**InkFinder** is a high-fidelity mobile application designed to bridge the gap between tattoo enthusiasts and professional studios in Vietnam. Built with a focus on "Pro Max" aesthetics, it provides a seamless, edgy, and state-of-the-art experience for both customers and studio owners.

---

## ✨ Design Philosophy & Aesthetics

InkFinder isn't just an app; it's a visual statement. We utilize the latest design trends to create a premium atmosphere:
- **Glassmorphism**: Subtle semi-transparent elements and layered blurs for a modern, airy feel.
- **Deep Dark Mode**: A curated brand palette using **Mallard Green** and rich Zink tones, optimized for OLED screens.
- **Micro-animations**: Smooth transitions and interactive elements powered by `animate_do`.
- **Modern Iconography**: Unified visual language using **Lucide Icons**.
- **High-Fidelity Typography**: Premium font pairings from **Google Fonts** (Inter/Geist).

---

## 🚀 Key Features

### 👤 For Customers (Ink Enthusiasts)
- **Discover**: Browse curated studios and artists with high-quality visual galleries.
- **Interactive Maps**: Locate top-rated studios nearby using our custom map integration.
- **Social SSO & OTP**: Frictionless login via Google SSO or Phone Number with OTP verification.
- **Style DNA**: Personalize your feed by following specific tattoo styles (Traditional, Realism, Blackwork, etc.).
- **Booking History**: Keep track of your past and upcoming ink sessions in one place.

### 🏢 For Studio Owners
- **Dual Mode**: Seamlessly switch between being a user and managing your business.
- **Studio Dashboard**: Real-time analytics on profile views, engagement, and revenue.
- **Promotion System**: Flash sales and premium featured slots to boost visibility.
- **Premium Subscription**: Tiered access to advanced business tools and high-priority placement.
- **Verified Status**: Streamlined registration with document upload for business verification.

---

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) (Cross-platform excellence)
- **UI Components**: [Shadcn UI for Flutter](https://shadcnui-flutter.com/) (State-of-the-art components)
- **Theming**: [FlexColorScheme](https://pub.dev/packages/flex_color_scheme) (Sophisticated color systems)
- **Backend**: [Supabase](https://supabase.com/) (Scalable Auth, Database, and Storage)
- **Maps**: custom `flutter_map` integration.
- **Icons**: [Lucide Icons](https://lucide.dev/)

---

## 📦 Project Structure

```bash
lib/
├── core/
│   ├── theme/          # Custom FlexColorScheme & Shadcn configurations
│   └── utils/          # Global constants and helpers
├── features/
│   ├── auth/           # Domain-driven Authentication module
│   │   ├── domain/     # Repositories & Entities
│   │   └── presentation/# Pages (Login, OTP, Register)
├── screens/            # Main feature screens (Home, Map, Dashboard)
└── main.dart           # App entry & Routing
```

---

## 🏁 Getting Started

1. **Clone the repo**:
   ```bash
   git clone https://github.com/yourusername/ink-finder.git
   ```
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the app**:
   ```bash
   flutter run
   ```

---

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.

---

<p align="center">
  <i>Developed with ❤️ for the Vietnam Tattoo Community.</i>
</p>
