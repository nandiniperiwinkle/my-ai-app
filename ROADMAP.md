# Maternal Wellness Platform — Build Roadmap

*Prepared as a technical co-founder's plan for a non-technical founder. This document translates the Product Requirements & Architecture doc into an actionable, phased build plan, with tech choices weighted toward low-code/managed services so you can drive most of the build yourself, with Claude Code handling the custom logic.*

---

## 0. How to use this document

- You don't need to write code. Your job is to **make product decisions, test each milestone, and approve moving to the next phase**.
- Claude Code (me) will scaffold, wire up, and maintain the custom pieces (Cloud Functions, admin logic, integrations, CI/CD).
- Everywhere a no-code/low-code tool can replace hand-written code without hurting scalability, this plan uses it — so you can configure screens, forms, and workflows yourself in a visual builder, and only ask for engineering help on the harder 20%.
- Each phase ends with a **demoable milestone** you can click through before we move on.

---

## 1. Tech Stack Recommendations

The original architecture (Flutter + Firebase + Next.js + n8n) is solid and kept largely intact — it's mapped below to the **low-code-friendly way to build each piece**, so the same production architecture is reachable without hand-coding most of it.

| Layer | Recommended Tool | Why it fits a non-coder | Coded fallback (if needed) |
|---|---|---|---|
| **Mobile app (iOS/Android)** | **FlutterFlow** (visual builder, exports real Flutter/Dart code) | Drag-and-drop UI, built-in Firebase bindings, generates the same Flutter codebase the PRD specifies — no lock-in | Hand-written Flutter with BLoC/Riverpod, done by Claude Code for complex screens (e.g. kick-counter, video calls) |
| **Backend / Database** | **Firebase** (Auth, Firestore, Cloud Functions, Storage) | Managed, console-based, scales automatically, integrates natively with FlutterFlow | Node.js Cloud Functions for custom logic (payments, notifications, provider-matching) — written by Claude Code |
| **Admin / Ops Dashboard** | **Retool** or **Softr** (on top of Firebase/Firestore data) | Build internal tools (manage providers, moderate community, view bookings) by dragging in tables/forms, no React needed | Next.js + TypeScript admin panel, if you need full custom branding or a public-facing dashboard |
| **Workflow Automation** | **n8n** (self-hosted or n8n Cloud) | Already no-code; visual flows for onboarding emails, provider intake, reminders | Cloud Functions triggers for anything n8n can't reach |
| **Video Calling (AMAs, consults)** | **Agora** or **Daily.co** (drop-in SDK/embeddable widget) | Daily.co offers a prebuilt embeddable call UI (near zero-code); Agora if FlutterFlow custom widget needed | Native Agora SDK integration in Flutter, via Claude Code |
| **Payments** | **Razorpay** (India-first) or **Stripe** | Both have no-code checkout links/plugins for simple flows; full SDK for booking-linked payments | Cloud Function webhook handling for booking confirmation |
| **Appointment Booking** | **Cal.com** (embeddable, open-source scheduling) | No-code scheduling widget you can embed directly | Custom Firestore-based booking logic if you need tighter integration with provider profiles |
| **Community Forums** | **Firebase Firestore + FlutterFlow chat components**, or **Circle.so** as a faster-to-launch alternative | Circle.so is a ready-made, no-code community platform if you want to launch community before the app is ready | Custom in-app forum built in Flutter |
| **Wearables Integration** | Apple HealthKit / Google Fit native plugins (FlutterFlow custom actions) | FlutterFlow supports custom actions; wiring is still a small coded piece | Done by Claude Code — this one genuinely needs code |
| **Testing / QA** | **Playwright** (web/admin), **Firebase Test Lab** (mobile) | Test scripts written and maintained by Claude Code; you just watch the automated report | N/A — this stays engineering-owned |
| **CI/CD** | **GitHub Actions** + **Firebase App Distribution** | Fully automated once set up; you get a build link on your phone after every change | N/A — engineering-owned |
| **Crash/Performance Monitoring** | **Firebase Crashlytics** | Dashboard-based, no code to read | N/A |

**Bottom line:** you'll spend most of your hands-on time in **FlutterFlow** (app screens), **Retool/Softr** (admin), **n8n** (automations), and **Cal.com/Circle.so** (booking/community) — all visual tools. Claude Code owns Firebase backend logic, integrations, testing, and CI/CD.

---

## 2. Project Structure

Monorepo layout, so everything ships from one repository with clear ownership per folder:

```
my-ai-app/
├── ROADMAP.md                     ← this file
├── docs/
│   ├── product-requirements.md    ← source PRD
│   └── architecture-diagram.md    ← system flow (Mermaid)
│
├── mobile/                        ← Flutter app (exported from FlutterFlow, refined by Claude Code)
│   ├── lib/
│   │   ├── presentation/          ← screens, widgets (Clean Architecture)
│   │   ├── domain/                ← entities, use cases
│   │   ├── data/                  ← repositories, models
│   │   └── infrastructure/        ← Firebase, HealthKit/Google Fit, Agora clients
│   └── test/
│
├── backend/
│   ├── functions/                 ← Firebase Cloud Functions (Node.js/TypeScript)
│   │   ├── auth/                  ← onboarding, OTP, biometric hooks
│   │   ├── bookings/              ← consultation scheduling logic
│   │   ├── payments/              ← Razorpay/Stripe webhooks
│   │   └── notifications/         ← push/email triggers
│   └── firestore.rules            ← security rules for health data
│
├── admin/                         ← Next.js admin panel (if/when custom-built beyond Retool)
│   ├── app/
│   └── components/
│
├── automation/
│   └── n8n-workflows/             ← exported n8n workflow JSON (version-controlled)
│
├── qa/
│   ├── playwright/                ← E2E tests for admin + booking + telehealth flows
│   └── firebase-test-lab/         ← mobile smoke test configs
│
└── .github/
    └── workflows/                 ← CI/CD pipelines (build, test, distribute)
```

