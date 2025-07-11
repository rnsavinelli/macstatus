# Script Monitor: the scriptable macOS menu bar applet

![Made with AppleScript](https://img.shields.io/badge/Made%20with-AppleScript-blueviolet?style=for-the-badge&logo=applescript)

**Script Monitor** is a lightweight and extensible macOS menu bar applet written in AppleScript. It periodically executes a user-defined shell script and displays its output in the menu bar, making it ideal for monitoring system stats, weather, custom metrics, and more.

---

## ✨ Features

- 🖥️ Displays shell script output directly in the macOS menu bar  
- 📝 Easily editable script and preferences via menu items  
- 🔄 Auto-refreshes output at configurable intervals  
- ⚙️ Stores config in `~/.config/script-monitor/`  
- 🧩 Written using native AppleScript and Cocoa frameworks  

---

## 📁 Configuration

Upon first run, `Script Monitor` automatically creates the following files:

- **Script file**  
  ```bash
  ~/.config/script-monitor/script
  ```

This shell script will be executed periodically, and its output will be displayed in the menu bar.

- **Preferences file**  
  ```bash
  ~/.config/script-monitor/preferences
  ```
Example contents:
  ```bash
  interval=5
  ```

## 🛠️ Usage and installation

### 📦 Installation

To install the menu bar applet run:

  ```bash
  cd /tmp
  git clone git@github.com:rnsavinelli/script-monitor.git
  cd script-monitor
  zsh ./install.sh
  ```
In order to move the newly built application to the ```/Applications``` folder the script will prompt you to write your password as that commands need to be run as root.

### 🔧 Example Script

The default script content is:

  ```bash
  echo "Welcome to Script Monitor!"
  ```
You can replace it with any shell command. For example:
  ```bash
  echo "CPU: $(top -l 1 | grep 'CPU usage' | awk '{print $3}')"
  ```
This would display the current CPU usage in the menu bar.

### 🔍 Menu Options
- Edit Script – Opens your script in TextEdit
- Edit Preferences – Opens the preferences file
- About Script Monitor – Displays author and support info
- Quit – Exits the applet

## 🙋‍♂️ About the Developer
Roberto Nicolas Savinelli

📧 Email the developer: [rnsavinelli@gmail.com](mailto:rnsavinelli@gmail.com)

❤️ Support the developer: [@rnsavinelli](https://github.com/rnsavinelli)

## ☕ Support

If you find this project useful, consider supporting the developer by visiting the GitHub link above.

## 📜 License

This project is released under the MIT License.
