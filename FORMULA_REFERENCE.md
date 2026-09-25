# EPIC PQS App - Formula Reference

This document serves as the technical reference for key application logic used within the EPIC PQS Power App.

The purpose of this document is to provide a centralized location for business rules, formulas, collections, variables, randomization logic, board rules, review rules, PDF generation, and data architecture so future updates can be made without reverse-engineering the application.

---

## Global Variables

### Session Variables

```powerfx
varBoardSessionID
VarSessionID
```

### Purpose

Used to uniquely identify every Board and Review session.

---

## Venue Variables

```powerfx
varVenue
varVenueSelected
varQuestionSource
```

### Purpose

Stores venue selection and maps users to the proper question bank.

---

## Trainer Variables

```powerfx
varTrainer
varTrainerSSO
```

### Purpose

Automatically assigns the Trainer for the selected land.

---

## Board Statistics

```powerfx
varRefreshCount
varCorrect
varBoardStatus
```

### Purpose

Tracks refreshes, score percentage, and final status.

---

# Venue Selection Logic

## Land Selection

```powerfx
ddLand
```

Available values:

```text
Celestial Park
Dark Universe
Isle of Berk
Nintendo
Potter
Shared Services
```

---

## Venue Selection

Venue options are dynamically populated based on:

```powerfx
ddLand.Selected.Value
```

---

## Question Bank Routing

```powerfx
Set(varQuestionSource,...)
```

### Examples

```text
Darkmoor                → DU_PQSBank
Curse of the Werewolf   → CU_PQSBank
Monsters Unchained      → UC_PQSBank

Ministry of Magic       → MI_PQSBank
Paris                   → PA_PQSBank
Le Cirque Arcanus       → AR_PQSBank

Show Systems            → EUSS_PQSBank
```

### Purpose

Loads the venue-specific SharePoint question bank.

---

# PQS Types

## Full PQS

```text
Single board session
All selected Mods combined
```

### Rule

```text
20 Correct Answers Required
```

across the entire board.

Mods are NOT treated as separate boards.

---

## Partial PQS

The Manager manually selects modules.

Stored in:

```powerfx
colActiveMods
```

---

# Module Logic

## Mod 0

### Rules

```text
Always uses uncategorized questions
```

### Minimum

```text
5 Questions
```

---

## Mods 1+

Questions use:

```text
Category A
Category B
```

for Trainer randomization purposes only.

### Important

```text
Category A/B never appears on reports,
results, PDFs, or board outcomes.
```

---

# Session Creation

## Board Session

Triggered from:

```text
scrBoard
btnStart
```

Creates:

```powerfx
varBoardSessionID
VarSessionID
```

via:

```powerfx
SessionPatch.Run(...)
```

---

## Review Session

Triggered from:

```text
scrPReview
btnStartReview
```

Creates:

```powerfx
varBoardSessionID
VarSessionID
```

via:

```powerfx
SessionPatch.Run(...)
```

---

# Board Refresh Logic

## Purpose

Refresh replaces only ungraded questions while preserving board integrity.

Triggered by:

```text
btnRefreshBoard
```

---

## Preserve Graded Questions

```powerfx
RemoveIf(
    colPQSQ,
    IsBlank(
        LookUp(
            colPQSGrade,
            QuestionID = ID
        )
    )
)
```

### Result

Refresh only rebuilds:

```text
Ungraded Questions
```

---

## Refresh Rules

### Preserve

```text
Module Assignment
Question Type
Graded Questions
Question Distribution
```

### Prevent

```text
Duplicate Questions
Category Swapping
Previously Graded Questions
```

---

## Question Replacement Logic

```text
Category A → Category A
Category B → Category B
```

---

# Board Question Distribution

## Dynamic Question Count

Determined by:

```powerfx
varModCount
```

### Distribution

```text
1 Mod = 30 Questions
2 Mods = 30 Questions
3 Mods = 32 Questions
4 Mods = 36 Questions
5 Mods = 41 Questions
```

---

## Category Distribution

### Mod 0

```text
5 Questions
```

### Single Non-Zero Mod

```text
50% A
50% B
```

### Multiple Mods

```text
3 Category A Questions
Remaining Questions Category B
```

---

# Question Grading

## Correct

Stored as:

