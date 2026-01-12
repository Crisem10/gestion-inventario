# Guía de Despliegue de Base de Datos en Render

En Render, la forma más fácil y segura de tener una base de datos es usar su servicio **Managed PostgreSQL**.

Sigue estos pasos para crear tu base de datos y conectarla a tu backend.

## 1. Crear la Base de Datos en Render

1. Ve a tu [Dashboard de Render](https://dashboard.render.com/).
2. Haz clic en **New +** y selecciona **PostgreSQL**.
3. Llénalo con la siguiente información:
    - **Name:** `inventory-db`
    - **Database:** `inventory_db`
    - **User:** `inventory_user`
    - **Region:** Elige la misma región donde tienes tu Backend.
    - **Instance Type:** "Free".
4. Haz clic en **Create Database**.

## 2. Obtener las URLs de Conexión

Una vez creada, verás dos URLs importantes:

1.  **Internal Database URL:** (Empieza con `postgres://...` y tiene un host interno).
    *   ✅ **Copia esta URL.**

## 3. Configurar tu Backend en Render

1. Ve a tu servicio **Backend** en el Dashboard de Render.
2. Ve a la pestaña **Environment**.
3. Cambia las variables para que apunten a tu nueva base de datos.
    - O simplemente crea una variable `DATABASE_URL` con el valor que copiaste.
    - O actualiza `POSTGRES_HOST`, `POSTGRES_PASSWORD`, etc. con los datos que te da Render.

## 4. Inicializar las Tablas

Para cargar tus tablas en esta nueva base de datos:

1.  Copia la **External Database URL** del dashboard de la base de datos de Render.
2.  En tu terminal local (VS Code), ejecuta este script que te preparé:

    ```bash
    node backend/scripts/init-remote-db.js "PEGA_AQUI_LA_EXTERNAL_URL"
    ```

---
**¡Listo!** Ahora tu Vercel hablará con tu Backend en Render, y tu Backend en Render hablará con tu nueva Base de Datos en Render (Dockerizada).
