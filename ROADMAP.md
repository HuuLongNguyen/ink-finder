# 🗺️ InkFinder Roadmap

This roadmap outlines the development phases for **InkFinder**, moving from the current high-fidelity prototype to a production-ready application.

---

## ✅ Phase 0: UI/UX & Architecture (Completed)
- [x] **Theming**: Premium "Mallard Green" dark theme with `FlexColorScheme`.
- [x] **UI Foundation**: Integration of `shadcn_ui` for all core components.
- [x] **Auth UI**: Designed Login (Customer/Studio), Register Studio, and OTP flows.
- [x] **Navigation**: Dynamic tab system based on user roles.
- [x] **Screens**: Implemented Home, Map (Placeholder), Dashboard, and Profile shells.
- [x] **Repo Architecture**: Domain-driven directory structure for features.

---

## 🛠️ Phase 1: Backend & Infrastructure (Current Focus)
- [ ] **Supabase Auth**: Connect frontend forms to real Supabase GoTrue authentication.
    - [ ] Google SSO Integration.
    - [ ] Twilio/Supabase SMS provider for Phone OTP.
- [ ] **Database Schema**: Finalize Postgres schema for `studios`, `artists`, `bookings`, and `user_profiles`.
- [ ] **Cloud Storage**: Implement file uploads for studio licenses and gallery images.
- [ ] **Auth Repository**: Replace `MockAuthRepository` with `SupabaseAuthRepository`.

---

## ✨ Phase 2: Core Feature Implementation
- [ ] **Interactive Maps**:
    - [ ] Integrate Goong Maps (optimized for Vietnam) or Google Maps.
    - [ ] Implement studio "Near Me" discovery and clusters.
- [ ] **Booking System**:
    - [ ] Real-time availability calendar for artists.
    - [ ] Booking request & confirmation workflow.
- [ ] **Search & Discovery**:
    - [ ] Filter by Style DNA (Traditional, Realism, etc.).
    - [ ] Full-text search for studio names and artist specialties.

---

## 💼 Phase 3: Studio Business Tools
- [ ] **Management Dashboard**:
    - [ ] Real-time revenue and booking statistics.
    - [ ] Client management & CRM.
- [ ] **Subscription Logic**:
    - [ ] Implement tiered features for Premium Studios.
    - [ ] Integrate a payment gateway (Stripe or MoMo/VNPay).
- [ ] **QR Ecosystem**:
    - [ ] Generate unique QR codes for studio check-ins.

---

## 🧪 Phase 4: Polish & Stability
- [ ] **Testing**:
    - [ ] Unit tests for business logic and repositories.
    - [ ] Widget tests for core UI components.
- [ ] **Localization**: Complete support for Vietnamese and English.
- [ ] **Performance**: 
    - [ ] Image optimization for tattoo galleries.
    - [ ] Offline caching for map data.

---

## 🚀 Phase 5: Deployment & Scale
- [ ] **Store Preparation**: 
    - [ ] Generate native Splash Screens and Icons.
    - [ ] Configure signing keys for Android (Keystore) and iOS (Provisioning).
- [ ] **CI/CD**: Set up GitHub Actions for automated builds and testing.
- [ ] **Beta Launch**: Internal testing on TestFlight and Google Play Console.

---

*Last Updated: February 2026*
