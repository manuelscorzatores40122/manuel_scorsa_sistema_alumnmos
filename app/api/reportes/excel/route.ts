import { NextRequest, NextResponse } from 'next/server'
import { sql } from '@/lib/bd'
import * as XLSX from 'xlsx'

export async function GET(req: NextRequest) {
  const p=new URL(req.url).searchParams
  const nivel=p.get('nivel')||'',grado=p.get('grado')||'',seccion=p.get('seccion')||''
  const estado=p.get('estado')||'',anio=parseInt(p.get('anio')||String(new Date().getFullYear()))
  try {
    const conds=[`m.anio=${anio}`];const vals:unknown[]=[];let idx=1
    if(estado){conds.push(`e.estado=$${idx++}`);vals.push(estado)}
    if(nivel){conds.push(`g.nivel=$${idx++}`);vals.push(nivel)}
    if(grado){conds.push(`g.nombre=$${idx++}`);vals.push(grado)}
    if(seccion){conds.push(`s.nombre=$${idx++}`);vals.push(seccion)}
    const rows=await sql.unsafe(`SELECT e.dni,e.apellido_paterno,e.apellido_materno,e.nombres,CASE WHEN e.sexo='M' THEN 'Masculino' ELSE 'Femenino' END AS sexo,TO_CHAR(e.fecha_nacimiento,'DD/MM/YYYY') AS fecha_nacimiento,DATE_PART('year',AGE(e.fecha_nacimiento))::integer AS edad,e.celular,e.email,e.estado,g.nivel,g.nombre AS grado,s.nombre AS seccion,e.codigo_minedu,e.asegurado,e.tipo_seguro,e.domicilio,a.nombres AS apoderado,a.celular AS cel_apoderado FROM estudiantes e LEFT JOIN matriculas m ON m.estudiante_id=e.id AND m.anio=${anio} LEFT JOIN grados g ON g.id=m.grado_id LEFT JOIN secciones s ON s.id=m.seccion_id LEFT JOIN apoderados a ON a.estudiante_id=e.id AND a.es_principal=true WHERE ${conds.join(' AND ')} ORDER BY g.nivel DESC,g.orden,s.nombre,e.apellido_paterno`,vals)
    const datos=rows.map((e:Record<string,unknown>,i:number)=>({'N°':i+1,'DNI':e.dni,'Apellido Paterno':e.apellido_paterno,'Apellido Materno':e.apellido_materno,'Nombres':e.nombres,'Sexo':e.sexo,'F.Nacimiento':e.fecha_nacimiento,'Edad':e.edad,'Nivel':e.nivel||'','Grado':e.grado||'','Sección':e.seccion||'','Estado':e.estado,'Cód. MINEDU':e.codigo_minedu||'','Celular':e.celular||'','Email':e.email||'','Asegurado':e.asegurado?'Sí':'No','Tipo Seguro':e.tipo_seguro||'','Domicilio':e.domicilio||'','Apoderado':e.apoderado||'','Cel. Apoderado':e.cel_apoderado||''}))
    const wb=XLSX.utils.book_new()
    const ws=XLSX.utils.json_to_sheet(datos)
    ws['!cols']=[{wch:4},{wch:10},{wch:16},{wch:16},{wch:22},{wch:10},{wch:12},{wch:5},{wch:10},{wch:8},{wch:7},{wch:10},{wch:16},{wch:12},{wch:24},{wch:8},{wch:10},{wch:28},{wch:22},{wch:14}]
    XLSX.utils.book_append_sheet(wb,ws,`Estudiantes ${anio}`)
    const buf=XLSX.write(wb,{type:'buffer',bookType:'xlsx'})
    return new NextResponse(buf,{headers:{'Content-Type':'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','Content-Disposition':`attachment; filename=estudiantes_${anio}${nivel?'_'+nivel:''}.xlsx`}})
  }catch(e){console.error(e);return NextResponse.json({error:'Error'},{status:500})}
}
