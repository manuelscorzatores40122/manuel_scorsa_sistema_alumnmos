'use client'
import { useState } from 'react'

const sel:React.CSSProperties={padding:'9px 11px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'9px',color:'var(--t2)',fontSize:'13px',fontFamily:'inherit',outline:'none',cursor:'pointer',minWidth:'148px'}
const lbl:React.CSSProperties={fontSize:'11px',color:'var(--t3)',display:'block',marginBottom:'5px',textTransform:'uppercase',letterSpacing:'.4px'}

const GRADOS_PRIM=['1°','2°','3°','4°','5°','6°']
const GRADOS_SEC=['1°','2°','3°','4°','5°']

export default function ReportesPage(){
  const [f,setF]=useState({nivel:'',grado:'',seccion:'',estado:'activo',anio:String(new Date().getFullYear())})
  const [carg,setCarg]=useState<string|null>(null)

  function upd(k:string,v:string){
    setF(p=>({...p,[k]:v,...(k==='nivel'?{grado:''}:{})}))
  }

  async function descargar(tipo:'excel'|'pdf'){
    setCarg(tipo)
    try{
      const p=new URLSearchParams()
      Object.entries(f).forEach(([k,v])=>{if(v)p.set(k,v)})
      const r=await fetch(`/api/reportes/${tipo}?${p}`)
      if(!r.ok)throw new Error()
      const blob=await r.blob()
      const url=URL.createObjectURL(blob)
      const a=document.createElement('a')
      a.href=url
      a.download=`estudiantes_${f.anio}${f.nivel?'_'+f.nivel:''}${f.grado?'_'+f.grado:''}.${tipo==='excel'?'xlsx':'pdf'}`
      a.click();URL.revokeObjectURL(url)
    }catch{alert(`Error al generar ${tipo.toUpperCase()}`)}
    finally{setCarg(null)}
  }

  const gradoOpts=f.nivel==='Secundaria'?GRADOS_SEC:f.nivel==='Primaria'?GRADOS_PRIM:[...GRADOS_PRIM,...GRADOS_SEC]

  return(
    <div style={{maxWidth:'800px'}}>
      <style>{`@keyframes spin{to{transform:rotate(360deg)}}`}</style>
      <div style={{marginBottom:'26px'}}>
        <h1 style={{fontSize:'20px',fontWeight:600,color:'var(--t1)'}}>Reportes</h1>
        <p style={{fontSize:'13px',color:'var(--t3)',marginTop:'4px'}}>Exporta listas filtradas por nivel, grado y sección</p>
      </div>

      {/* Filtros */}
      <div style={{background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'14px',padding:'20px',marginBottom:'22px'}}>
        <h2 style={{fontSize:'12px',fontWeight:600,color:'var(--t3)',textTransform:'uppercase',letterSpacing:'.8px',marginBottom:'16px'}}>Filtros del reporte</h2>
        <div style={{display:'flex',flexWrap:'wrap',gap:'14px',alignItems:'flex-end'}}>
          {([['anio','Año'],['nivel','Nivel'],['grado','Grado'],['seccion','Sección'],['estado','Estado']] as [string,string][]).map(([k,l])=>(
            <div key={k}>
              <label style={lbl}>{l}</label>
              <select style={sel} value={(f as Record<string,string>)[k]} onChange={e=>upd(k,e.target.value)}>
                {k==='anio'&&[2024,2025,2026].map(a=><option key={a} value={a}>{a}</option>)}
                {k==='nivel'&&<><option value="">Primaria y Secundaria</option><option value="Primaria">Primaria</option><option value="Secundaria">Secundaria</option></>}
                {k==='grado'&&<><option value="">Todos los grados</option>{gradoOpts.map(g=><option key={g} value={g}>{g} grado</option>)}</>}
                {k==='seccion'&&<><option value="">Todas</option>{['A','B','C'].map(s=><option key={s} value={s}>Sección {s}</option>)}</>}
                {k==='estado'&&<><option value="">Todos</option><option value="activo">Activos</option><option value="retirado">Retirados</option><option value="egresado">Egresados</option></>}
              </select>
            </div>
          ))}
        </div>
        <div style={{marginTop:'14px',padding:'10px 14px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'8px',fontSize:'12.5px',color:'var(--t3)'}}>
          Reporte: <strong style={{color:'var(--t2)'}}>{f.anio}</strong>
          {f.nivel&&<> · Nivel: <strong style={{color:'var(--t2)'}}>{f.nivel}</strong></>}
          {f.grado&&<> · Grado: <strong style={{color:'var(--t2)'}}>{f.grado}</strong></>}
          {f.seccion&&<> · Sección: <strong style={{color:'var(--t2)'}}>{f.seccion}</strong></>}
          {f.estado&&<> · Estado: <strong style={{color:'var(--t2)'}}>{f.estado}</strong></>}
        </div>
      </div>

      {/* Exportar */}
      <h2 style={{fontSize:'12px',fontWeight:600,color:'var(--t3)',textTransform:'uppercase',letterSpacing:'.8px',marginBottom:'12px'}}>Formato de exportación</h2>
      <div style={{display:'grid',gridTemplateColumns:'repeat(auto-fit,minmax(280px,1fr))',gap:'12px',marginBottom:'22px'}}>
        {([
          {tipo:'excel' as const,titulo:'Exportar a Excel (.xlsx)',desc:'Lista completa con todos los datos. Ideal para análisis.',color:'#22c55e'},
          {tipo:'pdf' as const,titulo:'Exportar a PDF',desc:'Lista imprimible ordenada por nivel, grado y apellido.',color:'#ef4444'},
        ]).map(({tipo,titulo,desc,color})=>(
          <button key={tipo} onClick={()=>descargar(tipo)} disabled={!!carg} style={{display:'flex',alignItems:'flex-start',gap:'14px',padding:'18px',background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'14px',cursor:carg?'not-allowed':'pointer',opacity:carg?.6:1,textAlign:'left',width:'100%',fontFamily:'inherit',transition:'border-color .15s'}}>
            <div style={{width:'42px',height:'42px',minWidth:'42px',borderRadius:'11px',background:color+'15',border:`1px solid ${color}25`,display:'flex',alignItems:'center',justifyContent:'center',color}}>
              {carg===tipo?<div style={{width:'18px',height:'18px',border:`2px solid ${color}40`,borderTopColor:color,borderRadius:'50%',animation:'spin .8s linear infinite'}}/>
              :tipo==='excel'
                ?<svg width="20" height="20" viewBox="0 0 20 20" fill="none"><rect x="2" y="2" width="16" height="16" rx="3" stroke="currentColor" strokeWidth="1.4"/><path d="M6 7l4 6M10 7L6 13M13 7v6M11 13h4" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/></svg>
                :<svg width="20" height="20" viewBox="0 0 20 20" fill="none"><rect x="3" y="2" width="14" height="16" rx="2" stroke="currentColor" strokeWidth="1.4"/><path d="M7 7h6M7 10h6M7 13h4" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/></svg>
              }
            </div>
            <div>
              <div style={{fontSize:'14px',fontWeight:500,color:'var(--t1)',marginBottom:'4px'}}>{carg===tipo?'Generando...':titulo}</div>
              <div style={{fontSize:'12.5px',color:'var(--t3)',lineHeight:1.5}}>{desc}</div>
            </div>
          </button>
        ))}
      </div>

      <div style={{padding:'14px 18px',background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'12px',fontSize:'13px',color:'var(--t3)',lineHeight:1.7}}>
        <strong style={{color:'var(--t2)',fontWeight:500}}>Nota:</strong> El Excel incluye columna de nivel (Primaria/Secundaria) para diferenciar grados con el mismo nombre. El PDF agrupa por nivel, luego por grado y sección.
      </div>
    </div>
  )
}
