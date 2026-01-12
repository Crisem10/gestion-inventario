const fs = require('fs');
const path = require('path');
const { Client } = require('pg');

const connectionString = process.argv[2];

if (!connectionString) {
  console.error('\n❌ Error: Debes proporcionar la URL de conexión como argumento.');
  console.error('Uso: node scripts/init-remote-db.js "postgres://user:pass@host:port/dbname"\n');
  process.exit(1);
}

const sqlPath = path.join(__dirname, '../../scripts/init-db.sql');

if (!fs.existsSync(sqlPath)) {
  console.error(`\n❌ Error: No se encontró el archivo SQL en: ${sqlPath}\n`);
  process.exit(1);
}

const sqlContent = fs.readFileSync(sqlPath, 'utf8');

console.log('🔌 Conectando a la base de datos remota...');

const client = new Client({
  connectionString,
  ssl: {
    rejectUnauthorized: false // Necesario para Render (y muchas bases de datos en la nube)
  }
});

(async () => {
  try {
    await client.connect();
    console.log('✅ Conexión exitosa.');
    
    console.log('🚀 Ejecutando script de inicialización (creando tablas)...');
    await client.query(sqlContent);
    
    console.log('✨ ¡Base de datos inicializada correctamente!');
    console.log('   Se han creado las tablas y los datos de ejemplo.');
  } catch (err) {
    console.error('❌ Error al inicializar la base de datos:', err);
  } finally {
    await client.end();
  }
})();
