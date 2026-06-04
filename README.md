# EPICPQS_App

## Overview
EPICPQS_App is a centralized Power Apps solution designed to manage PQS certification boards and supervisor/trainer reviews across all 18 venues at Epic Universe.

The application serves as a reusable, scalable system that dynamically loads venue-specific data while maintaining a standardized certification and review process.

---

## Features
- Full PQS Boards and Partial PQS Boards
- Supervisor / Trainer Review mode
- Session-based tracking using SharePoint lists
- Automatic pass/fail calculation logic
- Support for multiple module selections in Partial Boards
- Dynamic question count based on selected modules and venue configuration
- Write-in question support during PQS Boards
- End-of-session summary screen (Boards)
- Automatic PDF generation after Board or Review completion
- Review workflow returns to Home screen upon completion

---

## Architecture
The system is built as a reusable Power Apps template with a per-venue data structure.

- One core app handles all venues
- SharePoint lists act as the data layer
- Data is dynamically loaded based on selected Land and Venue
- Sessions are tracked and stored for reporting and auditing

---

## Board Logic & Rules
- Mod 0 always contains exactly **5 questions**
- Remaining questions are distributed across other selected modules
- All questions are **randomly pulled from the Question Bank**
- Total number of questions is configurable per venue
- Supports both Full Boards and Partial Boards
- Multiple modules can be selected simultaneously for Partial Boards

---

## Data Sources
All data sources are maintained in SharePoint as Lists.

### Data Protection
- Columns must be hidden after edits to prevent answer leakage
- Question and answer visibility is controlled within the app
- Data is not stored in the application itself

---

## Usage
1. Select a **Land**
2. Select a **Venue** (data sources load dynamically)
3. Choose:
   - PQS Board
   - Review
4. Enter required personnel information (SSO):
   - Technician
   - Manager
   - Supervisor
   - Trainer
5. Conduct the session:
   - Questions are displayed from the data bank
   - Responses are recorded in real time
6. On completion:
   - PQS Board:
     - Summary screen is displayed
     - PDF is automatically generated
   - Review:
     - PDF is generated
     - App returns to Home screen

---

## Setup
A separate document will be provided in this repository with full setup instructions for:

- Initial deployment
- SharePoint list configuration
- Data connection setup
- Environment preparation

---
<details>
<summary>Development Workflow (GitHub)</summary>

## This project uses GitHub for source control of the Power App.

### Export and Update Process

```bash
pac solution export --name PQS_EPIC --path solution.zip --managed false --overwrite

pac solution unpack --zipfile solution.zip --folder src --packagetype Unmanaged

pac canvas unpack --msapp src\CanvasApps\*.msapp --sources src\CanvasApps\app


git add .
git commit -m "Describe change"
git push
```
</details>

---


## Key Source Files

Core application logic is stored in:
```src/CanvasApps/app/Src/```

Important files:
```App.fx.yaml``` → Global variables and initialization

---

## CHANGELOG
All notable changes are tracked in:
``CHANGELOG.md``
