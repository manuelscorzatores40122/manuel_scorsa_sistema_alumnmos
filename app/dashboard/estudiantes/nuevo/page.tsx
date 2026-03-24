'use client'
import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'

interface Grado { id:number; nombre:string; nivel:string; orden:number }
interface Seccion { id:number; nombre:string }
type Paso = 1|2|3|4

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

const PASOS=[{n:1,l:'Datos personales'},{n:2,l:'Salud y familia'},{n:3,l:'Matrícula'},{n:4,l:'Apoderado'}]

export default function NuevoPage(){
  const router=useRouter()
  const [paso,setPaso]=useState<Paso>(1)
  const [guard,setGuard]=useState(false)
  const [err,setErr]=useState('')
  const [grados,setGrados]=useState<Grado[]>([])
  const [secciones,setSecciones]=useState<Seccion[]>([])

  const [f,setF]=useState({
    apellido_paterno:'',apellido_materno:'',nombres:'',dni:'',sexo:'',fecha_nacimiento:'',
    celular:'',email:'',departamento_nacimiento:'',provincia_nacimiento:'',distrito_nacimiento:'',domicilio:'',
    asegurado:false,tipo_seguro:'',enfermedades_cronicas:'',alergico:false,alergias_detalle:'',
    estado_nutricional:'',vacuna_covid:false,hermanos_en_ie:false,estado:'activo',
    nivel:'Primaria',grado_id:'',seccion_id:'',anio:String(new Date().getFullYear()),
    apo_tipo:'madre',apo_apPat:'',apo_apMat:'',apo_nombres:'',apo_dni:'',apo_cel:'',apo_email:'',apo_vive:false,
  })

  useEffect(()=>{
    fetch('/api/grados').then(r=>r.json()).then(setGrados)
    fetch('/api/secciones').then(r=>r.json()).then(setSecciones)
  },[])

  function set(k:string,v:string|boolean){setF(p=>({...p,[k]:v}))}

  const gradosFiltrados = grados.filter(g=>g.nivel===f.nivel)

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
      const res=await fetch('/api/estudiantes',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({
        apellido_paterno:f.apellido_paterno,apellido_materno:f.apellido_materno,nombres:f.nombres,
        dni:f.dni,sexo:f.sexo,fecha_nacimiento:f.fecha_nacimiento,celular:f.celular,email:f.email,
        departamento_nacimiento:f.departamento_nacimiento,provincia_nacimiento:f.provincia_nacimiento,
        distrito_nacimiento:f.distrito_nacimiento,domicilio:f.domicilio,
        asegurado:f.asegurado,tipo_seguro:f.tipo_seguro,enfermedades_cronicas:f.enfermedades_cronicas,
        alergico:f.alergico,alergias_detalle:f.alergias_detalle,estado_nutricional:f.estado_nutricional,
        vacuna_covid:f.vacuna_covid,hermanos_en_ie:f.hermanos_en_ie,estado:f.estado,
        grado_id:f.grado_id?parseInt(f.grado_id):null,
        seccion_id:f.seccion_id?parseInt(f.seccion_id):null,
        anio:f.anio?parseInt(f.anio):null,
        apoderado:f.apo_nombres?{tipo:f.apo_tipo,apellido_paterno:f.apo_apPat,apellido_materno:f.apo_apMat,nombres:f.apo_nombres,dni:f.apo_dni,celular:f.apo_cel,email:f.apo_email,vive_con_estudiante:f.apo_vive}:null
      })})
      const d=await res.json()
      if(!res.ok){setErr(d.error||'Error al guardar')}
      else router.push(`/dashboard/estudiantes/${d.id}`)
    }finally{setGuard(false)}
  }

  return(
    <div style={{maxWidth:'860px',margin:'0 auto'}}>
      <style>{`@keyframes spin{to{transform:rotate(360deg)}} input:focus,select:focus,textarea:focus{border-color:rgba(240,165,0,.45)!important;box-shadow:0 0 0 3px rgba(240,165,0,.08)!important} input::placeholder,textarea::placeholder{color:var(--t3)}`}</style>

      <div style={{marginBottom:'22px'}}>
        <button onClick={()=>router.back()} style={{display:'flex',alignItems:'center',gap:'6px',background:'none',border:'none',cursor:'pointer',color:'var(--t3)',fontSize:'13px',marginBottom:'10px',fontFamily:'inherit'}}>
          <svg width="16" height="16" viewBox="0 0 16 16" fill="none"><path d="M10 4L6 8l4 4" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round"/></svg>Volver
        </button>
        <h1 style={{fontSize:'20px',fontWeight:600,color:'var(--t1)'}}>Registrar nuevo estudiante</h1>
        <p style={{fontSize:'13px',color:'var(--t3)',marginTop:'3px'}}>Completa la información en 4 pasos</p>
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

      <div style={{background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'16px',padding:'26px'}}>
        {/* PASO 1 */}
        {paso===1&&<>
          <Blq t="Identificación">
            <F l="Apellido paterno" req><input style={I} value={f.apellido_paterno} onChange={e=>set('apellido_paterno',e.target.value)} autoFocus/></F>
            <F l="Apellido materno"><input style={I} value={f.apellido_materno} onChange={e=>set('apellido_materno',e.target.value)}/></F>
            <F l="Nombres" req><input style={I} value={f.nombres} onChange={e=>set('nombres',e.target.value)}/></F>
            <F l="DNI" req><input style={I} value={f.dni} onChange={e=>set('dni',e.target.value.replace(/\D/g,'').slice(0,8))} maxLength={8} placeholder="8 dígitos"/></F>
            <F l="Sexo" req><select style={{...I,cursor:'pointer'}} value={f.sexo} onChange={e=>set('sexo',e.target.value)}><option value="">Seleccionar</option><option value="M">Masculino</option><option value="F">Femenino</option></select></F>
            <F l="Fecha de nacimiento" req><input type="date" style={I} value={f.fecha_nacimiento} onChange={e=>set('fecha_nacimiento',e.target.value)}/></F>
          </Blq>
          <Blq t="Contacto">
            <F l="Celular"><input style={I} value={f.celular} onChange={e=>set('celular',e.target.value)} placeholder="987654321"/></F>
            <F l="Email"><input type="email" style={I} value={f.email} onChange={e=>set('email',e.target.value)} placeholder="correo@ejemplo.com"/></F>
          </Blq>
          <Blq t="Lugar de nacimiento">
            <F l="Departamento"><input style={I} value={f.departamento_nacimiento} onChange={e=>set('departamento_nacimiento',e.target.value)}/></F>
            <F l="Provincia"><input style={I} value={f.provincia_nacimiento} onChange={e=>set('provincia_nacimiento',e.target.value)}/></F>
            <F l="Distrito"><input style={I} value={f.distrito_nacimiento} onChange={e=>set('distrito_nacimiento',e.target.value)}/></F>
          </Blq>
          <F l="Domicilio" full><textarea style={{...I,minHeight:'68px',resize:'vertical'}} value={f.domicilio} onChange={e=>set('domicilio',e.target.value)} placeholder="Calle, número, referencia..."/></F>
        </>}

        {/* PASO 2 */}
        {paso===2&&<>
          <Blq t="Seguro de salud">
            <F l="¿Tiene seguro?"><select style={{...I,cursor:'pointer'}} value={f.asegurado?'si':'no'} onChange={e=>set('asegurado',e.target.value==='si')}><option value="no">No</option><option value="si">Sí</option></select></F>
            {f.asegurado&&<F l="Tipo de seguro"><select style={{...I,cursor:'pointer'}} value={f.tipo_seguro} onChange={e=>set('tipo_seguro',e.target.value)}><option value="">Seleccionar</option><option value="SIS">SIS</option><option value="ESSALUD">EsSalud</option><option value="Privado">Privado</option><option value="Otro">Otro</option></select></F>}
          </Blq>
          <Blq t="Salud">
            <F l="Enfermedades crónicas" full><textarea style={{...I,minHeight:'62px',resize:'vertical'}} value={f.enfermedades_cronicas} onChange={e=>set('enfermedades_cronicas',e.target.value)} placeholder="Dejar vacío si no aplica"/></F>
            <F l="¿Es alérgico?"><select style={{...I,cursor:'pointer'}} value={f.alergico?'si':'no'} onChange={e=>set('alergico',e.target.value==='si')}><option value="no">No</option><option value="si">Sí</option></select></F>
            {f.alergico&&<F l="¿A qué?"><input style={I} value={f.alergias_detalle} onChange={e=>set('alergias_detalle',e.target.value)} placeholder="Polen, penicilina..."/></F>}
            <F l="Estado nutricional"><select style={{...I,cursor:'pointer'}} value={f.estado_nutricional} onChange={e=>set('estado_nutricional',e.target.value)}><option value="">Sin evaluar</option><option value="Normal">Normal</option><option value="Sobrepeso">Sobrepeso</option><option value="Obesidad">Obesidad</option><option value="Desnutrición">Desnutrición</option></select></F>
            <F l="Vacuna COVID-19"><select style={{...I,cursor:'pointer'}} value={f.vacuna_covid?'si':'no'} onChange={e=>set('vacuna_covid',e.target.value==='si')}><option value="no">No</option><option value="si">Sí</option></select></F>
            <F l="Hermanos en la IE"><select style={{...I,cursor:'pointer'}} value={f.hermanos_en_ie?'si':'no'} onChange={e=>set('hermanos_en_ie',e.target.value==='si')}><option value="no">No</option><option value="si">Sí</option></select></F>
            <F l="Estado del alumno"><select style={{...I,cursor:'pointer'}} value={f.estado} onChange={e=>set('estado',e.target.value)}><option value="activo">Activo</option><option value="retirado">Retirado</option><option value="trasladado">Trasladado</option></select></F>
          </Blq>
        </>}

        {/* PASO 3 */}
        {paso===3&&<>
          <div style={{padding:'12px 14px',marginBottom:'20px',background:'rgba(59,130,246,.06)',border:'1px solid rgba(59,130,246,.15)',borderRadius:'9px',fontSize:'13px',color:'var(--t2)'}}>
            💡 Selecciona el nivel primero — los grados cambian automáticamente.
          </div>
          <Blq t="Matrícula">
            <F l="Año"><select style={{...I,cursor:'pointer'}} value={f.anio} onChange={e=>set('anio',e.target.value)}>{[2024,2025,2026].map(a=><option key={a} value={a}>{a}</option>)}</select></F>
            <F l="Nivel" req>
              <select style={{...I,cursor:'pointer'}} value={f.nivel} onChange={e=>{set('nivel',e.target.value);set('grado_id','')}}>
                <option value="Primaria">Primaria (1° a 6°)</option>
                <option value="Secundaria">Secundaria (1° a 5°)</option>
              </select>
            </F>
            <F l="Grado">
              <select style={{...I,cursor:'pointer'}} value={f.grado_id} onChange={e=>set('grado_id',e.target.value)}>
                <option value="">Sin asignar</option>
                {gradosFiltrados.map(g=><option key={g.id} value={g.id}>{g.nombre} grado — {g.nivel}</option>)}
              </select>
            </F>
            <F l="Sección">
              <select style={{...I,cursor:'pointer'}} value={f.seccion_id} onChange={e=>set('seccion_id',e.target.value)}>
                <option value="">Sin asignar</option>
                {secciones.map(s=><option key={s.id} value={s.id}>Sección {s.nombre}</option>)}
              </select>
            </F>
          </Blq>
        </>}

        {/* PASO 4 */}
        {paso===4&&<>
          <div style={{padding:'12px 14px',marginBottom:'20px',background:'rgba(240,165,0,.06)',border:'1px solid rgba(240,165,0,.15)',borderRadius:'9px',fontSize:'13px',color:'var(--t2)'}}>
            💡 Registra al apoderado principal. Puedes agregar más desde la ficha del estudiante.
          </div>
          <Blq t="Apoderado">
            <F l="Tipo"><select style={{...I,cursor:'pointer'}} value={f.apo_tipo} onChange={e=>set('apo_tipo',e.target.value)}><option value="madre">Madre</option><option value="padre">Padre</option><option value="apoderado">Apoderado</option><option value="abuelo">Abuelo</option><option value="abuela">Abuela</option><option value="tutor">Tutor</option></select></F>
            <F l="Apellido paterno"><input style={I} value={f.apo_apPat} onChange={e=>set('apo_apPat',e.target.value)}/></F>
            <F l="Apellido materno"><input style={I} value={f.apo_apMat} onChange={e=>set('apo_apMat',e.target.value)}/></F>
            <F l="Nombres"><input style={I} value={f.apo_nombres} onChange={e=>set('apo_nombres',e.target.value)}/></F>
            <F l="DNI"><input style={I} value={f.apo_dni} onChange={e=>set('apo_dni',e.target.value.replace(/\D/g,'').slice(0,8))} maxLength={8}/></F>
            <F l="Celular"><input style={I} value={f.apo_cel} onChange={e=>set('apo_cel',e.target.value)}/></F>
            <F l="Email"><input type="email" style={I} value={f.apo_email} onChange={e=>set('apo_email',e.target.value)}/></F>
            <F l="¿Vive con el alumno?"><select style={{...I,cursor:'pointer'}} value={f.apo_vive?'si':'no'} onChange={e=>set('apo_vive',e.target.value==='si')}><option value="si">Sí</option><option value="no">No</option></select></F>
          </Blq>
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
              :<button onClick={guardar} disabled={guard} style={{display:'flex',alignItems:'center',gap:'6px',padding:'10px 22px',background:'#22c55e',color:'#fff',border:'none',borderRadius:'9px',fontSize:'13.5px',fontWeight:600,cursor:guard?'not-allowed':'pointer',opacity:guard?.7:1,fontFamily:'inherit'}}>
                {guard?<><span style={{width:'14px',height:'14px',border:'2px solid rgba(255,255,255,.3)',borderTopColor:'#fff',borderRadius:'50%',animation:'spin .8s linear infinite',display:'inline-block'}}/>Guardando...</>
                :<><svg width="15" height="15" viewBox="0 0 15 15" fill="none"><path d="M2.5 8l4 4L12.5 3" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"/></svg>Registrar estudiante</>}
              </button>
            }
          </div>
        </div>
      </div>
    </div>
  )
}
