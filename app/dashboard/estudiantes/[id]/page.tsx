'use client'
import { useEffect, useState } from 'react'
import { useRouter, useParams } from 'next/navigation'
import Link from 'next/link'

interface EstFull {
  id:number;dni:string;apellido_paterno:string;apellido_materno:string;nombres:string
  sexo:'M'|'F';fecha_nacimiento:string;edad:number;celular:string;email:string
  domicilio:string;departamento_nacimiento:string;provincia_nacimiento:string;distrito_nacimiento:string
  asegurado:boolean;tipo_seguro:string;enfermedades_cronicas:string
  alergico:boolean;alergias_detalle:string;estado_nutricional:string
  vacuna_covid:boolean;hermanos_en_ie:boolean;estado:string
  foto_url:string;creado_en:string;actualizado_en:string
  grado:string|null;seccion:string|null;nivel:string|null
  grado_id:number|null;seccion_id:number|null;anio_matricula:number|null
  apoderados:Apo[];contactos:Con[];historial:His[]
}
interface Apo{id:number;tipo:string;apellido_paterno:string;apellido_materno:string;nombres:string;dni:string;celular:string;email:string;es_principal:boolean;vive_con_estudiante:boolean;ocupacion:string}
interface Con{id:number;nombre:string;telefono:string;relacion:string;prioridad:number}
interface His{id:number;anio:number;grado:string;nivel:string;seccion:string;estado:string}

