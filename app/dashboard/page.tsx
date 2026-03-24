'use client'
import { useEffect, useState } from 'react'
import Link from 'next/link'

interface Stats { total_estudiantes:number; varones:number; mujeres:number; activos:number; retirados:number; total_primaria:number; total_secundaria:number; por_grado:{nivel:string;grado:string;seccion:string;total:number}[] }

const anio = new Date().getFullYear()

export default function DashboardPage() {
  const [s, setS] = useState<Stats|null>(null)
  const [carg, setCarg] = useState(true)

  useEffect(()=>{
    fetch('/api/estadisticas').then(r=>r.json()).then(d=>{setS(d);setCarg(false)}).catch(()=>setCarg(false))
  },[])

  const maxG = s?.por_grado?.reduce((m,g)=>Math.max(m,g.total),1)??1
  const COLORES_NIVEL: Record<string,string> = { Primaria:'#3b82f6', Secundaria:'#f0a500' }

  function Card({valor,label,sub,color,icon}:{valor:number|string;label:string;sub?:string;color:string;icon:React.ReactNode}) {
    return (
      <div style={{background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'14px',padding:'20px',display:'flex',flexDirection:'column',gap:'14px',animation:'fadeIn .3s ease'}}>
        <div style={{width:'38px',height:'38px',borderRadius:'10px',background:color+'18',border:`1px solid ${color}28`,display:'flex',alignItems:'center',justifyContent:'center',color}}>{icon}</div>
        <div>
          <div style={{fontSize:'28px',fontWeight:600,color:'var(--t1)',lineHeight:1}}>{carg?'—':valor}</div>
          <div style={{fontSize:'13px',color:'var(--t2)',marginTop:'4px'}}>{label}</div>
          {sub&&<div style={{fontSize:'11.5px',color:'var(--t3)',marginTop:'2px'}}>{sub}</div>}
        </div>
      </div>
    )
  }

  return (
    <div style={{display:'flex',flexDirection:'column',gap:'24px'}}>
      <div style={{display:'flex',justifyContent:'space-between',alignItems:'flex-start',flexWrap:'wrap',gap:'12px'}}>
        <div>
          <h1 style={{fontSize:'21px',fontWeight:600,color:'var(--t1)',marginBottom:'4px'}}>Panel de inicio</h1>
          <p style={{fontSize:'13px',color:'var(--t3)'}}>Año escolar {anio} · Institución Educativa</p>
        </div>
        <Link href="/dashboard/estudiantes/nuevo" style={{display:'inline-flex',alignItems:'center',gap:'8px',padding:'10px 18px',background:'var(--accent)',color:'#0f1623',borderRadius:'10px',textDecoration:'none',fontSize:'13.5px',fontWeight:600}}>
          <svg width="16" height="16" viewBox="0 0 16 16" fill="none"><path d="M8 3v10M3 8h10" stroke="currentColor" strokeWidth="2" strokeLinecap="round"/></svg>
          Nuevo estudiante
        </Link>
      </div>

      {/* Stats principales */}
      <div style={{display:'grid',gridTemplateColumns:'repeat(auto-fit,minmax(170px,1fr))',gap:'14px'}}>
        <Card valor={s?.total_estudiantes??0} label="Total estudiantes" sub={`Año ${anio}`} color="#3b82f6" icon={<svg width="18" height="18" viewBox="0 0 18 18" fill="none"><circle cx="9" cy="6" r="3" stroke="currentColor" strokeWidth="1.4"/><path d="M3 15c0-3.314 2.686-5 6-5s6 1.686 6 5" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/></svg>}/>
        <Card valor={s?.total_primaria??0} label="Primaria" sub="1° a 6°" color="#22c55e" icon={<svg width="18" height="18" viewBox="0 0 18 18" fill="none"><rect x="2" y="2" width="14" height="14" rx="3" stroke="currentColor" strokeWidth="1.4"/><path d="M6 9h6M9 6v6" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/></svg>}/>
        <Card valor={s?.total_secundaria??0} label="Secundaria" sub="1° a 5°" color="#f0a500" icon={<svg width="18" height="18" viewBox="0 0 18 18" fill="none"><rect x="2" y="2" width="14" height="14" rx="3" stroke="currentColor" strokeWidth="1.4"/><path d="M6 9h6" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/></svg>}/>
        <Card valor={s?.varones??0} label="Varones" color="#3b82f6" icon={<svg width="18" height="18" viewBox="0 0 18 18" fill="none"><circle cx="9" cy="7" r="4" stroke="currentColor" strokeWidth="1.4"/><path d="M5 16c0-2.21 1.79-4 4-4s4 1.79 4 4" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/></svg>}/>
        <Card valor={s?.mujeres??0} label="Mujeres" color="#ec4899" icon={<svg width="18" height="18" viewBox="0 0 18 18" fill="none"><circle cx="9" cy="7" r="4" stroke="currentColor" strokeWidth="1.4"/><path d="M5 16c0-2.21 1.79-4 4-4s4 1.79 4 4" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/></svg>}/>
        <Card valor={s?.activos??0} label="Activos" sub={`${s?.retirados??0} retirados`} color="#f0a500" icon={<svg width="18" height="18" viewBox="0 0 18 18" fill="none"><circle cx="9" cy="9" r="7" stroke="currentColor" strokeWidth="1.4"/><path d="M6 9l2 2 4-4" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round"/></svg>}/>
      </div>

      <div style={{display:'grid',gridTemplateColumns:'1fr 1fr',gap:'18px'}}>
        {/* Acciones rápidas */}
        <div style={{background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'16px',padding:'20px'}}>
          <h2 style={{fontSize:'14px',fontWeight:600,color:'var(--t1)',marginBottom:'14px'}}>Acciones rápidas</h2>
          <div style={{display:'flex',flexDirection:'column',gap:'8px'}}>
            {[
              {href:'/dashboard/estudiantes/nuevo',label:'Registrar estudiante',desc:'Nuevo alumno al sistema',color:'#3b82f6'},
              {href:'/dashboard/estudiantes',label:'Buscar estudiante',desc:'Por nombre, DNI o grado',color:'#22c55e'},
              {href:'/dashboard/reportes',label:'Exportar lista',desc:'Excel o PDF por grado/nivel',color:'#f0a500'},
            ].map(a=>(
              <Link key={a.href} href={a.href} style={{display:'flex',alignItems:'center',gap:'12px',padding:'12px 14px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'11px',textDecoration:'none',transition:'border-color .15s'}}>
                <div style={{width:'36px',height:'36px',minWidth:'36px',borderRadius:'9px',background:a.color+'15',border:`1px solid ${a.color}22`,display:'flex',alignItems:'center',justifyContent:'center',color:a.color}}>
                  <svg width="16" height="16" viewBox="0 0 16 16" fill="none"><path d="M3 8h10M9 4l4 4-4 4" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/></svg>
                </div>
                <div style={{flex:1}}>
                  <div style={{fontSize:'13px',fontWeight:500,color:'var(--t1)'}}>{a.label}</div>
                  <div style={{fontSize:'11.5px',color:'var(--t3)',marginTop:'1px'}}>{a.desc}</div>
                </div>
                <svg width="14" height="14" viewBox="0 0 14 14" fill="none" style={{color:'var(--t3)'}}><path d="M5 3l4 4-4 4" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/></svg>
              </Link>
            ))}
          </div>
        </div>

        {/* Distribución por grado */}
        <div style={{background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'16px',padding:'20px'}}>
          <div style={{display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:'14px'}}>
            <h2 style={{fontSize:'14px',fontWeight:600,color:'var(--t1)'}}>Por grado y nivel</h2>
            <div style={{display:'flex',gap:'10px'}}>
              {['Primaria','Secundaria'].map(n=>(
                <div key={n} style={{display:'flex',alignItems:'center',gap:'5px',fontSize:'11px',color:'var(--t2)'}}>
                  <div style={{width:'8px',height:'8px',borderRadius:'50%',background:COLORES_NIVEL[n]}}/>
                  {n}
                </div>
              ))}
            </div>
          </div>
          {carg ? (
            <div style={{display:'flex',flexDirection:'column',gap:'8px'}}>
              {[...Array(6)].map((_,i)=><div key={i} style={{height:'24px',background:'var(--surface)',borderRadius:'4px',opacity:.4}}/>)}
            </div>
          ) : s?.por_grado?.length ? (
            <div style={{display:'flex',flexDirection:'column',gap:'7px',maxHeight:'240px',overflowY:'auto'}}>
              {s.por_grado.map((g,i)=>(
                <div key={i} style={{display:'flex',alignItems:'center',gap:'8px'}}>
                  <span style={{fontSize:'11px',color:'var(--t2)',width:'72px',minWidth:'72px'}}>{g.nivel==='Primaria'?'P':'S'} {g.grado}-{g.seccion}</span>
                  <div style={{flex:1,height:'6px',background:'var(--surface)',borderRadius:'3px',overflow:'hidden'}}>
                    <div style={{width:`${(g.total/maxG)*100}%`,height:'100%',background:COLORES_NIVEL[g.nivel]||'#3b82f6',borderRadius:'3px',transition:'width .5s ease'}}/>
                  </div>
                  <span style={{fontSize:'11px',color:'var(--t3)',width:'22px',textAlign:'right'}}>{g.total}</span>
                </div>
              ))}
            </div>
          ) : (
            <div style={{textAlign:'center',padding:'24px',color:'var(--t3)',fontSize:'13px'}}>Sin matrículas este año</div>
          )}
        </div>
      </div>
    </div>
  )
}
