'use client'
import { useState, useEffect } from 'react'
import { useRouter, useParams } from 'next/navigation'

interface Grado{id:number;nombre:string;nivel:string;orden:number}
interface Seccion{id:number;nombre:string}
type Paso=1|2|3|4

const I:React.CSSProperties={width:'100%',padding:'9px 12px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'9px',color:'var(--t1)',fontSize:'13.5px',fontFamily:'inherit',outline:'none'}
const L:React.CSSProperties={fontSize:'11.5px',fontWeight:500,color:'var(--t2)',display:'block',marginBottom:'5px'}

function F({l,req,children,full}:{l:string;req?:boolean;children:React.ReactNode;full?:boolean}){
  return <div style={full?{gridColumn:'1/-1'}:{}}><label style={L}>{l}{req&&<span style={{color:'#ef4444',marginLeft:'2px'}}>*</span>}</label>{children}</div>
}
function Blq({t,children}:{t:string;children:React.ReactNode}){
  return <div style={{marginBottom:'24px'}}>
    <h3 style={{fontSize:'11px',fontWeight:600,color:'var(--t3)',textTransform:'uppercase',letterSpacing:'.9px',paddingBottom:'8px',borderBottom:'1px solid var(--b1)',marginBottom:'14px'}}>{t}</h3>
    <div style={{display:'grid',gridTemplateColumns:'repeat(auto-fit,minmax(185px,1fr))',gap:'13px'}}>{children}</div>
  </div>
}
const PASOS=[{n:1,l:'Datos personales'},{n:2,l:'Salud y familia'},{n:3,l:'Matrícula'},{n:4,l:'Revisar'}]

export default function EditarPage(){
  const router=useRouter()
  const {id}=useParams()
  const [paso,setPaso]=useState<Paso>(1)
  const [guard,setGuard]=useState(false)
  const [carg,setCarg]=useState(true)
  const [err,setErr]=useState('')
  const [ok,setOk]=useState(false)
  const [grados,setGrados]=useState<Grado[]>([])
  const [secciones,setSecciones]=useState<Seccion[]>([])

  const [f,setF]=useState({
    apellido_paterno:'',apellido_materno:'',nombres:'',dni:'',sexo:'',fecha_nacimiento:'',
    celular:'',email:'',departamento_nacimiento:'',provincia_nacimiento:'',distrito_nacimiento:'',
    domicilio:'',asegurado:false,tipo_seguro:'',enfermedades_cronicas:'',alergico:false,
    alergias_detalle:'',estado_nutricional:'',vacuna_covid:false,hermanos_en_ie:false,
    estado:'activo',nivel:'Primaria',grado_id:'',seccion_id:'',anio:String(new Date().getFullYear()),
  })

  useEffect(()=>{
    fetch('/api/grados').then(r=>r.json()).then(setGrados)
    fetch('/api/secciones').then(r=>r.json()).then(setSecciones)
    fetch(`/api/estudiantes/${id}`).then(r=>r.json()).then(d=>{
      setF({
        apellido_paterno:d.apellido_paterno||'',apellido_materno:d.apellido_materno||'',
        nombres:d.nombres||'',dni:d.dni||'',sexo:d.sexo||'',
        fecha_nacimiento:d.fecha_nacimiento?d.fecha_nacimiento.split('T')[0]:'',
        celular:d.celular||'',email:d.email||'',
        departamento_nacimiento:d.departamento_nacimiento||'',
        provincia_nacimiento:d.provincia_nacimiento||'',distrito_nacimiento:d.distrito_nacimiento||'',
        domicilio:d.domicilio||'',asegurado:!!d.asegurado,tipo_seguro:d.tipo_seguro||'',
        enfermedades_cronicas:d.enfermedades_cronicas||'',alergico:!!d.alergico,
        alergias_detalle:d.alergias_detalle||'',estado_nutricional:d.estado_nutricional||'',
        vacuna_covid:!!d.vacuna_covid,hermanos_en_ie:!!d.hermanos_en_ie,estado:d.estado||'activo',
        nivel:d.nivel||'Primaria',
        grado_id:d.grado_id?String(d.grado_id):'',
        seccion_id:d.seccion_id?String(d.seccion_id):'',
        anio:d.anio_matricula?String(d.anio_matricula):String(new Date().getFullYear()),
      })
      setCarg(false)
    }).catch(()=>setCarg(false))
  },[id])

  function set(k:string,v:string|boolean){setF(p=>({...p,[k]:v}))}
  const gradosFiltrados=grados.filter(g=>g.nivel===f.nivel)

  function validar(){
    if(paso===1){
      if(!f.apellido_paterno.trim())return 'Apellido paterno obligatorio'
      if(!f.nombres.trim())return 'Nombres obligatorios'
      if(f.dni.length!==8)return 'DNI debe tener 8 dígitos'
      if(!f.sexo)return 'Selecciona el sexo'
      if(!f.fecha_nacimiento)return 'Fecha de nacimiento obligatoria'
    }
    return ''
  }
  function siguiente(){const e=validar();if(e){setErr(e);return}setErr('');setPaso(p=>Math.min(4,p+1) as Paso)}

  async function guardar(){
    setGuard(true);setErr('')
    try{
      const res=await fetch(`/api/estudiantes/${id}`,{method:'PUT',headers:{'Content-Type':'application/json'},body:JSON.stringify({
        ...f,
        grado_id:f.grado_id?parseInt(f.grado_id):null,
        seccion_id:f.seccion_id?parseInt(f.seccion_id):null,
        anio:f.anio?parseInt(f.anio):null,
      })})
      const d=await res.json()
      if(!res.ok){setErr(d.error||'Error al guardar');return}
      setOk(true)
      setTimeout(()=>router.push(`/dashboard/estudiantes/${id}`),1200)
    }finally{setGuard(false)}
  }

  if(carg) return(
    <div style={{display:'flex',justifyContent:'center',padding:'60px',alignItems:'center',gap:'12px'}}>
      <div style={{width:'22px',height:'22px',border:'2px solid var(--b1)',borderTopColor:'var(--accent)',borderRadius:'50%',animation:'spin .8s linear infinite'}}/>
      <span style={{color:'var(--t3)'}}>Cargando datos...</span>
      <style>{`@keyframes spin{to{transform:rotate(360deg)}}`}</style>
    </div>
  )

  return(
    <div style={{maxWidth:'860px',margin:'0 auto'}}>
      <style>{`@keyframes spin{to{transform:rotate(360deg)}} input:focus,select:focus,textarea:focus{border-color:rgba(240,165,0,.45)!important;box-shadow:0 0 0 3px rgba(240,165,0,.08)!important} input::placeholder,textarea::placeholder{color:var(--t3)}`}</style>

      <div style={{marginBottom:'22px'}}>
        <button onClick={()=>router.back()} style={{display:'flex',alignItems:'center',gap:'6px',background:'none',border:'none',cursor:'pointer',color:'var(--t3)',fontSize:'13px',marginBottom:'10px',fontFamily:'inherit'}}>
          <svg width="15" height="15" viewBox="0 0 15 15" fill="none"><path d="M10 3L6 7.5l4 4.5" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round"/></svg>Volver
        </button>
        <h1 style={{fontSize:'20px',fontWeight:600,color:'var(--t1)'}}>Editar estudiante</h1>
        <p style={{fontSize:'13px',color:'var(--t3)',marginTop:'3px'}}>
          {f.apellido_paterno} {f.apellido_materno}, {f.nombres}
          {f.dni&&<span style={{fontFamily:'monospace',marginLeft:'6px',color:'var(--t2)'}}> · DNI {f.dni}</span>}
        </p>
      </div>

      {/* Stepper */}
      <div style={{display:'flex',background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'12px',padding:'4px',marginBottom:'22px'}}>
        {PASOS.map((p,i)=>{
          const a=paso===p.n,d=paso>p.n
          return(<div key={p.n} style={{display:'flex',alignItems:'center',flex:1}}>
            <div onClick={()=>d&&setPaso(p.n as Paso)} style={{flex:1,display:'flex',alignItems:'center',gap:'8px',padding:'9px 10px',borderRadius:'9px',cursor:d?'pointer':'default',background:a?'var(--surface)':'transparent'}}>
              <div style={{width:'22px',height:'22px',minWidth:'22px',borderRadius:'50%',display:'flex',alignItems:'center',justifyContent:'center',fontSize:'11px',fontWeight:600,background:a?'var(--accent)':d?'rgba(34,197,94,.15)':'var(--surface)',color:a?'#0f1623':d?'#22c55e':'var(--t3)',border:d?'1px solid rgba(34,197,94,.3)':a?'none':'1px solid var(--b1)'}}>
                {d?'✓':p.n}
              </div>
              <span style={{fontSize:'12px',fontWeight:a?500:400,color:a?'var(--t1)':'var(--t3)',whiteSpace:'nowrap'}}>{p.l}</span>
            </div>
            {i<PASOS.length-1&&<div style={{width:'1px',height:'18px',background:'var(--b1)'}}/>}
          </div>)
        })}
      </div>

      {err&&<div style={{display:'flex',alignItems:'center',gap:'8px',padding:'11px 14px',marginBottom:'16px',background:'rgba(239,68,68,.08)',border:'1px solid rgba(239,68,68,.2)',borderRadius:'9px',fontSize:'13px',color:'#ef4444'}}>⚠ {err}</div>}
      {ok&&<div style={{padding:'11px 14px',marginBottom:'16px',background:'rgba(34,197,94,.08)',border:'1px solid rgba(34,197,94,.2)',borderRadius:'9px',fontSize:'13px',color:'#22c55e'}}>✓ Guardado correctamente. Redirigiendo...</div>}

      <div style={{background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'16px',padding:'26px'}}>

        {paso===1&&<>
          <Blq t="Identificación">
            <F l="Apellido paterno" req><input style={I} value={f.apellido_paterno} onChange={e=>set('apellido_paterno',e.target.value)} autoFocus/></F>
            <F l="Apellido materno"><input style={I} value={f.apellido_materno} onChange={e=>set('apellido_materno',e.target.value)}/></F>
            <F l="Nombres" req><input style={I} value={f.nombres} onChange={e=>set('nombres',e.target.value)}/></F>
            <F l="DNI" req><input style={I} value={f.dni} onChange={e=>set('dni',e.target.value.replace(/\D/g,'').slice(0,8))} maxLength={8}/></F>
            <F l="Sexo" req><select style={{...I,cursor:'pointer'}} value={f.sexo} onChange={e=>set('sexo',e.target.value)}><option value="">Seleccionar</option><option value="M">Masculino</option><option value="F">Femenino</option></select></F>
            <F l="Fecha de nacimiento" req><input type="date" style={I} value={f.fecha_nacimiento} onChange={e=>set('fecha_nacimiento',e.target.value)}/></F>
          </Blq>
          <Blq t="Contacto">
            <F l="Celular"><input style={I} value={f.celular} onChange={e=>set('celular',e.target.value)} placeholder="987654321"/></F>
            <F l="Email"><input type="email" style={I} value={f.email} onChange={e=>set('email',e.target.value)}/></F>
          </Blq>
          <Blq t="Lugar de nacimiento">
            <F l="Departamento"><input style={I} value={f.departamento_nacimiento} onChange={e=>set('departamento_nacimiento',e.target.value)}/></F>
            <F l="Provincia"><input style={I} value={f.provincia_nacimiento} onChange={e=>set('provincia_nacimiento',e.target.value)}/></F>
            <F l="Distrito"><input style={I} value={f.distrito_nacimiento} onChange={e=>set('distrito_nacimiento',e.target.value)}/></F>
          </Blq>
          <F l="Domicilio" full><textarea style={{...I,minHeight:'68px',resize:'vertical'}} value={f.domicilio} onChange={e=>set('domicilio',e.target.value)} placeholder="Calle, número, referencia..."/></F>
        </>}

        {paso===2&&<>
          <Blq t="Seguro de salud">
            <F l="¿Tiene seguro?"><select style={{...I,cursor:'pointer'}} value={f.asegurado?'si':'no'} onChange={e=>set('asegurado',e.target.value==='si')}><option value="no">No</option><option value="si">Sí</option></select></F>
            {f.asegurado&&<F l="Tipo de seguro"><select style={{...I,cursor:'pointer'}} value={f.tipo_seguro} onChange={e=>set('tipo_seguro',e.target.value)}><option value="">Seleccionar</option><option value="SIS">SIS</option><option value="ESSALUD">EsSalud</option><option value="Privado">Privado</option><option value="Otro">Otro</option></select></F>}
          </Blq>
          <Blq t="Salud">
            <F l="Enfermedades crónicas" full><textarea style={{...I,minHeight:'62px',resize:'vertical'}} value={f.enfermedades_cronicas} onChange={e=>set('enfermedades_cronicas',e.target.value)} placeholder="Vacío si no aplica"/></F>
            <F l="¿Es alérgico?"><select style={{...I,cursor:'pointer'}} value={f.alergico?'si':'no'} onChange={e=>set('alergico',e.target.value==='si')}><option value="no">No</option><option value="si">Sí</option></select></F>
            {f.alergico&&<F l="¿A qué?"><input style={I} value={f.alergias_detalle} onChange={e=>set('alergias_detalle',e.target.value)}/></F>}
            <F l="Estado nutricional"><select style={{...I,cursor:'pointer'}} value={f.estado_nutricional} onChange={e=>set('estado_nutricional',e.target.value)}><option value="">Sin evaluar</option><option value="Normal">Normal</option><option value="Sobrepeso">Sobrepeso</option><option value="Obesidad">Obesidad</option><option value="Desnutrición">Desnutrición</option></select></F>
            <F l="Vacuna COVID-19"><select style={{...I,cursor:'pointer'}} value={f.vacuna_covid?'si':'no'} onChange={e=>set('vacuna_covid',e.target.value==='si')}><option value="no">No</option><option value="si">Sí</option></select></F>
            <F l="Hermanos en IE"><select style={{...I,cursor:'pointer'}} value={f.hermanos_en_ie?'si':'no'} onChange={e=>set('hermanos_en_ie',e.target.value==='si')}><option value="no">No</option><option value="si">Sí</option></select></F>
            <F l="Estado del alumno"><select style={{...I,cursor:'pointer'}} value={f.estado} onChange={e=>set('estado',e.target.value)}><option value="activo">Activo</option><option value="retirado">Retirado</option><option value="trasladado">Trasladado</option><option value="egresado">Egresado</option><option value="suspendido">Suspendido</option></select></F>
          </Blq>
        </>}

        {paso===3&&<>
          <div style={{padding:'12px 14px',marginBottom:'20px',background:'rgba(59,130,246,.06)',border:'1px solid rgba(59,130,246,.15)',borderRadius:'9px',fontSize:'13px',color:'var(--t2)'}}>
            💡 Selecciona el nivel — los grados cambian automáticamente.
          </div>
          <Blq t="Matrícula">
            <F l="Año"><select style={{...I,cursor:'pointer'}} value={f.anio} onChange={e=>set('anio',e.target.value)}>{[2024,2025,2026].map(a=><option key={a} value={a}>{a}</option>)}</select></F>
            <F l="Nivel"><select style={{...I,cursor:'pointer'}} value={f.nivel} onChange={e=>{set('nivel',e.target.value);set('grado_id','')}}><option value="Primaria">Primaria (1° a 6°)</option><option value="Secundaria">Secundaria (1° a 5°)</option></select></F>
            <F l="Grado"><select style={{...I,cursor:'pointer'}} value={f.grado_id} onChange={e=>set('grado_id',e.target.value)}><option value="">Sin asignar</option>{gradosFiltrados.map(g=><option key={g.id} value={g.id}>{g.nombre} grado — {g.nivel}</option>)}</select></F>
            <F l="Sección"><select style={{...I,cursor:'pointer'}} value={f.seccion_id} onChange={e=>set('seccion_id',e.target.value)}><option value="">Sin asignar</option>{secciones.map(s=><option key={s.id} value={s.id}>Sección {s.nombre}</option>)}</select></F>
          </Blq>
        </>}

        {paso===4&&<>
          <div style={{padding:'12px 14px',marginBottom:'20px',background:'rgba(34,197,94,.06)',border:'1px solid rgba(34,197,94,.15)',borderRadius:'9px',fontSize:'13px',color:'var(--t2)'}}>
            ✅ Revisa los datos antes de guardar. Puedes volver a pasos anteriores.
          </div>
          {[
            {t:'Identificación',r:[['Apellido paterno',f.apellido_paterno],['Apellido materno',f.apellido_materno],['Nombres',f.nombres],['DNI',f.dni],['Sexo',f.sexo==='M'?'Masculino':'Femenino'],['Nacimiento',f.fecha_nacimiento]]},
            {t:'Salud',r:[['Asegurado',f.asegurado?'Sí':'No'],['Tipo seguro',f.tipo_seguro||'—'],['Alérgico',f.alergico?'Sí':'No'],['Estado nutricional',f.estado_nutricional||'—']]},
            {t:'Matrícula',r:[['Año',f.anio],['Nivel',f.nivel],['Grado',grados.find(g=>g.id===parseInt(f.grado_id))?.nombre||'Sin asignar'],['Sección',secciones.find(s=>s.id===parseInt(f.seccion_id))?.nombre||'Sin asignar'],['Estado',f.estado]]},
          ].map(b=>(
            <div key={b.t} style={{marginBottom:'20px'}}>
              <h3 style={{fontSize:'11px',fontWeight:600,color:'var(--t3)',textTransform:'uppercase',letterSpacing:'.9px',paddingBottom:'8px',borderBottom:'1px solid var(--b1)',marginBottom:'12px'}}>{b.t}</h3>
              <div style={{display:'grid',gridTemplateColumns:'repeat(auto-fill,minmax(170px,1fr))',gap:'12px'}}>
                {b.r.map(([k,v])=>(
                  <div key={k}>
                    <div style={{fontSize:'10.5px',color:'var(--t3)',textTransform:'uppercase',letterSpacing:'.4px',marginBottom:'3px'}}>{k}</div>
                    <div style={{fontSize:'13.5px',color:v?'var(--t1)':'var(--t3)'}}>{v||'—'}</div>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </>}

        {/* Botones */}
        <div style={{display:'flex',justifyContent:'space-between',alignItems:'center',marginTop:'26px',paddingTop:'18px',borderTop:'1px solid var(--b1)'}}>
          <button onClick={()=>paso>1?setPaso(p=>(p-1) as Paso):router.back()} style={{display:'flex',alignItems:'center',gap:'6px',padding:'10px 18px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'9px',color:'var(--t2)',fontSize:'13.5px',cursor:'pointer',fontFamily:'inherit'}}>
            <svg width="15" height="15" viewBox="0 0 15 15" fill="none"><path d="M10 3L6 7.5l4 4.5" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round"/></svg>
            {paso===1?'Cancelar':'Anterior'}
          </button>
          <div style={{display:'flex',alignItems:'center',gap:'10px'}}>
            <span style={{fontSize:'12px',color:'var(--t3)'}}>Paso {paso} de 4</span>
            {paso<4
              ?<button onClick={siguiente} style={{display:'flex',alignItems:'center',gap:'6px',padding:'10px 20px',background:'var(--accent)',color:'#0f1623',border:'none',borderRadius:'9px',fontSize:'13.5px',fontWeight:600,cursor:'pointer',fontFamily:'inherit'}}>
                Siguiente <svg width="15" height="15" viewBox="0 0 15 15" fill="none"><path d="M5 3l5 4.5L5 12" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round"/></svg>
              </button>
              :<button onClick={guardar} disabled={guard||ok} style={{display:'flex',alignItems:'center',gap:'6px',padding:'10px 22px',background:'#22c55e',color:'#fff',border:'none',borderRadius:'9px',fontSize:'13.5px',fontWeight:600,cursor:guard?'not-allowed':'pointer',opacity:guard||ok?.7:1,fontFamily:'inherit'}}>
                {guard?<><span style={{width:'14px',height:'14px',border:'2px solid rgba(255,255,255,.3)',borderTopColor:'#fff',borderRadius:'50%',animation:'spin .8s linear infinite',display:'inline-block'}}/>Guardando...</>
                :<><svg width="15" height="15" viewBox="0 0 15 15" fill="none"><path d="M2.5 7.5l4 4L12.5 3" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"/></svg>Guardar cambios</>}
              </button>
            }
          </div>
        </div>
      </div>
    </div>
  )
}
