@echo off
REM ============================================
REM  TesterBud E-Commerce Test Runner
REM ============================================

SET RESULTS_DIR=results

IF "%1"=="" (
    echo Running ALL tests...
    robot --outputdir %RESULTS_DIR% --loglevel DEBUG tests/
) ELSE IF "%1"=="smoke" (
    echo Running SMOKE tests...
    robot --outputdir %RESULTS_DIR% --include smoke tests/
) ELSE IF "%1"=="critical" (
    echo Running CRITICAL tests...
    robot --outputdir %RESULTS_DIR% --include critical tests/
) ELSE IF "%1"=="e2e" (
    echo Running E2E tests...
    robot --outputdir %RESULTS_DIR% tests/e2e_tests.robot
) ELSE IF "%1"=="login" (
    echo Running LOGIN tests...
    robot --outputdir %RESULTS_DIR% tests/login_tests.robot
) ELSE IF "%1"=="products" (
    echo Running PRODUCTS tests...
    robot --outputdir %RESULTS_DIR% tests/products_tests.robot
) ELSE IF "%1"=="cart" (
    echo Running CART tests...
    robot --outputdir %RESULTS_DIR% tests/cart_tests.robot
) ELSE IF "%1"=="checkout" (
    echo Running CHECKOUT tests...
    robot --outputdir %RESULTS_DIR% tests/checkout_tests.robot
) ELSE IF "%1"=="home" (
    echo Running HOME tests...
    robot --outputdir %RESULTS_DIR% tests/home_tests.robot
) ELSE IF "%1"=="signup" (
    echo Running SIGNUP tests...
    robot --outputdir %RESULTS_DIR% tests/signup_tests.robot
) ELSE IF "%1"=="responsive" (
    echo Running RESPONSIVE tests...
    robot --outputdir %RESULTS_DIR% tests/ui_and_responsiveness_tests.robot
) ELSE IF "%1"=="accessibility" (
    echo Running ACCESSIBILITY tests...
    robot --outputdir %RESULTS_DIR% tests/accessibility_tests.robot
) ELSE IF "%1"=="negative" (
    echo Running NEGATIVE tests...
    robot --outputdir %RESULTS_DIR% --include negative tests/
) ELSE IF "%1"=="security" (
    echo Running SECURITY tests...
    robot --outputdir %RESULTS_DIR% --include security tests/
) ELSE IF "%1"=="boundary" (
    echo Running BOUNDARY tests...
    robot --outputdir %RESULTS_DIR% --include boundary tests/
) ELSE IF "%1"=="ui" (
    echo Running UI tests...
    robot --outputdir %RESULTS_DIR% --include ui tests/
) ELSE IF "%1"=="validation" (
    echo Running VALIDATION tests...
    robot --outputdir %RESULTS_DIR% --include validation tests/
) ELSE IF "%1"=="navigation" (
    echo Running NAVIGATION tests...
    robot --outputdir %RESULTS_DIR% --include navigation tests/
) ELSE IF "%1"=="functional" (
    echo Running FUNCTIONAL tests...
    robot --outputdir %RESULTS_DIR% --include functional tests/
) ELSE (
    echo Running tests with tag: %1
    robot --outputdir %RESULTS_DIR% --include %1 tests/
)

echo.
echo Results saved to %RESULTS_DIR%/
echo Open %RESULTS_DIR%/report.html to view the report.
