# 📁 File Organizer Script (Bash)

A simple Bash script that automatically organizes files in a directory into categorized folders based on their file extensions.

This project is designed for beginners to practice Bash scripting, file handling, and automation concepts.

---

## 🚀 Features

- Organizes files into folders based on extension
- Supports multiple file types:
  - Images (`jpg`, `jpeg`, `png`)
  - Documents (`doc`, `docx`, `txt`, `pdf`)
  - Spreadsheets (`xls`, `xlsx`, `csv`)
  - Scripts (`sh`)
  - Archives (`zip`, `tar`, `tar.gz`, `tar.bz2`)
  - Presentations (`ppt`, `pptx`)
  - Audio (`mp3`)
  - Video (`mp4`)
- Moves unknown file types into an `anyelse` folder
- Prevents overwriting existing files (`mv -n`)
- Supports both CLI and interactive input

---

## 📦 Requirements

- Linux / macOS environment
- Bash shell
- Standard Unix utilities (`find`, `mv`)

---

## ⚙️ Usage

### Make script executable
```bash
chmod +x file-organizer.sh

Run with folder path
./fileorganiser.sh -f /path/to/folder

Run interactively
./fileorganiser.sh

👨‍💻 Author
SJ
Created: June 2026