```powerfx
IsCorrect = "Correct"
```

Collection:

```text
colPQSGrade
```

---

## Incorrect

Stored as:

```powerfx
IsCorrect = "Incorrect"
```

Collection:

```text
colPQSGrade
```

---

# Write-In Questions

Triggered by:

```text
btnWriteInQuestion
```

Stored in:

```text
EPICWIQuestion
```

and

```text
colWIGrade
```

---

## Required Fields

```text
Question
Answer
Mod
```

Validation prevents:

```text
Blank Question
Blank Answer
Invalid Mod
Placeholder Values
```

---

## Write-In Results

```text
Correct
Incorrect
```

---

# Board Completion Logic

Triggered by:

```text
btnCompleted
```

---

## Minimum Answer Threshold

Display Logic:

```text
20 Answers Required
```

If fewer than 20:

```text
Minimum not met
```

displayed on completion button.

---

# Score Calculation

## Percent Correct

```powerfx
Correct Answers
÷
Total Answered Questions
×
100
```

Stored in:

```text
varCorrect
```

---

# Pass / Fail Logic

```powerfx
If(
    varCorrect >= 80,
    "Passed",
    "Failed"
)
```

---

## Threshold

```text
Pass = 80% or Higher
Fail = Below 80%
```

Stored in:

```text
varBoardStatus
```

---

# Review Workflow

## Review Types

```text
Trainer Review
Supervisor Review
```

Selected through:

```powerfx
rdReview
```

---

## Review Question Distribution

Mod count determines total review questions.

### Distribution

```text
2 Mods = 50 Questions
3 Mods = 50 Questions
4 Mods = 50 Questions
5 Mods = 90 Questions
```

---

## Review Grading

Stored as:

```powerfx
IsCorrect = "Correct"
```

or

```powerfx
IsCorrect = "Incorrect"
```

Collection:

```text
colPQSRGrade
```

---

# PDF Generation

## Board PDF

Triggered by:

```text
PQS_Email_PDF
```

Generates:

```text
Technician Information
Trainer Information
Supervisor Information
Question Results
Write-In Results
Statistics
Board Outcome
```

---

## Review PDF

Triggered by:

```text
ReviewPQS_Email_PDF
```

Generates:

```text
Review Results
Review Statistics
Trainer/Supervisor Information
Question Outcomes
```

---

# SharePoint Lists

## Venue Question Banks

Examples:

```text
DU_PQSBank
CU_PQSBank
UC_PQSBank
MI_PQSBank
PA_PQSBank
AR_PQSBank
MK_PQSBank
YO_PQSBank
DK_PQSBank
EUSS_PQSBank
```

Purpose:

```text
Question Generation
```

---

## EPIC_PQSBoardResults

Primary Board Session Table.

Stores:

```text
Session Information
Board Type
Correct Count
Incorrect Count
Board Status
Times Refreshed
Trainer Information
```

---

## EPICWIQuestion

Write-In Question Repository.

Stores:

```text
Write-In Questions
Write-In Results
Venue
Date
Manager
Session ID
```

---

# Power Automate Flows

## SessionPatch

Purpose:

```text
Create Session
Return Session ID
```

---

## PQS_Email_PDF

Purpose:

```text
Generate Board PDF
Email PDF
Archive Results
```

---

## ReviewPQS_Email_PDF

Purpose:

```text
Generate Review PDF
Email PDF
Archive Results
```

---

# Key Collections

## colActiveMods

Stores:

```text
Selected Modules
```

---

## colPQSQ

Stores:

```text
Generated Board Questions
```

---

## colPQSRQ

Stores:

```text
Generated Review Questions
```

---

## colPQSGrade

Stores:

```text
Board Question Results
```

---

## colPQSRGrade

Stores:

```text
Review Question Results
```

---

## colWIGrade

Stores:

```text
Write-In Question Results
```

---

# Core Board Rules

## Pass Rule

```text
80% Correct Required
```

---

## Completion Rule

```text
20 Answered Questions Required
```

---

## Failure Rule

```text
Below 80% Correct
```

---

# Refresh Rules Summary

```text
Refresh only replaces ungraded questions.

No duplicates allowed.

Category A remains Category A.

Category B remains Category B.

Mod 0 handled separately.

Graded questions are always preserved.
