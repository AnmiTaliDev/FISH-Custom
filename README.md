# Fish Shell Configuration Script 🐟

**Current Version:** 1.0.0  
**Last Updated:** 2025-03-28 16:17:41 UTC  
**Author:** AnmiTaliDev

A powerful and user-friendly Fish shell configuration script that sets up a customized environment with themes, plugins, and optimized settings.

## 📋 Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Available Themes](#available-themes)
- [Included Plugins](#included-plugins)
- [Directory Structure](#directory-structure)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## ✨ Features

- 🎨 Interactive theme selection with previews
- 🔌 Automated plugin installation and configuration
- ⚡ Performance-optimized settings
- 📝 Custom editor selection
- 🔄 Automatic backup of existing configuration
- 📊 Detailed logging
- 🛠️ Local customization support

## 🔧 Prerequisites

- Fish shell (3.0.0 or later)
- Git
- Curl
- Internet connection for downloading plugins and themes

## 💻 Installation

1. Clone the repository:
```bash
git clone https://github.com/AnmiTaliDev/FISH-Custom.git
cd fish-config
```

2. Make the script executable:
```bash
chmod +x fish_setup.fish
```

3. Run the configuration script:
```bash
./fish_setup.fish
```

4. Apply the new configuration:
```bash
exec fish
```

## 🎨 Available Themes

The script includes several popular themes:

- **default**: The default Fish theme - clean and simple
- **agnoster**: Powerline-style theme with git integration
- **bobthefish**: Powerline-style, feature-rich theme
- **clearance**: Informative and clean theme
- **astronaut**: Minimalistic theme for space travelers
- **sashimi**: Clean and compact theme

> **Note**: Some themes (like bobthefish) require a Powerline-compatible font for optimal display.

## 🔌 Included Plugins

### Basic Plugins (Auto-installed)
- `foreign-env`: Environment variable management
- `fzf`: Fuzzy file search
- `bang-bang`: Bash-style history substitution
- `done`: Notification when long-running commands complete
- `bass`: Bash script compatibility layer
- `colored-man-pages`: Colored man page output

### Additional Tools
- Fisher package manager
- FZF integration
- Custom function support

## 📁 Directory Structure

```
~/.config/fish/
├── config.fish          # Main configuration file
├── functions/           # Custom functions
├── custom/             # Custom configurations
├── local.fish          # Local machine-specific settings
└── completions/        # Custom completions
```

## 🛠️ Customization

### Local Configuration
Add machine-specific settings to `~/.config/fish/local.fish`:

```fish
# Example customizations
set -gx CUSTOM_PATH /path/to/custom/bin
set -gx API_KEY your_api_key
```

### Custom Functions
Add your functions to `~/.config/fish/functions/`:

```fish
# ~/.config/fish/functions/my_custom_function.fish
function my_custom_function
    echo "Custom functionality here"
end
```

## ❗ Troubleshooting

### Common Issues

1. **Theme doesn't display correctly**
   - Ensure you have a Powerline-compatible font installed
   - Try running `omf theme [theme_name]` manually

2. **Plugins not working**
   - Check if Oh My Fish is installed: `omf version`
   - Try reinstalling the plugin: `omf install [plugin_name]`

3. **Configuration not loading**
   - Verify file permissions: `ls -la ~/.config/fish/`
   - Try restarting Fish: `exec fish`

### Logs
Check the log file in `/tmp/fish_setup_[timestamp].log` for detailed information about the installation process.

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch:
```bash
git checkout -b feature/amazing-feature
```
3. Commit your changes:
```bash
git commit -m 'Add amazing feature'
```
4. Push to the branch:
```bash
git push origin feature/amazing-feature
```
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

> 🌟 Star this repository if you find it helpful!

Made with ❤️ by AnmiTaliDev