const http = require('http');
const { Pool } = require('pg');
const pool = new Pool({
  host: process.env.DB_HOST, port: process.env.DB_PORT || 5432,
  user: process.env.DB_USER, password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});
pool.query('CREATE TABLE IF NOT EXISTS visits (id SERIAL PRIMARY KEY, at TIMESTAMPTZ DEFAULT now())').catch(console.error);
http.createServer(async (req, res) => {
  try {
    await pool.query('INSERT INTO visits DEFAULT VALUES');
    const r = await pool.query('SELECT count(*) FROM visits');
    res.end(`Visits (v2): ${r.rows[0].count}\n`);
  } catch (e) { res.statusCode = 500; res.end(e.message + '\n'); }
}).listen(3000);