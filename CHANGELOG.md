# Changelog

All notable changes to the **PQS Board Template** are documented in this file.

This project follows a **controlled update model**:

- Logic changes are versioned
- Venue implementations should reference the template version in use
- Non‑logical changes are explicitly noted

---

## [v2.1.0] – 6/4/26 - Changes on the UI and Functions in the App

**Status:** Approved

### Added

- UI Changes.
- Change on the names of buttons, labels and text boxes.
- For every WI a new email is sent to EPICRSTrainers.
- On ```scrFullON``` if <20 Questions have been asked the completed button displays a different text and will change on >20.
- **EPIC_PQSBoardResults** now shows the status of the Board/Review.
- **EPIC_PQSBoardResults** now shows how many times the refresh button was triggered, only in PQS Boards.
- For **WIs** on PQS Boards it gives an error if blank **or** if the user writes "WI".
- For **WIs** now it requires to make a MOD Selection.

### Fixed

- Email sent after PQS Board/Review now has the name of the .PDF File in the subject, showing the Venue.
- SSO is needed to show Start button for PQS Boards and Reviews.

>[!IMPORTANT]
>This version is not stable yet, more work needs to be done before it goes live to production

---

## Previous Versions

## [v2.0.0] – 6/3/26 - App updated for All of EPIC Universe, 1 app for all venues

**Status:** Approved

### Added

- Now all the venues can be accesed by a single app
- Multiple updates in UI
- Multiple functions to get the app ready for deployment

### Fixed

-

>[!IMPORTANT]
>This version is not stable yet, more work needs to be done before it goes live to production

## [v1.3.0] – Update on Review and creations of a PDF File

**Status:** Approved

### Added

- Added `Gallery1` in `scrReview`
  - Added `Button1` inside `Gallery1`
- Added `btnPDF` in `scrSummary`

### Fixed

- Now `scrReview` will only show all the possible Mods for the selected venue.
- With `btnPDF` in `scrSummary` a PDF will be emailed including:
  - Results of the Board
          - Answers are shown only as Incorrect or Correct
  - Questions Asked
  - Tech name and SSO
  - Supervisor name and SSO
  - Manager name and SSO
  - Date and time
  - Venue

>[!IMPORTANT]
>The `btnPDF` is currently hidden.
>
>It worked during testing but in order to be fully functional a change in the SOP needs to be made.
>If you want to test the function you will need to Unhide `btnPDF`

---

## [v1.2.1] – Documentation updated

**Status:** In Progress  

### Added

- updated changes from [v1.2.0] to:
  - README.md
  - VENUE_SETUP.md

---

## [v1.2.0] – Adding new page to have 1 App per Land

**Status:** In Progress  

### Added

- Added `scrVenue`
  - Added `btnNext` and `ddVenue`

### Fixed

- Now `ddVenue` will select one Venue out of the Possible Venues in the Land, this will help on getting only **ONE APP** per land instead of one app per Venue
- Changed the functionality of `scrBoard`
  - `CheckBox 4` will still filter the Database and only show the posible mods per venue
  - Code was changed on `galMods` and `Checkbox4`
- Selecting the Venue in `ddVenue` will automatically update the name of the venue in `lblVenue`.

>[!NOTE]
>Changes still need to be made in `README.md`, `FORMULAS_OVERVIEW.md` and `VENUE_SETUP.md` on a later date.

>[!IMPORTANT]
>Changes in `FORMULA_OVERVIEW.md` are not done, so please don't refer to `FORMULA_OVERVIEW.md` until after all changes are made

---

## [v1.0.1] – Minor patch

**Status:** Approved

### Added

- All the Exit and Back Buttons are now clearing colActiveMods
- Added ``varVenue``

### Fixed

- on scrBoard, when ``Full PQS`` was auto selected, ``scrFullON`` was not loading the buttons in ``galMod``.
This has been fixed by forcing the selection of a Mod, updating the code in ``btnStart``.
Now ``btnStart`` is not selectable until a selection is made.
- on `scrHome` &rarr; `OnVisible = Set(varVenue,lblvenue.Text)`.
Now once the Name of the Venue is added, it will update on:
- `scrBoard` &rarr; `lblPQSStart`
- `scrReview` &rarr; `lblReview`
- `scrFullON` &rarr; `lblBoard`
- `scrSummary` &rarr; `lblPQSResult`
- **Updated `VENUE_SETUP.md`**

---

## [v1.0.0] – Initial Stable Template

**Status:** Approved  
**Impact:** Baseline release  

### Added

- Full PQS board engine
- Partial PQS board support
- Live grading with hard stop rules
- Review and summary flows
- Venue‑agnostic data source pattern
- Standardized collections:
  - `colActiveMods`
  - `colPQSQ`
  - `colPQSGrade`

### Board Rules

- Full PQS spans all modules in a single board
- Pass at **20 correct**
- Fail at **4 incorrect**
- Mod 0 always pulls **5 questions**
- Non‑zero modules use Category **A / B** for distribution only

### Data Handling

- Answers displayed in‑app only
- Answers never stored in grading or persistence
- Category values withheld from UI and reporting

### Documentation

- README.md
- VENUE_SETUP.md
- QUESTION_BANK_SCHEMA.md
- ARCHITECTURE.md
- BOARD_LOGIC.md

---

## Version Control

- This repository is the **single source of truth** for PQS Board logic.
- Venue implementations **must not** introduce logic changes outside this repository.
- All revisions must be:
  1. Committed to the template repository
  2. Reflected in this changelog
  3. Released under an explicit version number

## Versioning Explanation

This repository uses **Semantic Versioning** in the format:
``MAJOR.MINOR.PATCH``

### MAJOR Version (`1.x.x`)

The **MAJOR** version changes only when **core certification logic or rules change**.

A MAJOR version change indicates that:

- Existing venue implementations may need review
- Board behavior is intentionally different from previous versions

Examples of MAJOR changes:

- Changing pass/fail thresholds
- Redefining what constitutes a Full PQS
- Altering the total number of required correct answers
- Changing grading logic or board termination rules

### MINOR Version (`1.1.x`, `1.2.x`)

The **MINOR** version changes when **new functionality is added** that does **not** break existing behavior.

A MINOR version change indicates that:

- Existing venues continue to function as‑is
- New features are optional or additive
- No certification rule changes occur

Examples of MINOR changes:

- Adding optional audit infrastructure (not enforced)
- Adding PDF export capability
- Adding session IDs without changing grading
- Adding new screens that do not alter board logic

### PATCH Version (`1.0.1`, `1.0.2`, `1.0.x`)

The **PATCH** version changes when **bug fixes or documentation updates** are made with **no logic changes**.

A PATCH version change indicates that:

- Board behavior is identical
- Certification outcomes are unaffected
- Updating is safe and low risk

Examples of PATCH changes:

- Fixing a typo in documentation
- Correcting a label or comment
- Cleaning up non‑functional formulas
- Clarifying variable names without changing logic

