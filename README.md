# 🛒 E-Commerce Test Automation Framework

![Robot Framework](https://img.shields.io/badge/Robot%20Framework-7.0-black?style=for-the-badge&logo=robotframework&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.11-blue?style=for-the-badge&logo=python&logoColor=white)
![Selenium](https://img.shields.io/badge/SeleniumLibrary-6.3-green?style=for-the-badge&logo=selenium&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%2FCD-2088FF?style=for-the-badge&logo=githubactions&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

A scalable, production-grade test automation framework built with **Robot Framework** and **SeleniumLibrary** for a live e-commerce web application — [TesterBud Practice E-Commerce](https://testerbud.com/practice-ecommerece-website).

The project follows the **Page Object Model (POM)** design pattern and covers **327+ test cases** across functional, end-to-end, security, accessibility, and responsive testing layers.

---

## 📋 Table of Contents

- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Test Coverage](#-test-coverage)
- [Getting Started](#-getting-started)
- [Running Tests](#-running-tests)
- [CI/CD Pipeline](#-cicd-pipeline)
- [Test Tags](#-test-tags)
- [Author](#-author)

---

## 🧰 Tech Stack

| Tool | Purpose |
|---|---|
| **Robot Framework 7.0** | Core test automation framework |
| **SeleniumLibrary 6.3** | Browser automation via Selenium WebDriver |
| **Python 3.11** | Scripting and test logic |
| **ChromeDriver** | Headless Chrome execution |
| **GitHub Actions** | CI/CD pipeline with scheduled runs |
| **dawidd6/action-send-mail** | Automated email reports after each run |

---

## 📁 Project Structure

```
ecommerce-test-automation-robot_framework/
│
├── .github/
│   └── workflows/
│       └── robot-tests.yml        # GitHub Actions CI/CD pipeline
│
├── config/
│   └── variables.yaml             # Base URL, browser, timeout config
│
├── resources/
│   ├── common/
│   │   └── common.resource        # Shared keywords & browser utilities
│   └── pages/                     # Page Object Model (one file per page)
│       ├── home_page.resource
│       ├── login_page.resource
│       ├── signup_page.resource
│       ├── products_page.resource
│       ├── product_detail_page.resource
│       ├── cart_page.resource
│       └── checkout_page.resource
│
├── tests/
│   ├── home_tests.robot            # 35 test cases
│   ├── login_tests.robot           # 47 test cases
│   ├── signup_tests.robot          # 50 test cases
│   ├── products_tests.robot        # 48 test cases
│   ├── cart_tests.robot            # 39 test cases
│   ├── checkout_tests.robot        # 38 test cases
│   ├── e2e_tests.robot             # 27 end-to-end scenarios
│   ├── ui_and_responsiveness_tests.robot   # 20 test cases
│   └── accessibility_tests.robot   # 23 test cases
│
├── results/                        # Auto-generated: report.html, log.html
├── requirements.txt
├── run_tests.bat                   # Windows test runner script
└── .gitignore
```

---

## ✅ Test Coverage

### 327 Test Cases across 9 Suites

| Suite | Test Cases | Coverage Focus |
|---|---|---|
| 🏠 Home | 35 | Navigation, search, XSS/SQLi, images, links, page integrity |
| 🔐 Login | 47 | UI elements, email/password validation, security, keyboard nav, multi-attempt |
| 📝 Signup | 50 | Field validation, password strength, email formats, boundary, security |
| 🛍️ Products | 48 | Listing, filtering, sorting, detail page, quantity controls, reviews |
| 🛒 Cart | 39 | Add/remove, quantity edge cases, pricing, coupons, persistence |
| 💳 Checkout | 38 | Form validation, field boundaries, security injection, error recovery |
| 🔁 E2E | 27 | Full user journeys, multi-product flows, login+shop, error recovery |
| 📱 UI & Responsive | 20 | Mobile (375px), tablet (768px), desktop (1920px), scroll, multi-tab |
| ♿ Accessibility | 23 | Input types, alt text, keyboard nav, focus, ARIA, viewport meta |

### Testing Categories

```
✔ Functional Testing       ✔ Negative Testing
✔ End-to-End Testing       ✔ Boundary Value Analysis
✔ Security Testing (XSS, SQLi)  ✔ Accessibility Testing
✔ Responsive / UI Testing  ✔ Persistence Testing
✔ Smoke Testing            ✔ Regression Testing
```

---

## 🚀 Getting Started

### Prerequisites

- Python 3.11+
- Google Chrome browser
- Git

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/PranjalSurjan/ecommerce-test-automation-robot_framework.git
cd ecommerce-test-automation-robot_framework

# 2. Install dependencies
pip install -r requirements.txt
```

**requirements.txt**
```
robotframework>=7.0
robotframework-seleniumlibrary>=6.3
robotframework-browser>=18.0
webdrivermanager>=0.10.0
```

---

## ▶️ Running Tests

### Windows (Batch Script)

```bash
# Run all 327 tests
run_tests.bat

# Run by suite
run_tests.bat smoke
run_tests.bat e2e
run_tests.bat login
run_tests.bat signup
run_tests.bat products
run_tests.bat cart
run_tests.bat checkout
run_tests.bat responsive
run_tests.bat accessibility

# Run by tag
run_tests.bat negative
run_tests.bat security
run_tests.bat boundary
run_tests.bat validation
run_tests.bat functional
run_tests.bat navigation
```

### Direct Robot Framework Commands

```bash
# Run all tests
robot --outputdir results tests/

# Run a specific suite
robot --outputdir results tests/cart_tests.robot

# Run by tag
robot --outputdir results --include security tests/
robot --outputdir results --include smoke tests/

# Run with headless Chrome
robot --outputdir results --variable BROWSER:headlesschrome tests/
```

### View Test Report

After a run, open the generated HTML report:

```bash
# Windows
start results/report.html

# Mac/Linux
open results/report.html
```

---

## ⚙️ CI/CD Pipeline

The project includes a **GitHub Actions** workflow (`.github/workflows/robot-tests.yml`) with the following capabilities:

### Triggers

| Trigger | Description |
|---|---|
| `workflow_dispatch` | Manual trigger from GitHub Actions tab with suite selection dropdown |
| `schedule` *(commented out)* | `0 8 * * 1-5` — Weekdays 8AM UTC smoke tests |
| `schedule` *(commented out)* | `0 0 * * 0` — Sunday midnight full regression |

### Pipeline Steps

```
1. Checkout Repository
2. Set Up Python 3.11
3. Install Dependencies (pip)
4. Set Up Chrome (headless)
5. Run Robot Framework Tests
6. Upload Artifacts (report.html, log.html, output.xml)
7. Publish Summary to GitHub Actions tab
8. 📧 Send Email Report → Pranjalsurjan03@gmail.com
9. Fail job if any tests failed
```

### Email Reports

After every run, an email is automatically sent to **Pranjalsurjan03@gmail.com** with:
- ✅ Run status (passed / failed)
- 📊 Suite name, branch, run number
- 📎 Full `report.html` attached
- 🔗 Direct link to the GitHub Actions run

> **To activate email reports:** Add `MAIL_USERNAME` and `MAIL_PASSWORD` (Gmail App Password) under
> `GitHub → Settings → Secrets → Actions`

---

## 🏷️ Test Tags

Tests are tagged for selective execution:

| Tag | Description |
|---|---|
| `smoke` | Core sanity checks — fastest to run |
| `critical` | Must-pass tests for release sign-off |
| `e2e` | Full end-to-end user journeys |
| `functional` | Feature-level functional tests |
| `negative` | Error handling and invalid input tests |
| `validation` | Form and field validation tests |
| `security` | XSS, SQL injection, input sanitisation |
| `boundary` | Edge cases and limit values |
| `ui` | Visual/layout checks |
| `navigation` | Page routing and link tests |
| `responsive` | Mobile, tablet, desktop viewport tests |
| `accessibility` | Keyboard nav, ARIA, focus, alt text |
| `persistence` | Cart/session state retention tests |
| `keyboard` | Keyboard-only navigation tests |

---

## 👤 Author

**Pranjal Surjan**
📧 Pranjalsurjan03@gmail.com
🔗 [github.com/PranjalSurjan](https://github.com/PranjalSurjan)

---

> 💡 *This project was built as a demonstration of professional test automation skills using industry-standard tools and best practices.*
