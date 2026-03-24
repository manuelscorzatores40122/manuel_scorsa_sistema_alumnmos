'use client'
import { useState, useEffect, useCallback } from 'react'
import Link from 'next/link'

interface E { id:number;dni:string;apellido_paterno:string;apellido_materno:string;nombres:string;sexo:'M'|'F';edad:number;celular:string;estado:string;nivel:string;grado:string|null;seccion:string|null;foto_url:string|null }
const EC:Record<string,string> = {activo:'#22c55e',retirado:'#ef4444',trasladado:'#f59e0b',egresado:'#3b82f6',suspendido:'#a855f7'}
const sel:React.CSSProperties = {padding:'8px 11px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'9px',color:'var(--t2)',fontSize:'13px',fontFamily:'inherit',outline:'none',cursor:'pointer'}

export default function EstudiantesPage() {
  const [lista,setLista]=useState<E[]>([])
  const [carg,setCarg]=useState(true)
  const [q,setQ]=useState('')
  const [nivel,setNivel]=useState('')
  const [grado,setGrado]=useState('')
  const [seccion,setSeccion]=useState('')
  const [estado,setEstado]=useState('')
  const [sexo,setSexo]=useState('')
  const [pag,setPag]=useState(1)
  const [total,setTotal]=useState(0)
  const [del,setDel]=useState<number|null>(null)
  const POR=20

  const cargar=useCallback(async()=>{
    setCarg(true)
    const p=new URLSearchParams()
    if(q)p.set('q',q);if(nivel)p.set('nivel',nivel);if(grado)p.set('grado',grado)
    if(seccion)p.set('seccion',seccion);if(estado)p.set('estado',estado);if(sexo)p.set('sexo',sexo)
    p.set('pagina',String(pag));p.set('limite',String(POR))
    try{const r=await fetch(`/api/estudiantes?${p}`);const d=await r.json();setLista(d.estudiantes??[]);setTotal(d.total??0)}
    catch{setLista([])}finally{setCarg(false)}
  },[q,nivel,grado,seccion,estado,sexo,pag])

  useEffect(()=>{const t=setTimeout(cargar,280);return()=>clearTimeout(t)},[cargar])

  async function eliminar(id:number,nom:string){
    if(!confirm(`¿Eliminar a ${nom}?`))return
    setDel(id);await fetch(`/api/estudiantes/${id}`,{method:'DELETE'});setDel(null);cargar()
  }

  const totalPags=Math.ceil(total/POR)
  const hayFiltros=nivel||grado||seccion||estado||sexo

  const th:React.CSSProperties={padding:'10px 16px',textAlign:'left',fontSize:'10.5px',fontWeight:600,color:'var(--t3)',textTransform:'uppercase',letterSpacing:'.6px',whiteSpace:'nowrap'}
  const td:React.CSSProperties={padding:'11px 16px',verticalAlign:'middle'}
  const ab:React.CSSProperties={display:'flex',alignItems:'center',justifyContent:'center',width:'28px',height:'28px',borderRadius:'7px',background:'var(--surface)',border:'1px solid var(--b1)',color:'var(--t2)',textDecoration:'none',cursor:'pointer'}

  const GRADOS_PRIM=['1°','2°','3°','4°','5°','6°']
  const GRADOS_SEC =['1°','2°','3°','4°','5°']
  const gradoOpts = nivel==='Secundaria' ? GRADOS_SEC : nivel==='Primaria' ? GRADOS_PRIM : [...GRADOS_PRIM,...GRADOS_SEC]

  return (
    <div style={{display:'flex',flexDirection:'column',gap:'18px'}}>
      <style>{`tbody tr{transition:background .1s} tbody tr:hover{background:var(--hover)!important} @keyframes spin{to{transform:rotate(360deg)}}`}</style>

      {/* Header */}
      <div style={{display:'flex',justifyContent:'space-between',alignItems:'flex-start',flexWrap:'wrap',gap:'12px'}}>
        <div>
          <h1 style={{fontSize:'20px',fontWeight:600,color:'var(--t1)'}}>Estudiantes</h1>
          <p style={{fontSize:'13px',color:'var(--t3)',marginTop:'3px'}}>{carg?'Cargando...':`${total} alumno${total!==1?'s':''} encontrado${total!==1?'s':''}`}</p>
        </div>
        <div style={{display:'flex',gap:'8px'}}>
          <Link href="/dashboard/reportes" style={{display:'inline-flex',alignItems:'center',gap:'6px',padding:'9px 14px',background:'var(--card)',border:'1px solid var(--b1)',color:'var(--t2)',borderRadius:'9px',textDecoration:'none',fontSize:'13px',fontWeight:500}}>
            <svg width="14" height="14" viewBox="0 0 14 14" fill="none"><path d="M7 2v7M4 6l3 3 3-3M2 11h10" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round"/></svg>Exportar
          </Link>
          <Link href="/dashboard/estudiantes/nuevo" style={{display:'inline-flex',alignItems:'center',gap:'6px',padding:'9px 16px',background:'var(--accent)',color:'#0f1623',borderRadius:'9px',textDecoration:'none',fontSize:'13px',fontWeight:600}}>
            <svg width="14" height="14" viewBox="0 0 14 14" fill="none"><path d="M7 2v10M2 7h10" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round"/></svg>Nuevo estudiante
          </Link>
        </div>
      </div>

      {/* Filtros */}
      <div style={{background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'13px',padding:'13px 15px',display:'flex',flexWrap:'wrap',gap:'9px',alignItems:'center'}}>
        <div style={{position:'relative',flex:'1',minWidth:'200px'}}>
          <span style={{position:'absolute',left:'10px',top:'50%',transform:'translateY(-50%)',color:'var(--t3)',pointerEvents:'none'}}>
            <svg width="14" height="14" viewBox="0 0 14 14" fill="none"><circle cx="6" cy="6" r="4" stroke="currentColor" strokeWidth="1.3"/><path d="M11 11l-2-2" stroke="currentColor" strokeWidth="1.3" strokeLinecap="round"/></svg>
          </span>
          <input value={q} onChange={e=>{setQ(e.target.value);setPag(1)}} placeholder="Buscar nombre, DNI, apellido..."
            style={{width:'100%',padding:'8px 30px 8px 32px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'9px',color:'var(--t1)',fontSize:'13px',fontFamily:'inherit',outline:'none'}}/>
          {q&&<button onClick={()=>setQ('')} style={{position:'absolute',right:'8px',top:'50%',transform:'translateY(-50%)',background:'none',border:'none',cursor:'pointer',color:'var(--t3)',fontSize:'17px'}}>×</button>}
        </div>

        {/* Nivel primero — cambia opciones de grado */}
        <select style={sel} value={nivel} onChange={e=>{setNivel(e.target.value);setGrado('');setPag(1)}}>
          <option value="">Todos los niveles</option>
          <option value="Primaria">Primaria</option>
          <option value="Secundaria">Secundaria</option>
        </select>
        <select style={sel} value={grado} onChange={e=>{setGrado(e.target.value);setPag(1)}}>
          <option value="">Todos los grados</option>
          {gradoOpts.map(g=><option key={g} value={g}>{g} grado</option>)}
        </select>
        <select style={sel} value={seccion} onChange={e=>{setSeccion(e.target.value);setPag(1)}}>
          <option value="">Todas las secciones</option>
          {['A','B','C'].map(s=><option key={s} value={s}>Sección {s}</option>)}
        </select>
        <select style={sel} value={estado} onChange={e=>{setEstado(e.target.value);setPag(1)}}>
          <option value="">Todos los estados</option>
          <option value="activo">Activo</option>
          <option value="retirado">Retirado</option>
          <option value="trasladado">Trasladado</option>
          <option value="egresado">Egresado</option>
        </select>
        <select style={sel} value={sexo} onChange={e=>{setSexo(e.target.value);setPag(1)}}>
          <option value="">Ambos sexos</option>
          <option value="M">Varones</option>
          <option value="F">Mujeres</option>
        </select>
        {hayFiltros&&<button onClick={()=>{setNivel('');setGrado('');setSeccion('');setEstado('');setSexo('');setPag(1)}} style={{padding:'7px 11px',background:'none',border:'1px solid var(--b1)',borderRadius:'8px',color:'var(--t3)',fontSize:'12px',cursor:'pointer',fontFamily:'inherit'}}>✕ Limpiar</button>}
      </div>

      {/* Tabla */}
      <div style={{background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'13px',overflow:'hidden'}}>
        {carg?(
          <div style={{padding:'48px',display:'flex',justifyContent:'center',alignItems:'center',gap:'12px'}}>
            <div style={{width:'20px',height:'20px',border:'2px solid var(--b1)',borderTopColor:'var(--accent)',borderRadius:'50%',animation:'spin .8s linear infinite'}}/>
            <span style={{fontSize:'13px',color:'var(--t3)'}}>Buscando estudiantes...</span>
          </div>
        ):lista.length===0?(
          <div style={{padding:'56px 20px',textAlign:'center'}}>
            <div style={{fontSize:'32px',marginBottom:'12px'}}>👤</div>
            <div style={{fontSize:'15px',fontWeight:500,color:'var(--t1)',marginBottom:'6px'}}>Sin resultados</div>
            <div style={{fontSize:'13px',color:'var(--t3)',marginBottom:'20px'}}>{q||hayFiltros?'Prueba con otros filtros':'Aún no hay estudiantes registrados'}</div>
            <Link href="/dashboard/estudiantes/nuevo" style={{display:'inline-flex',alignItems:'center',gap:'6px',padding:'9px 16px',background:'var(--accent)',color:'#0f1623',borderRadius:'9px',textDecoration:'none',fontSize:'13px',fontWeight:600}}>Registrar primer estudiante</Link>
          </div>
        ):(
          <>
            <div style={{overflowX:'auto'}}>
              <table style={{width:'100%',borderCollapse:'collapse'}}>
                <thead><tr style={{borderBottom:'1px solid var(--b1)'}}>
                  <th style={th}>Estudiante</th><th style={th}>DNI</th><th style={th}>Nivel</th>
                  <th style={th}>Grado / Secc.</th><th style={th}>Estado</th><th style={th}>Celular</th><th style={th}>Acciones</th>
                </tr></thead>
                <tbody>
                  {lista.map((e,i)=>(
                    <tr key={e.id} style={{borderBottom:i<lista.length-1?'1px solid var(--b1)':'none'}}>
                      <td style={td}>
                        <div style={{display:'flex',alignItems:'center',gap:'10px'}}>
                          <div style={{width:'34px',height:'34px',minWidth:'34px',borderRadius:'50%',display:'flex',alignItems:'center',justifyContent:'center',fontSize:'13px',fontWeight:600,overflow:'hidden',background:e.sexo==='M'?'rgba(59,130,246,.1)':'rgba(236,72,153,.1)',border:`1px solid ${e.sexo==='M'?'rgba(59,130,246,.2)':'rgba(236,72,153,.2)'}`,color:e.sexo==='M'?'#3b82f6':'#ec4899'}}>
                            {e.foto_url?<img src={e.foto_url} style={{width:'100%',height:'100%',objectFit:'cover'}} alt=""/>:e.apellido_paterno[0]}
                          </div>
                          <div>
                            <div style={{fontSize:'13.5px',fontWeight:500,color:'var(--t1)'}}>{e.apellido_paterno} {e.apellido_materno}</div>
                            <div style={{fontSize:'11.5px',color:'var(--t3)'}}>{e.nombres} · {e.edad} años</div>
                          </div>
                        </div>
                      </td>
                      <td style={td}><span style={{fontFamily:'monospace',fontSize:'13px',color:'var(--t2)'}}>{e.dni}</span></td>
                      <td style={td}>
                        <span style={{display:'inline-flex',padding:'2px 8px',borderRadius:'5px',fontSize:'11px',fontWeight:500,background:e.nivel==='Primaria'?'rgba(59,130,246,.1)':'rgba(240,165,0,.1)',border:`1px solid ${e.nivel==='Primaria'?'rgba(59,130,246,.2)':'rgba(240,165,0,.2)'}`,color:e.nivel==='Primaria'?'#3b82f6':'#f0a500'}}>
                          {e.nivel||'—'}
                        </span>
                      </td>
                      <td style={td}>
                        {e.grado?<span style={{display:'inline-flex',padding:'3px 9px',borderRadius:'6px',fontSize:'11.5px',fontWeight:500,background:'rgba(139,156,200,.1)',border:'1px solid rgba(139,156,200,.15)',color:'var(--t2)'}}>{e.grado} — {e.seccion}</span>
                        :<span style={{fontSize:'12px',color:'var(--t3)'}}>Sin matrícula</span>}
                      </td>
                      <td style={td}>
                        <span style={{display:'inline-flex',alignItems:'center',gap:'5px',padding:'3px 8px',borderRadius:'20px',fontSize:'11px',fontWeight:500,background:(EC[e.estado]||'#8b9cc8')+'15',color:EC[e.estado]||'#8b9cc8',border:`1px solid ${EC[e.estado]||'#8b9cc8'}30`,textTransform:'capitalize'}}>
                          <span style={{width:'5px',height:'5px',borderRadius:'50%',background:EC[e.estado]||'#8b9cc8'}}/>{e.estado}
                        </span>
                      </td>
                      <td style={td}><span style={{fontSize:'12.5px',color:'var(--t2)'}}>{e.celular||'—'}</span></td>
                      <td style={td}>
                        <div style={{display:'flex',gap:'5px'}}>
                          <Link href={`/dashboard/estudiantes/${e.id}`} style={ab} title="Ver ficha">
                            <svg width="13" height="13" viewBox="0 0 13 13" fill="none"><circle cx="6.5" cy="6.5" r="4.5" stroke="currentColor" strokeWidth="1.3"/><circle cx="6.5" cy="6.5" r="2" fill="currentColor"/></svg>
                          </Link>
                          <Link href={`/dashboard/estudiantes/${e.id}/editar`} style={ab} title="Editar">
                            <svg width="13" height="13" viewBox="0 0 13 13" fill="none"><path d="M8.5 1.5l3 3L4 12H1v-3L8.5 1.5z" stroke="currentColor" strokeWidth="1.3" strokeLinejoin="round"/></svg>
                          </Link>
                          <button onClick={()=>eliminar(e.id,`${e.apellido_paterno} ${e.nombres}`)} disabled={del===e.id} style={{...ab,border:'none'}} title="Eliminar">
                            {del===e.id?<div style={{width:'11px',height:'11px',border:'1.5px solid #ef4444',borderTopColor:'transparent',borderRadius:'50%',animation:'spin .7s linear infinite'}}/>
                            :<svg width="13" height="13" viewBox="0 0 13 13" fill="none"><path d="M2 3.5h9M4.5 3.5v-1h4v1M5.5 6v4M7.5 6v4M2.5 3.5l.6 7a1 1 0 001 .9h4.8a1 1 0 001-.9l.6-7" stroke="#ef4444" strokeWidth="1.3" strokeLinecap="round"/></svg>}
                          </button>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
            {totalPags>1&&(
              <div style={{display:'flex',justifyContent:'space-between',alignItems:'center',padding:'11px 18px',borderTop:'1px solid var(--b1)'}}>
                <span style={{fontSize:'12px',color:'var(--t3)'}}>Página {pag} de {totalPags} · {total} registros</span>
                <div style={{display:'flex',gap:'5px'}}>
                  <button onClick={()=>setPag(p=>p-1)} disabled={pag===1} style={{padding:'6px 11px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'7px',color:'var(--t2)',fontSize:'12px',cursor:'pointer',fontFamily:'inherit',opacity:pag===1?.4:1}}>← Anterior</button>
                  <button onClick={()=>setPag(p=>p+1)} disabled={pag===totalPags} style={{padding:'6px 11px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'7px',color:'var(--t2)',fontSize:'12px',cursor:'pointer',fontFamily:'inherit',opacity:pag===totalPags?.4:1}}>Siguiente →</button>
                </div>
              </div>
            )}
          </>
        )}
      </div>
    </div>
  )
}
