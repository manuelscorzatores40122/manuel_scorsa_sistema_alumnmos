import { NextRequest, NextResponse } from 'next/server'
import { sql } from '@/lib/bd'
export async function POST(req: NextRequest) {
  try {
    const b=await req.json()
    if(!b.estudiante_id||!b.nombres||!b.celular) return NextResponse.json({error:'Faltan campos'},{status:400})
    const [r]=await sql`INSERT INTO apoderados (estudiante_id,tipo,apellido_paterno,apellido_materno,nombres,dni,celular,email,ocupacion,es_principal,vive_con_estudiante) VALUES (${b.estudiante_id},${b.tipo||'madre'},${b.apellido_paterno||''},${b.apellido_materno||null},${b.nombres},${b.dni||null},${b.celular},${b.email||null},${b.ocupacion||null},${b.es_principal??false},${b.vive_con_estudiante??false}) RETURNING id`
    return NextResponse.json({id:r.id},{status:201})
  } catch(e){ console.error(e); return NextResponse.json({error:'Error'},{status:500}) }
}
