import { NextRequest, NextResponse } from 'next/server'
import { sql } from '@/lib/bd'
export async function PUT(req: NextRequest,{params}:{params:{id:string}}) {
  try{const b=await req.json();await sql`UPDATE apoderados SET tipo=${b.tipo||'madre'},apellido_paterno=${b.apellido_paterno||''},apellido_materno=${b.apellido_materno||null},nombres=${b.nombres},dni=${b.dni||null},celular=${b.celular},email=${b.email||null},ocupacion=${b.ocupacion||null},es_principal=${b.es_principal??false},vive_con_estudiante=${b.vive_con_estudiante??false} WHERE id=${parseInt(params.id)}`;return NextResponse.json({ok:true})}
  catch(e){console.error(e);return NextResponse.json({error:'Error'},{status:500})}
}
export async function DELETE(_req:NextRequest,{params}:{params:{id:string}}) {
  try{await sql`DELETE FROM apoderados WHERE id=${parseInt(params.id)}`;return NextResponse.json({ok:true})}
  catch(e){console.error(e);return NextResponse.json({error:'Error'},{status:500})}
}
