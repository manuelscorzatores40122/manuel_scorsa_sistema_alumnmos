import { neon } from '@neondatabase/serverless'
import bcrypt from 'bcryptjs'
const sql = neon(process.env.DATABASE_URL)
const hash = await bcrypt.hash('cambiar123', 12)
await sql`INSERT INTO usuarios (usuario,password_hash,nombre) VALUES ('secretaria',${hash},'Secretaria General') ON CONFLICT (usuario) DO UPDATE SET password_hash=${hash}`
console.log('Usuario: secretaria | Contraseña: cambiar123')
process.exit(0)
