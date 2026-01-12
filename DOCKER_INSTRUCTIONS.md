# Instrucciones para la Base de Datos Local con Docker

Estas instrucciones te ayudarán a ejecutar una base de datos PostgreSQL localmente usando Docker, reemplazando la necesidad de conectar a Supabase durante el desarrollo.

## Prerrequisitos

- Tener [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado y corriendo.

## 1. Iniciar la Base de Datos

Ejecuta el siguiente comando en la terminal (en la raíz del proyecto):

```bash
docker-compose up -d postgres
```

Esto iniciará un contenedor llamado `inventory-db` en el puerto `5433` (para evitar conflictos si ya tienes un Postgres local en el 5432).

## 2. Configurar el Backend

Para que tu backend conecte a esta base de datos local, asegúrate de que tu archivo `backend/.env` tenga lo siguiente (especialmente HOST y PORT):

```ini
POSTGRES_USER=... (tu usuario)
POSTGRES_PASSWORD=... (tu password)
POSTGRES_DB=... (tu db)
POSTGRES_HOST=localhost
POSTGRES_PORT=5433
```

## 3. Verificar la Conexión

1.  Reinicia tu servidor backend:
    ```bash
    cd backend
    npm run dev
    ```
2.  Debería decir "Verificación de BD al inicio OK".

## 4. Resetear la Base de Datos (Si cambias claves)

Si cambiaste las claves en el `.env`, borra la base vieja y crea una nueva:

```bash
docker-compose down -v
docker-compose up -d postgres
```
