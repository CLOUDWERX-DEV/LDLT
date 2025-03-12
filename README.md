# 🚀 LDLT: Linux Dev Launcher Tool

<p align="center"> <img src="http://github.com/CLOUDWERX-DEV/ldlt/assets/ldlt-logo.svg" alt="LDLT Logo" width="300"/> <br> <em>Streamline your development environment in Linux</em> </p> <p align="center"> <a href="#installation"><img src="https://img.shields.io/badge/platform-Linux-blue.svg" alt="Platform"></a> <a href="#license"><img src="https://img.shields.io/github/license/CLOUDWERX-DEV/ldlt" alt="License"></a> <a href="#installation"><img src="https://img.shields.io/badge/bash-5.0+-brightgreen.svg" alt="Bash Version"></a> <a href="#"><img src="https://img.shields.io/badge/maintenance-active-green.svg" alt="Maintained"></a> </p>
  
  
  Streamline your development environment in Linux



  
  
  
## 🌟 Overview

LDLT is a colorful, interactive Bash script that seamlessly integrates Cursor into your Linux environment. With just one command, you can set up terminal commands, system icons, desktop launchers, and file manager context menu actions for editors like Cursor, VSCode, VSCode Insiders, and Windsurf. Takes the pain out of using Cursors AppImage!


  


## ✨ Features

- **🖥️ Terminal Integration**: Run Cursor from anywhere in your terminal
- **🔍 AppImage Support**: Register Cursor PATH for system commands
- **🎨 Icon Installation**: System-wide Cursor icon installation for proper desktop integration
- **📋 Context Menu Actions**: Add right-click "Open in..." options to your Nemo file manager
- **📱 Application Launcher**: Integrate Cursor with your system's application menu
- **💥 Easter Egg**: Includes a fun nuclear launch animation (because why not?)

## 📋 Requirements

- Linux distribution with Bash
- Sudo privileges for system-wide integration
- Nemo file manager (for context menu actions)
- A Cursor AppImage

## 🚀 Installation

1. Clone this repository:
   ```bash
   git clone http://github.com/CLOUDWERX-DEV/ldlt.git
   cd ldlt
   ```

2. Make the script executable:
   ```bash
   chmod +x ldlt.sh
   ```

3. Run the script:
   ```bash
   ./ldlt.sh
   ```

## 📚 Usage

### Main Menu Options 


1. **Install Cursor AppImage to PATH**: Register the Cursor AppImage as a system command
   ```bash
   # After installation, use from anywhere:
   cursor                   # Open Cursor
   cursor .                 # Open current directory
   cursor myproject/        # Open specific directory
   cursor file.js           # Open specific file
   ```

2. **Install Cursor Icon System-Wide**: Add the Cursor icon to your system
   ```
   Makes Cursor show up properly in application launchers and context menus
   ```

3. **Add Dev Launch Actions to Nemo Context Menu**: Add "Open in..." actions to your file manager
   ```
   Adds right-click options to open files/folders in your preferred editors
   ```

4. **Launch a Nuke**: Enjoy a colorful terminal animation

5. **Do It All!**: Perform all operations in sequence for a complete setup

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests

Please ensure your code follows the project's style and includes appropriate tests.

## 📃 License

This project is licensed under the MIT License - see the [LICENSE](http://github.com/CLOUDWERX-DEV/ldlt/LICENSE) file for details.

---

  Made by CLOUDWERX LAB: Check us out at http://cloudwerx.dev | http://github.com/CLOUDWERX-DEV
  

  Happy coding! 💻