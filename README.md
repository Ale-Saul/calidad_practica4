# Proyecto de Automatización de Saucedemo

Este proyecto contiene pruebas automatizadas para el sitio web [https://www.saucedemo.com/](https://www.saucedemo.com/), una plataforma de comercio electrónico de demostración.

Las pruebas están escritas en Gherkin (`.feature` files) y automatizadas usando Ruby y Cucumber.

## Tecnologías

*   **Lenguaje de Programación:** Ruby
*   **Framework de Pruebas:** Cucumber (`cucumber-ruby`)
*   **Driver de Navegador:** Selenium WebDriver (a través de Capybara)
*   **Gestor de Dependencias:** Bundler

## Funcionalidades Probadas

La suite de pruebas de automatización cubre las siguientes áreas de la aplicación:

*   **Autenticación:**
    *   Inicio de sesión con usuarios válidos e inválidos.
    *   Cierre de sesión.
*   **Inventario y Productos:**
    *   Visualización de productos.
    *   Filtros y ordenamiento de productos.
    *   Selección de productos.
*   **Carrito de Compras:**
    *   Añadir y eliminar productos del carrito.
*   **Proceso de Compra (Checkout):**
    *   Completar el flujo de compra.
    *   Resumen del pedido.
*   **Navegación:**
    *   Uso de la barra lateral (sidebar).

## Cómo ejecutar las pruebas

Para ejecutar las pruebas, necesitarás tener el entorno de desarrollo Ruby configurado.

### Prerrequisitos

1.  **Instalar Ruby para Windows:**
    *   Descarga y ejecuta el instalador, por ejemplo `rubyinstaller-devkit-3.0.2-1-x64.exe`. Se recomienda usar el **Ruby+Devkit**.
    *   Puedes encontrar los instaladores en [RubyInstaller for Windows](https://rubyinstaller.org/downloads/).
    *   Al finalizar la instalación, en la ventana de terminal que se abre, asegúrate de instalar los **MSYS2 components** (opción 3) si no están presentes.

2.  **Configurar el WebDriver:**
    *   Descarga el WebDriver correspondiente a tu navegador (ej. `chromedriver` para Chrome, `geckodriver` para Firefox).
    *   Descomprime el archivo y copia el ejecutable (`.exe`) en la carpeta `bin` de tu instalación de Ruby (ej. `C:\Ruby30-x64\bin`).

3.  **Instalar Bundler:**
    *   Bundler gestiona las dependencias del proyecto (gemas). Una vez que tengas Ruby, abre una nueva terminal (`cmd` o `PowerShell`) y ejecuta:
        ```bash
        gem install bundler
        ```

### Instalación

1.  Clona este repositorio (si aún no lo has hecho).
2.  Abre una terminal en el directorio raíz del proyecto.
3.  Instala todas las gemas requeridas del `Gemfile` con un solo comando:
    ```bash
    bundle install
    ```
    Este comando leerá el `Gemfile` e instalará `cucumber`, `capybara`, `selenium-webdriver`, `rspec`, y `capybara-screenshot`.

### Ejecución de Pruebas

Una vez configurado, puedes ejecutar la suite completa de pruebas con el siguiente comando:

```bash
bundle exec cucumber
```

Para ejecutar un archivo de feature específico, pásalo como argumento:

```bash
bundle exec cucumber features/login.feature
``` 