---

## 3. Phased Development Roadmap

### Phase 0 — Foundations (Week 1–2)
**Goal:** Infrastructure exists; you can log into every tool.
- Set up Firebase project (Auth, Firestore, Storage, Functions, Crashlytics).
- Set up FlutterFlow project connected to Firebase.
- Set up GitHub repo structure (this scaffold), CI/CD skeleton.
- Set up n8n instance (cloud or self-hosted).
- Draft Firestore data model for: users, pregnancy profile, baby profile, providers, bookings, community posts.
- **Compliance flag:** Since this handles health data (and references Indian cultural context — Garbh Sanskar), confirm target market now. If India: design data handling around the **DPDP Act 2023**; if US/global: plan for **HIPAA-aware** data practices (encryption at rest/in transit, consent capture, data export/delete). This affects Firestore rules and consent screens from day one — decide before Phase 1 build starts.
- **Milestone:** Empty app shell builds and installs on a test phone via Firebase App Distribution.

### Phase 1 — Epic 1: Onboarding & Profiling (Week 3–5)
**Goal:** A user can sign up and tell us who they are.
- Phone/OTP, Google, Apple sign-in (Firebase Auth, wired in FlutterFlow).
- Progressive profiling flow: due date, pregnancy stage, health goals.
- Optional Apple Health / Google Fit connect screen (native plugin — Claude Code).
- Basic user Firestore schema live and validated.
- **Milestone:** New user can sign up, complete profile, and see a personalized "Welcome, Week X" home screen.

### Phase 2 — Epic 2: Womb Care Module / Prenatal (Week 6–10)
**Goal:** Core pregnancy tracking experience.
- Week-by-week fetal development tracker (content-driven, built as a FlutterFlow collection + CMS-style Firestore content).
- Vitals input (BP, weight, kick counter) with simple charts.
- Mindfulness & bonding content library (audio/video for Garbh Sanskar, meditation, fetal learning).
- Prenatal yoga video library + trimester diet charts (static content, CMS-managed so you can update without a rebuild).
- **Milestone:** A pregnant test user can log vitals daily and browse a full week-by-week journey.

### Phase 3 — Epic 3: Fourth Trimester / Postpartum (Week 11–14)
**Goal:** Platform extends naturally after birth.
- Baby care trackers: sleep, feeding (breast/bottle/pump), diapers — dashboard view.
- Postpartum recovery: diet plans, gentle exercise content.
- Milestone mapping: month-by-month development guide.
- **Milestone:** A user can "graduate" from pregnancy tracking to baby tracking without losing their history/profile.

### Phase 4 — Epic 4: Expert Access & Community (Week 15–19)
**Goal:** Monetizable, high-trust human touchpoints.
- Provider (doctor/lactation consultant) profiles and directory.
- 1-on-1 consultation booking (Cal.com embed or custom Firestore booking + payment via Razorpay/Stripe).
- Live AMA rooms (Daily.co/Agora embedded video).
- Community forums — due-date and interest-based groups (Firestore-backed or Circle.so if launching community earlier is a priority).
- n8n workflows: provider onboarding, intake provisioning, booking reminders, marketing notifications.
- **Milestone:** A user can book and complete a real video consultation end-to-end, including payment.

### Phase 5 — Hardening, QA Automation & Launch Prep (Week 20–22)
**Goal:** Production-ready, monitored, testable release.
- Playwright E2E suites: signup, booking, telehealth session, admin flows.
- GitHub Actions CI: run Playwright + smoke tests on every PR, auto-distribute mobile builds.
- Crashlytics dashboards reviewed; performance budget set.
- Security review of Firestore rules (especially health data access scoping).
- App Store / Play Store listing prep.
- **Milestone:** Green CI pipeline, signed builds, store listings ready for submission.

### Phase 6 — Post-Launch Iteration (Ongoing)
- Analytics-driven backlog grooming (which epics get used least/most).
- A/B testing on onboarding conversion.
- Expand provider network via n8n-automated intake.
- Localization (if targeting multiple regions/languages).

---

## 4. Immediate Next Steps (This Week)

1. **You decide:** target market/compliance regime (India-first vs. global) — this shapes data rules from Phase 0.
2. **You decide:** FlutterFlow vs. fully hand-coded Flutter — FlutterFlow is recommended for speed given you're non-technical, but has a paid tier for team collaboration + Firebase integration.
3. **Claude Code sets up:** Firebase project skeleton, GitHub Actions CI shell, Firestore data model draft, and the `mobile/`, `backend/`, `automation/`, `qa/` folder scaffolding in this repo.
4. **You test:** log into Firebase console and FlutterFlow to confirm access once Phase 0 scaffolding is pushed.

---

## 5. Open Questions to Resolve Before Phase 1

- Primary market/geography (affects compliance, payment gateway, language of content).
- Do providers (doctors/lactation consultants) get their own login/dashboard, or are they managed entirely by your ops team via the admin panel?
- Is community moderation manual (admin panel) or automated (rules + reporting) at launch?
- Monetization model: subscription, pay-per-consult, or freemium — affects the payments/booking build order.

---

*Next: reply with answers to the open questions above (or say "use your best judgment"), and I'll scaffold Phase 0 in this repository.*
