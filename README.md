# ImageCompressorTool![License](https://img.shields.io/badge/license-MIT-blue.svg)![Bash](https://img.shields.io/badge/bash-5.0%2B-green.svg)

A production‑ready Bash utility that recursively compresses JPEG and PNG images using **jpegoptim** and **optipng**. 
It supports configurable quality levels, parallel processing, logging, and a simple test suite.

---

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [API Reference](#api-reference)
- [Testing](#testing)
- [License](#license)

---

## Features
- **Recursive directory scanning** with pattern matching.
- Configurable **JPEG quality** and **PNG optimization level**.
- **Parallel execution** using GNU `parallel` (optional).
- Structured **JSON log output** for CI integration.
- Environment‑based configuration (`.env`) with sane defaults.
- Comprehensive **unit tests** written in Bash.

---

## Prerequisites

| Tool | Minimum Version | Installation |
|------|-----------------|--------------|
| `bash` | 5.0+ | pre‑installed on most Linux/macOS |
| `jpegoptim` | 1.4.6 | `sudo apt-get install jpegoptim` / `brew install jpegoptim` |
| `optipng` | 0.7.7 | `sudo apt-get install optipng` / `brew install optipng` |
| `parallel` (optional) | 20210822 | `sudo apt-get install parallel` / `brew install parallel` |
| `jq` (for JSON logs) | 1.6 | `sudo apt-get install jq` / `brew install jq` |

All required tools are listed in `requirements.txt`.

---

## Installation

<!-- small cleanup -->
