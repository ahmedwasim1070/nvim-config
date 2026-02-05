# Neovim Config

Minimalist NVIM Config, kept it simple as possible.

---

## 🛠Core Plugins

This configuration is written entirely in **Lua** and managed via **Packer**.

- **Core:** Neovim (Lua)
- **Package Manager:** Packer.nvim
- **Theme:** Oxocarbon (With True Transparency)
- **The Brain (LSP):** Mason, LspConfig, CMP (Auto-Completion), None-LS (Formatting)
- **The Eyes (Syntax):** Nvim-Treesitter
- **Navigation:** Telescope (Fuzzy Finder), Nvim-Tree (File Explorer)
- **Git Integration:** Gitsigns
- **Status Line:** Custom "Hero" Lua Module (No bloated plugins)

---

## 🚀 Language Support

Fully configured Language Server Protocols (LSP) with auto-formatting and error checking for:

- **MERN Stack:** TypeScript, JavaScript, HTML, CSS, JSON
- **System:** C++, C
- **Data Science/Scripting:** Python
- **Backend:** Go (Golang), C# (.NET / OmniSharp)
- **Config:** Lua

---

## ✨ Key Features

- **UI:** Oxocarbon Theme (Transparent) + Custom Lightweight Statusline.
- **AI-Workflow:** Optimized for "AI-Assisted" coding with smart snippets and error handling.
- **LSP & Format:** Full auto-completion and "Format on Save" for all supported languages.
- **Navigation:** Telescope (Smart Filters for node_modules/bin) & Nvim-Tree.
- **Git:** Gitsigns with custom "Guardian Cat"  status indicators.
- **Performance:** Bloat-free startup with modular Lua architecture (No heavy statusline plugins).

---

## 📦 Installation

1.  **Clone the repo:**

    ```bash
    git clone [https://github.com/ahmedwasim1070/nvim-config](https://github.com/ahmedwasim1070/nvim-config) ~/.config/nvim
    ```

2.  **Install Packer (if not present):**

    ```bash
    git clone --depth 1 [https://github.com/wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)\
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    ```

3.  **Sync Plugins:**
    Open `nvim` and run:

    ```vim
    :PackerSync
    ```

4.  **Install Dependencies (Arch Linux):**
    ```bash
    sudo pacman -S base-devel nodejs npm python go dotnet-sdk tree-sitter-cli
    ```

---

> **Note:** This is a personal backup for my specific workflow. Feel free to fork it and make it your own!
