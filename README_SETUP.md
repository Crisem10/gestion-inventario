# Gestion Inventario - Full Stack

Aplicación de gestión de inventario separada en frontend (Next.js) y backend (Express).

## Estructura del Proyecto

```
gestion-inventario/
├── frontend/           # Next.js + React (puerto 3000)
├── backend/            # Express + Node.js (puerto 4000)
├── scripts/            # Scripts de base de datos
├── .env.example        # Variables de entorno (ejemplo)
└── package.json        # Scripts root para ejecutar ambos
```

## Requisitos

- **Node.js** ≥ 18
- **pnpm** (o npm)
- **PostgreSQL** ≥ 12 (ejecutándose localmente)

## Configuración Inicial

### 1. Instalar dependencias

```bash
# Frontend
cd frontend
pnpm install

# Backend
cd ../backend
pnpm install
```

### 2. Configurar variables de entorno

**Frontend** (`frontend/.env.local`):
```env
NEXT_PUBLIC_API_URL=http://localhost:4000
```

**Backend** (`backend/.env` o usar valores por defecto):
```env
PORT=4000
POSTGRES_USER=inventory_user
POSTGRES_PASSWORD=inventory_pass
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_DB=inventory_db
```

### 3. Inicializar base de datos (PostgreSQL)

Asegúrate de que PostgreSQL está ejecutándose, luego:

```bash
psql -h localhost -U postgres -d postgres -f scripts/init-db.sql
```

## Ejecución

### Opción 1: Ejecutar ambos servicios simultáneamente (desde la raíz)

```bash
pnpm dev
```

Esto requiere `concurrently` instalado en la raíz.

### Opción 2: Ejecutar servicios por separado

**Terminal 1 - Backend:**
```bash
cd backend
pnpm dev
# Escucha en http://localhost:4000
```

**Terminal 2 - Frontend:**
```bash
cd frontend
pnpm dev
# Acceso en http://localhost:3000
```

## Scripts Disponibles

### Raíz
- `pnpm dev` - Ejecuta frontend y backend simultáneamente
- `pnpm backend` - Solo backend (puerto 4000)
- `pnpm frontend` - Solo frontend (puerto 3000)
- `pnpm build` - Construir frontend para producción

### Frontend
- `pnpm dev` - Desarrollador (Turbopack)
- `pnpm build` - Build producción
- `pnpm start` - Ejecutar build producción
- `pnpm lint` - Validar código

### Backend
- `pnpm dev` - Modo desarrollo (con nodemon)
- `pnpm start` - Producción

## Endpoints de API

Base URL: `http://localhost:4000/api`

### Productos
- `GET /api/products` - Listar todos
- `POST /api/products` - Crear
- `GET /api/products/:id` - Obtener por ID
- `PUT /api/products/:id` - Actualizar
- `DELETE /api/products/:id` - Eliminar

### Categorías
- `GET /api/categories` - Listar todas
- `POST /api/categories` - Crear
- `PUT /api/categories/:id` - Actualizar
- `DELETE /api/categories/:id` - Eliminar

### Proveedores
- `GET /api/suppliers` - Listar todos
- `POST /api/suppliers` - Crear
- `PUT /api/suppliers/:id` - Actualizar
- `DELETE /api/suppliers/:id` - Eliminar

### Estadísticas
- `GET /api/stats` - Obtener dashboard stats

## Troubleshooting

### El frontend no encuentra el backend
- Asegúrate que `NEXT_PUBLIC_API_URL` esté configurado correctamente
- Verifica que el backend esté corriendo en puerto 4000
- Comprueba que CORS está habilitado en el backend

### Error de conexión a PostgreSQL
- Verifica que PostgreSQL está ejecutándose
- Comprueba credenciales en `.env`
- Asegúrate que la base de datos `inventory_db` existe

## Desarrollo

Ambos servidores soportan hot-reload:
- **Frontend**: Turbopack (Next.js 16)
- **Backend**: Nodemon

Los cambios se reflejan automáticamente sin necesidad de reiniciar.