const EC:Record<string,string>={activo:'#22c55e',retirado:'#ef4444',trasladado:'#f59e0b',egresado:'#3b82f6',suspendido:'#a855f7'}
const I:React.CSSProperties={width:'100%',padding:'9px 11px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'9px',color:'var(--t1)',fontSize:'13.5px',fontFamily:'inherit',outline:'none'}
const L:React.CSSProperties={fontSize:'11px',color:'var(--t3)',textTransform:'uppercase',letterSpacing:'.4px',marginBottom:'3px'}

function Chip({l,c}:{l:string;c:string}){
  return <span style={{display:'inline-flex',alignItems:'center',gap:'5px',padding:'3px 9px',borderRadius:'20px',fontSize:'11px',fontWeight:500,background:c+'15',color:c,border:`1px solid ${c}30`,textTransform:'capitalize'}}><span style={{width:'5px',height:'5px',borderRadius:'50%',background:c}}/>{l}</span>
}
function Dato({k,v}:{k:string;v?:string|number|boolean|null}){
  if(v===null||v===undefined||v==='') return null
  const t=typeof v==='boolean'?(v?'Sí':'No'):String(v)
  return <div><div style={L}>{k}</div><div style={{fontSize:'13.5px',color:'var(--t1)'}}>{t}</div></div>
}
function Grid({children}:{children:React.ReactNode}){
  return <div style={{display:'grid',gridTemplateColumns:'repeat(auto-fill,minmax(165px,1fr))',gap:'18px',marginBottom:'22px'}}>{children}</div>
}
function SecT({t}:{t:string}){
  return <h3 style={{fontSize:'11px',fontWeight:600,color:'var(--t3)',textTransform:'uppercase',letterSpacing:'.9px',paddingBottom:'8px',borderBottom:'1px solid var(--b1)',marginBottom:'14px'}}>{t}</h3>
}
function Modal({titulo,onClose,children}:{titulo:string;onClose:()=>void;children:React.ReactNode}){
  return(
    <div style={{position:'fixed',inset:0,background:'rgba(0,0,0,.65)',zIndex:200,display:'flex',alignItems:'center',justifyContent:'center',padding:'20px'}}>
      <div style={{background:'var(--card)',border:'1px solid var(--b2)',borderRadius:'16px',width:'100%',maxWidth:'500px',maxHeight:'90vh',overflow:'auto',animation:'fadeIn .2s ease'}}>
        <div style={{display:'flex',justifyContent:'space-between',alignItems:'center',padding:'18px 22px',borderBottom:'1px solid var(--b1)'}}>
          <span style={{fontSize:'15px',fontWeight:600,color:'var(--t1)'}}>{titulo}</span>
          <button onClick={onClose} style={{background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'8px',padding:'6px',cursor:'pointer',color:'var(--t2)',display:'flex'}}>
            <svg width="14" height="14" viewBox="0 0 14 14" fill="none"><path d="M3 3l8 8M11 3l-8 8" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round"/></svg>
          </button>
        </div>
        <div style={{padding:'22px'}}>{children}</div>
      </div>
    </div>
  )
}

export default function FichaPage(){
  const {id}=useParams()
  const router=useRouter()
  const [est,setEst]=useState<EstFull|null>(null)
  const [carg,setCarg]=useState(true)
  const [tab,setTab]=useState<'datos'|'salud'|'apoderados'|'contactos'|'historial'>('datos')
  const [mApo,setMApo]=useState(false)
  const [mCon,setMCon]=useState(false)
  const [editApo,setEditApo]=useState<Apo|null>(null)
  const [editCon,setEditCon]=useState<Con|null>(null)
  const [guard,setGuard]=useState(false)
  const [fApo,setFApo]=useState({tipo:'madre',apellido_paterno:'',apellido_materno:'',nombres:'',dni:'',celular:'',email:'',ocupacion:'',es_principal:false,vive_con_estudiante:false})
  const [fCon,setFCon]=useState({nombre:'',telefono:'',relacion:'',prioridad:1})

  function cargar(){
    setCarg(true)
    fetch(`/api/estudiantes/${id}`).then(r=>r.json()).then(d=>{setEst(d);setCarg(false)}).catch(()=>setCarg(false))
  }
  useEffect(()=>{cargar()},[id])

  async function cambiarEstado(e:string){
    await fetch(`/api/estudiantes/${id}`,{method:'PUT',headers:{'Content-Type':'application/json'},body:JSON.stringify({estado:e})})
    setEst(p=>p?{...p,estado:e}:p)
  }

  function abrirNuevoApo(){setEditApo(null);setFApo({tipo:'madre',apellido_paterno:'',apellido_materno:'',nombres:'',dni:'',celular:'',email:'',ocupacion:'',es_principal:false,vive_con_estudiante:false});setMApo(true)}
  function abrirEditApo(a:Apo){setEditApo(a);setFApo({tipo:a.tipo,apellido_paterno:a.apellido_paterno,apellido_materno:a.apellido_materno||'',nombres:a.nombres,dni:a.dni||'',celular:a.celular||'',email:a.email||'',ocupacion:a.ocupacion||'',es_principal:a.es_principal,vive_con_estudiante:a.vive_con_estudiante});setMApo(true)}
  async function guardarApo(){
    if(!fApo.nombres.trim()||!fApo.celular.trim()){alert('Nombre y celular obligatorios');return}
    setGuard(true)
    if(editApo) await fetch(`/api/apoderados/${editApo.id}`,{method:'PUT',headers:{'Content-Type':'application/json'},body:JSON.stringify(fApo)})
    else await fetch('/api/apoderados',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({...fApo,estudiante_id:Number(id)})})
    setGuard(false);setMApo(false);cargar()
  }
  async function eliminarApo(aid:number){if(!confirm('¿Eliminar apoderado?'))return;await fetch(`/api/apoderados/${aid}`,{method:'DELETE'});cargar()}

  function abrirNuevoCon(){setEditCon(null);setFCon({nombre:'',telefono:'',relacion:'',prioridad:(est?.contactos?.length||0)+1});setMCon(true)}
  function abrirEditCon(c:Con){setEditCon(c);setFCon({nombre:c.nombre,telefono:c.telefono,relacion:c.relacion||'',prioridad:c.prioridad});setMCon(true)}
  async function guardarCon(){
    if(!fCon.nombre.trim()||!fCon.telefono.trim()){alert('Nombre y teléfono obligatorios');return}
    setGuard(true)
    if(editCon) await fetch(`/api/contactos/${editCon.id}`,{method:'PUT',headers:{'Content-Type':'application/json'},body:JSON.stringify(fCon)})
    else await fetch('/api/contactos',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({...fCon,estudiante_id:Number(id)})})
    setGuard(false);setMCon(false);cargar()
  }
  async function eliminarCon(cid:number){if(!confirm('¿Eliminar contacto?'))return;await fetch(`/api/contactos/${cid}`,{method:'DELETE'});cargar()}

  if(carg) return(
    <div style={{display:'flex',justifyContent:'center',padding:'60px',alignItems:'center',gap:'12px'}}>
      <div style={{width:'22px',height:'22px',border:'2px solid var(--b1)',borderTopColor:'var(--accent)',borderRadius:'50%',animation:'spin .8s linear infinite'}}/>
      <span style={{color:'var(--t3)'}}>Cargando ficha...</span>
      <style>{`@keyframes spin{to{transform:rotate(360deg)}}`}</style>
    </div>
  )
  if(!est) return <div style={{textAlign:'center',padding:'60px',color:'var(--t3)'}}>Estudiante no encontrado</div>

  const color=EC[est.estado]??'#8b9cc8'

  return(
    <div style={{maxWidth:'940px',margin:'0 auto'}}>
      <style>{`@keyframes spin{to{transform:rotate(360deg)}} @keyframes fadeIn{from{opacity:0;transform:translateY(6px)}to{opacity:1;transform:translateY(0)}} input:focus,select:focus,textarea:focus{border-color:rgba(240,165,0,.45)!important;box-shadow:0 0 0 3px rgba(240,165,0,.08)!important}`}</style>

      {/* Nav */}
      <div style={{display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:'20px',flexWrap:'wrap',gap:'10px'}}>
        <button onClick={()=>router.back()} style={{display:'flex',alignItems:'center',gap:'6px',background:'none',border:'none',cursor:'pointer',color:'var(--t3)',fontSize:'13px',fontFamily:'inherit'}}>
          <svg width="15" height="15" viewBox="0 0 15 15" fill="none"><path d="M10 3L6 7.5l4 4.5" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round"/></svg>Volver a la lista
        </button>
        <div style={{display:'flex',gap:'8px'}}>
          <button onClick={()=>window.print()} style={{display:'flex',alignItems:'center',gap:'6px',padding:'8px 13px',background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'8px',color:'var(--t2)',fontSize:'13px',cursor:'pointer',fontFamily:'inherit'}}>
            <svg width="14" height="14" viewBox="0 0 14 14" fill="none"><rect x="2.5" y="1" width="9" height="6" rx="1" stroke="currentColor" strokeWidth="1.3"/><path d="M2.5 7v4a1 1 0 001 1h7a1 1 0 001-1V7M1.5 4.5h11a1 1 0 011 1V9H.5V5.5a1 1 0 011-1z" stroke="currentColor" strokeWidth="1.3"/></svg>
            Imprimir
          </button>
          <Link href={`/dashboard/estudiantes/${id}/editar`} style={{display:'flex',alignItems:'center',gap:'6px',padding:'8px 14px',background:'var(--accent)',color:'#0f1623',borderRadius:'8px',textDecoration:'none',fontSize:'13px',fontWeight:600}}>
            <svg width="14" height="14" viewBox="0 0 14 14" fill="none"><path d="M9.5 1.5l3 3L4 12H1v-3L9.5 1.5z" stroke="currentColor" strokeWidth="1.3" strokeLinejoin="round"/></svg>
            Editar
          </Link>
        </div>
      </div>

      {/* Header ficha */}
      <div style={{background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'16px',padding:'20px',marginBottom:'16px',display:'flex',gap:'16px',alignItems:'flex-start',flexWrap:'wrap'}}>
        <div style={{width:'66px',height:'66px',minWidth:'66px',borderRadius:'50%',display:'flex',alignItems:'center',justifyContent:'center',fontSize:'22px',fontWeight:700,overflow:'hidden',background:est.sexo==='M'?'rgba(59,130,246,.1)':'rgba(236,72,153,.1)',border:`2px solid ${est.sexo==='M'?'rgba(59,130,246,.3)':'rgba(236,72,153,.3)'}`,color:est.sexo==='M'?'#3b82f6':'#ec4899'}}>
          {est.foto_url?<img src={est.foto_url} alt="" style={{width:'100%',height:'100%',objectFit:'cover'}}/>:est.apellido_paterno[0]}
        </div>
        <div style={{flex:1}}>
          <div style={{display:'flex',alignItems:'center',gap:'10px',flexWrap:'wrap',marginBottom:'6px'}}>
            <h1 style={{fontSize:'19px',fontWeight:600,color:'var(--t1)'}}>{est.apellido_paterno} {est.apellido_materno}, {est.nombres}</h1>
            <Chip l={est.estado} c={color}/>
          </div>
          <div style={{display:'flex',flexWrap:'wrap',gap:'14px'}}>
            <span style={{fontSize:'13px',color:'var(--t2)'}}>DNI: <strong style={{color:'var(--t1)',fontFamily:'monospace'}}>{est.dni}</strong></span>
            <span style={{fontSize:'13px',color:'var(--t2)'}}>{est.sexo==='M'?'Varón':'Mujer'} · {est.edad} años</span>
            {est.nivel&&<span style={{padding:'2px 9px',background:est.nivel==='Primaria'?'rgba(59,130,246,.1)':'rgba(240,165,0,.1)',border:`1px solid ${est.nivel==='Primaria'?'rgba(59,130,246,.2)':'rgba(240,165,0,.2)'}`,borderRadius:'5px',fontSize:'11.5px',color:est.nivel==='Primaria'?'#3b82f6':'#f0a500',fontWeight:500}}>{est.nivel}</span>}
            {est.grado&&<span style={{padding:'2px 9px',background:'rgba(139,156,200,.1)',border:'1px solid rgba(139,156,200,.15)',borderRadius:'5px',fontSize:'11.5px',color:'var(--t2)',fontWeight:500}}>{est.grado} — Sección {est.seccion} · {est.anio_matricula}</span>}
          </div>
        </div>
        <select value={est.estado} onChange={e=>cambiarEstado(e.target.value)} style={{padding:'7px 10px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'8px',color:'var(--t2)',fontSize:'12px',cursor:'pointer',fontFamily:'inherit',outline:'none'}}>
          <option value="activo">Activo</option><option value="retirado">Retirado</option>
          <option value="trasladado">Trasladado</option><option value="egresado">Egresado</option><option value="suspendido">Suspendido</option>
        </select>
      </div>

      {/* Tabs */}
      <div style={{display:'flex',gap:'3px',marginBottom:'16px',background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'12px',padding:'4px'}}>
        {([
          {k:'datos',l:'Datos personales'},
          {k:'salud',l:'Salud'},
          {k:'apoderados',l:`Apoderados (${est.apoderados?.length??0})`},
          {k:'contactos',l:`Emergencia (${est.contactos?.length??0})`},
          {k:'historial',l:'Historial'},
        ] as const).map(t=>(
          <button key={t.k} onClick={()=>setTab(t.k)} style={{flex:1,padding:'8px 6px',border:'none',cursor:'pointer',borderRadius:'9px',fontSize:'12px',fontFamily:'inherit',background:tab===t.k?'var(--surface)':'transparent',color:tab===t.k?'var(--t1)':'var(--t3)',fontWeight:tab===t.k?500:400,transition:'all .12s',whiteSpace:'nowrap'}}>{t.l}</button>
        ))}
      </div>

      {/* Contenido tabs */}
      <div style={{background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'16px',padding:'22px',animation:'fadeIn .2s ease'}}>

        {tab==='datos'&&(
          <>
            <SecT t="Identificación"/>
            <Grid><Dato k="Apellido paterno" v={est.apellido_paterno}/><Dato k="Apellido materno" v={est.apellido_materno}/><Dato k="Nombres" v={est.nombres}/><Dato k="DNI" v={est.dni}/><Dato k="Sexo" v={est.sexo==='M'?'Masculino':'Femenino'}/><Dato k="Fecha de nacimiento" v={new Date(est.fecha_nacimiento).toLocaleDateString('es-PE')}/><Dato k="Edad" v={`${est.edad} años`}/></Grid>
            <SecT t="Contacto y domicilio"/>
            <Grid><Dato k="Celular" v={est.celular}/><Dato k="Email" v={est.email}/><Dato k="Departamento" v={est.departamento_nacimiento}/><Dato k="Provincia" v={est.provincia_nacimiento}/><Dato k="Distrito" v={est.distrito_nacimiento}/></Grid>
            {est.domicilio&&<div style={{marginTop:'-6px'}}><Dato k="Domicilio" v={est.domicilio}/></div>}
          </>
        )}

        {tab==='salud'&&(
          <>
            <SecT t="Seguro y salud"/>
            <Grid><Dato k="Asegurado" v={est.asegurado}/><Dato k="Tipo de seguro" v={est.tipo_seguro}/><Dato k="Estado nutricional" v={est.estado_nutricional}/><Dato k="Vacuna COVID-19" v={est.vacuna_covid}/><Dato k="Alérgico" v={est.alergico}/><Dato k="Alergias" v={est.alergias_detalle}/><Dato k="Hermanos en IE" v={est.hermanos_en_ie}/></Grid>
            {est.enfermedades_cronicas&&<><SecT t="Enfermedades crónicas"/><p style={{fontSize:'13.5px',color:'var(--t1)',lineHeight:1.6}}>{est.enfermedades_cronicas}</p></>}
          </>
        )}

        {tab==='apoderados'&&(
          <>
            <div style={{display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:'16px'}}>
              <span style={{fontSize:'13px',color:'var(--t3)'}}>{est.apoderados?.length??0} apoderado{est.apoderados?.length!==1?'s':''}</span>
              <button onClick={abrirNuevoApo} style={{display:'flex',alignItems:'center',gap:'6px',padding:'8px 14px',background:'var(--accent)',color:'#0f1623',border:'none',borderRadius:'9px',fontSize:'13px',fontWeight:600,cursor:'pointer',fontFamily:'inherit'}}>
                <svg width="13" height="13" viewBox="0 0 13 13" fill="none"><path d="M6.5 2v9M2 6.5h9" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round"/></svg>Agregar
              </button>
            </div>
            {est.apoderados?.length===0
              ?<div style={{textAlign:'center',padding:'32px',color:'var(--t3)',fontSize:'13px'}}>No hay apoderados registrados</div>
              :<div style={{display:'flex',flexDirection:'column',gap:'10px'}}>
                {est.apoderados?.map(a=>(
                  <div key={a.id} style={{padding:'14px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'12px'}}>
                    <div style={{display:'flex',justifyContent:'space-between',alignItems:'flex-start',marginBottom:'10px'}}>
                      <div>
                        <span style={{fontSize:'13.5px',fontWeight:500,color:'var(--t1)'}}>{a.apellido_paterno} {a.apellido_materno}, {a.nombres}</span>
                        {a.es_principal&&<span style={{marginLeft:'8px',fontSize:'11px',padding:'2px 7px',background:'rgba(240,165,0,.1)',color:'var(--accent)',border:'1px solid rgba(240,165,0,.2)',borderRadius:'10px'}}>Principal</span>}
                        <div style={{fontSize:'12px',color:'var(--t3)',marginTop:'2px',textTransform:'capitalize'}}>{a.tipo}</div>
                      </div>
                      <div style={{display:'flex',gap:'5px'}}>
                        <button onClick={()=>abrirEditApo(a)} style={{display:'flex',alignItems:'center',justifyContent:'center',width:'28px',height:'28px',borderRadius:'7px',background:'var(--card)',border:'1px solid var(--b1)',color:'var(--t2)',cursor:'pointer'}}>
                          <svg width="12" height="12" viewBox="0 0 12 12" fill="none"><path d="M8 1.5l2.5 2.5L3.5 11H1V8.5L8 1.5z" stroke="currentColor" strokeWidth="1.3" strokeLinejoin="round"/></svg>
                        </button>
                        <button onClick={()=>eliminarApo(a.id)} style={{display:'flex',alignItems:'center',justifyContent:'center',width:'28px',height:'28px',borderRadius:'7px',background:'var(--card)',border:'1px solid var(--b1)',cursor:'pointer'}}>
                          <svg width="12" height="12" viewBox="0 0 12 12" fill="none"><path d="M1.5 3h9M4 3V2h4v1M5 5.5v4M7 5.5v4M2 3l.6 6.5a1 1 0 001 .9h4.8a1 1 0 001-.9L10 3" stroke="#ef4444" strokeWidth="1.3" strokeLinecap="round"/></svg>
                        </button>
                      </div>
                    </div>
                    <div style={{display:'grid',gridTemplateColumns:'repeat(auto-fill,minmax(140px,1fr))',gap:'10px'}}>
                      <Dato k="DNI" v={a.dni}/><Dato k="Celular" v={a.celular}/><Dato k="Email" v={a.email}/><Dato k="Ocupación" v={a.ocupacion}/><Dato k="Vive con alumno" v={a.vive_con_estudiante}/>
                    </div>
                  </div>
                ))}
              </div>
            }
          </>
        )}

        {tab==='contactos'&&(
          <>
            <div style={{display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:'16px'}}>
              <span style={{fontSize:'13px',color:'var(--t3)'}}>{est.contactos?.length??0} contacto{est.contactos?.length!==1?'s':''} de emergencia</span>
              <button onClick={abrirNuevoCon} style={{display:'flex',alignItems:'center',gap:'6px',padding:'8px 14px',background:'#ef4444',color:'#fff',border:'none',borderRadius:'9px',fontSize:'13px',fontWeight:600,cursor:'pointer',fontFamily:'inherit'}}>
                <svg width="13" height="13" viewBox="0 0 13 13" fill="none"><path d="M6.5 2v9M2 6.5h9" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round"/></svg>Agregar
              </button>
            </div>
            {est.contactos?.length===0
              ?<div style={{textAlign:'center',padding:'32px',color:'var(--t3)',fontSize:'13px'}}>No hay contactos de emergencia</div>
              :<div style={{display:'flex',flexDirection:'column',gap:'8px'}}>
                {est.contactos?.sort((a,b)=>a.prioridad-b.prioridad).map((c,i)=>(
                  <div key={c.id} style={{display:'flex',alignItems:'center',gap:'12px',padding:'12px 14px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'11px'}}>
                    <div style={{width:'26px',height:'26px',minWidth:'26px',borderRadius:'50%',background:'rgba(239,68,68,.1)',border:'1px solid rgba(239,68,68,.2)',display:'flex',alignItems:'center',justifyContent:'center',fontSize:'11px',fontWeight:600,color:'#ef4444'}}>{i+1}</div>
                    <div style={{flex:1}}>
                      <div style={{fontSize:'13.5px',fontWeight:500,color:'var(--t1)'}}>{c.nombre}</div>
                      <div style={{fontSize:'12px',color:'var(--t3)'}}>{c.relacion} · {c.telefono}</div>
                    </div>
                    <div style={{display:'flex',gap:'5px'}}>
                      <button onClick={()=>abrirEditCon(c)} style={{display:'flex',alignItems:'center',justifyContent:'center',width:'28px',height:'28px',borderRadius:'7px',background:'var(--card)',border:'1px solid var(--b1)',color:'var(--t2)',cursor:'pointer'}}>
                        <svg width="12" height="12" viewBox="0 0 12 12" fill="none"><path d="M8 1.5l2.5 2.5L3.5 11H1V8.5L8 1.5z" stroke="currentColor" strokeWidth="1.3" strokeLinejoin="round"/></svg>
                      </button>
                      <button onClick={()=>eliminarCon(c.id)} style={{display:'flex',alignItems:'center',justifyContent:'center',width:'28px',height:'28px',borderRadius:'7px',background:'var(--card)',border:'1px solid var(--b1)',cursor:'pointer'}}>
                        <svg width="12" height="12" viewBox="0 0 12 12" fill="none"><path d="M1.5 3h9M4 3V2h4v1M5 5.5v4M7 5.5v4M2 3l.6 6.5a1 1 0 001 .9h4.8a1 1 0 001-.9L10 3" stroke="#ef4444" strokeWidth="1.3" strokeLinecap="round"/></svg>
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            }
          </>
        )}

        {tab==='historial'&&(
          est.historial?.length===0
            ?<div style={{textAlign:'center',padding:'32px',color:'var(--t3)',fontSize:'13px'}}>Sin historial de matrículas</div>
            :<div style={{display:'flex',flexDirection:'column',gap:'7px'}}>
              {est.historial?.map(h=>(
                <div key={h.id} style={{display:'flex',justifyContent:'space-between',alignItems:'center',padding:'11px 15px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'10px'}}>
                  <div style={{display:'flex',alignItems:'center',gap:'12px'}}>
                    <span style={{fontSize:'14px',fontWeight:600,color:'var(--t1)',fontFamily:'monospace'}}>{h.anio}</span>
                    {h.nivel&&<span style={{padding:'2px 8px',background:h.nivel==='Primaria'?'rgba(59,130,246,.1)':'rgba(240,165,0,.1)',border:`1px solid ${h.nivel==='Primaria'?'rgba(59,130,246,.2)':'rgba(240,165,0,.2)'}`,borderRadius:'5px',fontSize:'11px',color:h.nivel==='Primaria'?'#3b82f6':'#f0a500'}}>{h.nivel}</span>}
                    <span style={{padding:'2px 8px',background:'rgba(139,156,200,.1)',border:'1px solid rgba(139,156,200,.15)',borderRadius:'5px',fontSize:'11.5px',color:'var(--t2)'}}>{h.grado} — Sección {h.seccion}</span>
                  </div>
                  <Chip l={h.estado} c={EC[h.estado]??'#8b9cc8'}/>
                </div>
              ))}
            </div>
        )}
      </div>

      {/* Meta */}
      <div style={{marginTop:'12px',display:'flex',gap:'18px',justifyContent:'flex-end'}}>
        <span style={{fontSize:'11px',color:'var(--t3)'}}>Registrado: {new Date(est.creado_en).toLocaleDateString('es-PE')}</span>
        {est.actualizado_en&&<span style={{fontSize:'11px',color:'var(--t3)'}}>Actualizado: {new Date(est.actualizado_en).toLocaleDateString('es-PE')}</span>}
      </div>

      {/* MODAL APODERADO */}
      {mApo&&(
        <Modal titulo={editApo?'Editar apoderado':'Nuevo apoderado'} onClose={()=>setMApo(false)}>
          <div style={{display:'grid',gridTemplateColumns:'1fr 1fr',gap:'12px'}}>
            {([['tipo','Tipo','select',['madre','padre','apoderado','abuelo','abuela','tutor','otro']],['apellido_paterno','Apellido paterno','text'],['apellido_materno','Apellido materno','text'],['nombres','Nombres','text'],['dni','DNI','text'],['celular','Celular','text'],['email','Email','email'],['ocupacion','Ocupación','text']] as [string,string,string,string[]?][]).map(([k,l,t,opts])=>(
              <div key={k} style={k==='nombres'?{gridColumn:'1/-1'}:{}}>
                <label style={{fontSize:'11px',color:'var(--t3)',display:'block',marginBottom:'4px',textTransform:'uppercase',letterSpacing:'.4px'}}>{l}</label>
                {t==='select'
                  ?<select style={I} value={(fApo as Record<string,unknown>)[k] as string} onChange={e=>setFApo(p=>({...p,[k]:e.target.value}))}>
                    {opts?.map(o=><option key={o} value={o}>{o}</option>)}
                  </select>
                  :<input type={t} style={I} value={(fApo as Record<string,unknown>)[k] as string} onChange={e=>setFApo(p=>({...p,[k]:e.target.value}))} placeholder={l}/>
                }
              </div>
            ))}
            <div style={{display:'flex',alignItems:'center',gap:'16px',gridColumn:'1/-1'}}>
              <label style={{display:'flex',alignItems:'center',gap:'7px',cursor:'pointer',fontSize:'13px',color:'var(--t2)'}}>
                <input type="checkbox" checked={fApo.es_principal} onChange={e=>setFApo(p=>({...p,es_principal:e.target.checked}))} style={{width:'15px',height:'15px',accentColor:'var(--accent)'}}/>Principal
              </label>
              <label style={{display:'flex',alignItems:'center',gap:'7px',cursor:'pointer',fontSize:'13px',color:'var(--t2)'}}>
                <input type="checkbox" checked={fApo.vive_con_estudiante} onChange={e=>setFApo(p=>({...p,vive_con_estudiante:e.target.checked}))} style={{width:'15px',height:'15px',accentColor:'var(--accent)'}}/>Vive con alumno
              </label>
            </div>
          </div>
          <div style={{display:'flex',justifyContent:'flex-end',gap:'8px',marginTop:'18px',paddingTop:'14px',borderTop:'1px solid var(--b1)'}}>
            <button onClick={()=>setMApo(false)} style={{padding:'9px 15px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'9px',color:'var(--t2)',fontSize:'13px',cursor:'pointer',fontFamily:'inherit'}}>Cancelar</button>
            <button onClick={guardarApo} disabled={guard} style={{padding:'9px 20px',background:'var(--accent)',color:'#0f1623',border:'none',borderRadius:'9px',fontSize:'13px',fontWeight:600,cursor:'pointer',fontFamily:'inherit',opacity:guard?.7:1}}>
              {guard?'Guardando...':'Guardar apoderado'}
            </button>
          </div>
        </Modal>
      )}

      {/* MODAL CONTACTO */}
      {mCon&&(
        <Modal titulo={editCon?'Editar contacto':'Nuevo contacto de emergencia'} onClose={()=>setMCon(false)}>
          <div style={{display:'grid',gridTemplateColumns:'1fr 1fr',gap:'12px'}}>
            {([['nombre','Nombre completo','text'],['telefono','Teléfono','text'],['relacion','Relación (tío, vecino...)','text'],['prioridad','Prioridad (1=primero)','number']] as [string,string,string][]).map(([k,l,t])=>(
              <div key={k} style={k==='nombre'?{gridColumn:'1/-1'}:{}}>
                <label style={{fontSize:'11px',color:'var(--t3)',display:'block',marginBottom:'4px',textTransform:'uppercase',letterSpacing:'.4px'}}>{l}</label>
                <input type={t} style={I} value={(fCon as Record<string,unknown>)[k] as string} onChange={e=>setFCon(p=>({...p,[k]:t==='number'?parseInt(e.target.value)||1:e.target.value}))} placeholder={l}/>
              </div>
            ))}
          </div>
          <div style={{display:'flex',justifyContent:'flex-end',gap:'8px',marginTop:'18px',paddingTop:'14px',borderTop:'1px solid var(--b1)'}}>
            <button onClick={()=>setMCon(false)} style={{padding:'9px 15px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'9px',color:'var(--t2)',fontSize:'13px',cursor:'pointer',fontFamily:'inherit'}}>Cancelar</button>
            <button onClick={guardarCon} disabled={guard} style={{padding:'9px 20px',background:'#ef4444',color:'#fff',border:'none',borderRadius:'9px',fontSize:'13px',fontWeight:600,cursor:'pointer',fontFamily:'inherit',opacity:guard?.7:1}}>
              {guard?'Guardando...':'Guardar contacto'}
            </button>
          </div>
        </Modal>
      )}
    </div>
  )
}
