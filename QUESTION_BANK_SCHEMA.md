# Question Bank Schema

This document defines the **required SharePoint question bank schema** for the PQS Board Template.

All venue implementations **must follow this schema exactly**.  
Any deviation may result in runtime failures or incorrect board behavior.

---

## List Naming Convention

Each venue must provide its own SharePoint list.

Recommended format:

``2LettersVenue_PQSBank``

**Example**
For Curse of the Werewolf

``CU_PQSBank``

---

## Required Columns

The question bank **must** contain the following columns.

---

### Question
- Type: Text
- Required: Yes
- Usage:
  - Displayed to the technician during the board
  - Used in summary and review displays

---

### Answer
- Type: Text
- Required: Yes
- Usage:
  - Displayed live during boards and review
  - **Never stored** in grading or persistence

---

### Mod
- Type: Choice
- Required: Yes
- Usage:
  - Determines module grouping
  - Drives question distribution logic
  - Populates module selection UI

**Allowed Values**

"0", "1", "2", "3", "4"

---

### Cat
- Type: Choice
- Required: Yes (for Mods 1+)
- Usage:
  - Internal distribution only
  - Never displayed or reported

**Allowed Values**

"A", "B"

Category values must never appear in:
- UI
- Summary
- Exports
- Reports

---

>[!IMPORTANT]
>For a venue question bank to be valid:
>
>- Column names must match exactly
>- Column types must match exactly
>- Choice values must match exactly
>- No additional logic should be embedded in the list
