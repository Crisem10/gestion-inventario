-- ===============================
-- Base de datos de Gestión de Inventario
-- Todo en español
-- ===============================

-- =====================================
-- TABLAS
-- =====================================

-- Tabla de categorías
CREATE TABLE IF NOT EXISTS categorias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de proveedores
CREATE TABLE IF NOT EXISTS proveedores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    email VARCHAR(200),
    telefono VARCHAR(50),
    direccion TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de productos
CREATE TABLE IF NOT EXISTS productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    sku VARCHAR(100) UNIQUE NOT NULL,
    descripcion TEXT,
    categoria_id INTEGER REFERENCES categorias(id) ON DELETE SET NULL,
    proveedor_id INTEGER REFERENCES proveedores(id) ON DELETE SET NULL,
    precio DECIMAL(10,2) NOT NULL DEFAULT 0,
    inventario INTEGER NOT NULL DEFAULT 0,
    inventario_minimo INTEGER DEFAULT 10,
    url_imagen TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de movimientos de inventario
CREATE TABLE IF NOT EXISTS movimientos_stock (
    id SERIAL PRIMARY KEY,
    producto_id INTEGER REFERENCES productos(id) ON DELETE CASCADE,
    cantidad INTEGER NOT NULL,
    tipo_movimiento VARCHAR(20) NOT NULL CHECK (tipo_movimiento IN ('ENTRADA', 'SALIDA', 'AJUSTE')),
    notas TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================
-- ÍNDICES PARA RENDIMIENTO
-- =====================================
CREATE INDEX idx_productos_categoria ON productos(categoria_id);
CREATE INDEX idx_productos_proveedor ON productos(proveedor_id);
CREATE INDEX idx_productos_sku ON productos(sku);
CREATE INDEX idx_movimientos_producto ON movimientos_stock(producto_id);
CREATE INDEX idx_movimientos_creado ON movimientos_stock(creado_en);

-- =====================================
-- DATOS DE EJEMPLO
-- =====================================

-- Categorías
INSERT INTO categorias (nombre, descripcion) VALUES
('Electrónica', 'Dispositivos y componentes electrónicos'),
('Muebles', 'Muebles de oficina y hogar'),
('Papelería', 'Suministros y material de oficina'),
('Herramientas', 'Herramientas y ferretería'),
('Ropa', 'Ropa y accesorios');

-- Proveedores
INSERT INTO proveedores (nombre, email, telefono, direccion) VALUES
('Suministros Tech', 'contacto@techsupplies.com', '+1-555-0101', '123 Calle Tech, Silicon Valley, CA'),
('Mundo Muebles', 'ventas@mundo-muebles.com', '+1-555-0102', '456 Av. Diseño, Nueva York, NY'),
('Esenciales Oficina', 'info@oficinaesenciales.com', '+1-555-0103', '789 Calle Suministro, Chicago, IL');

-- Productos
INSERT INTO productos (nombre, sku, descripcion, categoria_id, proveedor_id, precio, inventario, inventario_minimo) VALUES
('Mouse Inalámbrico', 'ELEC-001', 'Mouse ergonómico inalámbrico con receptor USB', 1, 1, 29.99, 45, 10),
('Silla de Oficina', 'MUEB-001', 'Silla de oficina ergonómica con soporte lumbar', 2, 2, 299.99, 12, 5),
('Cuaderno A4', 'PAPE-001', 'Cuaderno premium A4, 200 páginas', 3, 3, 5.99, 150, 30),
('Monitor LED 24"', 'ELEC-002', 'Monitor LED de 24 pulgadas Full HD', 1, 1, 199.99, 8, 5),
('Escritorio Ajustable', 'MUEB-002', 'Escritorio de altura ajustable', 2, 2, 499.99, 6, 3),
('Set de Bolígrafos', 'PAPE-002', 'Set de bolígrafos premium, 10 piezas', 3, 3, 12.99, 200, 50);

-- Movimientos de inventario
INSERT INTO movimientos_stock (producto_id, cantidad, tipo_movimiento, notas) VALUES
(1, 50, 'ENTRADA', 'Stock inicial'),
(2, 15, 'ENTRADA', 'Stock inicial'),
(3, 200, 'ENTRADA', 'Stock inicial'),
(1, -5, 'SALIDA', 'Venta a cliente'),
(3, -50, 'SALIDA', 'Pedido al por mayor'),
(2, -3, 'SALIDA', 'Instalación en oficina');

-- =====================================
-- FUNCIONES Y TRIGGERS PARA updated_at
-- =====================================

CREATE OR REPLACE FUNCTION actualizar_actualizado_en()
RETURNS TRIGGER AS $$
BEGIN
    NEW.actualizado_en = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER actualizar_categorias BEFORE UPDATE ON categorias
FOR EACH ROW EXECUTE FUNCTION actualizar_actualizado_en();

CREATE TRIGGER actualizar_proveedores BEFORE UPDATE ON proveedores
FOR EACH ROW EXECUTE FUNCTION actualizar_actualizado_en();

CREATE TRIGGER actualizar_productos BEFORE UPDATE ON productos
FOR EACH ROW EXECUTE FUNCTION actualizar_actualizado_en();
