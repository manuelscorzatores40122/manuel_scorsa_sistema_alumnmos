import { NextRequest, NextResponse } from 'next/server'
import { sql } from '@/lib/bd'
import jsPDF from 'jspdf'
import autoTable from 'jspdf-autotable'

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
    const rows=await sql.unsafe(`SELECT e.dni,e.apellido_paterno,e.apellido_materno,e.nombres,e.sexo,TO_CHAR(e.fecha_nacimiento,'DD/MM/YYYY') AS fecha_nacimiento,e.estado,g.nivel,g.nombre AS grado,s.nombre AS seccion,e.celular FROM estudiantes e LEFT JOIN matriculas m ON m.estudiante_id=e.id AND m.anio=${anio} LEFT JOIN grados g ON g.id=m.grado_id LEFT JOIN secciones s ON s.id=m.seccion_id WHERE ${conds.join(' AND ')} ORDER BY g.nivel DESC,g.orden,s.nombre,e.apellido_paterno`,vals)
    const doc=new jsPDF({orientation:'landscape',unit:'mm',format:'a4'})
    doc.setFontSize(13);doc.setFont('helvetica','bold')
    doc.text('LISTA DE ESTUDIANTES',148.5,14,{align:'center'})
    doc.setFontSize(9);doc.setFont('helvetica','normal')
    doc.text(`Año: ${anio}  |  Nivel: ${nivel||'Todos'}  |  Grado: ${grado||'Todos'}  |  Sección: ${seccion||'Todas'}  |  Estado: ${estado||'Todos'}`,148.5,21,{align:'center'})
    doc.setTextColor(120)
    doc.text(`Generado: ${new Date().toLocaleDateString('es-PE')} ${new Date().toLocaleTimeString('es-PE')}`,148.5,27,{align:'center'})
    doc.setTextColor(0)
    autoTable(doc,{startY:32,head:[['N°','DNI','Apellidos y Nombres','Sexo','F.Nacimiento','Nivel','Grado','Secc.','Estado','Celular']],body:rows.map((e:Record<string,unknown>,i:number)=>[i+1,e.dni,`${e.apellido_paterno} ${e.apellido_materno}, ${e.nombres}`,e.sexo,e.fecha_nacimiento,e.nivel||'—',e.grado||'—',e.seccion||'—',String(e.estado).toUpperCase(),e.celular||'—']),styles:{fontSize:7.5,cellPadding:2.2},headStyles:{fillColor:[240,165,0],textColor:[15,22,35],fontStyle:'bold',halign:'center'},alternateRowStyles:{fillColor:[248,248,248]},columnStyles:{0:{halign:'center',cellWidth:8},1:{halign:'center',cellWidth:20},2:{cellWidth:58},3:{halign:'center',cellWidth:10},4:{halign:'center',cellWidth:22},5:{halign:'center',cellWidth:16},6:{halign:'center',cellWidth:12},7:{halign:'center',cellWidth:10},8:{halign:'center',cellWidth:18},9:{halign:'center',cellWidth:20}},didDrawPage:(d)=>{doc.setFontSize(7.5);doc.setTextColor(140);doc.text(`Página ${d.pageNumber}`,148.5,doc.internal.pageSize.height-5,{align:'center'});doc.text(`Total: ${rows.length} estudiantes`,14,doc.internal.pageSize.height-5);doc.setTextColor(0)}})
    const buf=Buffer.from(doc.output('arraybuffer'))
    return new NextResponse(buf,{headers:{'Content-Type':'application/pdf','Content-Disposition':`attachment; filename=lista_${anio}${nivel?'_'+nivel:''}.pdf`}})
  }catch(e){console.error(e);return NextResponse.json({error:'Error'},{status:500})}
}
