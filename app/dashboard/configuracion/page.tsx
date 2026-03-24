'use client'
import { useState } from 'react'

const I:React.CSSProperties={width:'100%',padding:'10px 12px',background:'var(--surface)',border:'1px solid var(--b1)',borderRadius:'9px',color:'var(--t1)',fontSize:'14px',fontFamily:'inherit',outline:'none'}
const L:React.CSSProperties={fontSize:'11px',fontWeight:500,color:'var(--t3)',display:'block',marginBottom:'6px',textTransform:'uppercase',letterSpacing:'.3px'}

function Card({titulo,desc,children}:{titulo:string;desc:string;children:React.ReactNode}){
  return(
    <div style={{background:'var(--card)',border:'1px solid var(--b1)',borderRadius:'16px',overflow:'hidden',marginBottom:'16px'}}>
      <div style={{padding:'16px 20px',borderBottom:'1px solid var(--b1)',background:'var(--surface)'}}>
        <div style={{fontSize:'14px',fontWeight:600,color:'var(--t1)'}}>{titulo}</div>
        <div style={{fontSize:'12.5px',color:'var(--t3)',marginTop:'3px'}}>{desc}</div>
      </div>
      <div style={{padding:'20px'}}>{children}</div>
    </div>
  )
}
function Msg({tipo,txt}:{tipo:'ok'|'err';txt:string}){
  const c=tipo==='ok'?'#22c55e':'#ef4444'
  return <div style={{padding:'10px 14px',marginBottom:'16px',borderRadius:'9px',fontSize:'13px',background:c+'10',border:`1px solid ${c}25`,color:c}}>{tipo==='ok'?'✓ ':' ⚠ '}{txt}</div>
}

export default function ConfigPage(){
  const [pass,setPass]=useState({actual:'',nueva:'',confirmar:''})
  const [msgP,setMsgP]=useState<{tipo:'ok'|'err';txt:string}|null>(null)
  const [cargP,setCargP]=useState(false)
  const [nuevoG,setNuevoG]=useState('')
  const [nivelG,setNivelG]=useState('Primaria')
  const [nuevaS,setNuevaS]=useState('')
  const [msgG,setMsgG]=useState<{tipo:'ok'|'err';txt:string}|null>(null)
  const [msgS,setMsgS]=useState<{tipo:'ok'|'err';txt:string}|null>(null)

  async function cambiarPass(e:React.FormEvent){
    e.preventDefault()
    if(pass.nueva!==pass.confirmar){setMsgP({tipo:'err',txt:'Las contraseñas no coinciden'});return}
    if(pass.nueva.length<8){setMsgP({tipo:'err',txt:'Mínimo 8 caracteres'});return}
    setCargP(true);setMsgP(null)
    try{
      const r=await fetch('/api/auth/cambiar-password',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({passwordActual:pass.actual,passwordNueva:pass.nueva})})
      const d=await r.json()
      if(!r.ok) setMsgP({tipo:'err',txt:d.error||'Error al cambiar'})
      else{setMsgP({tipo:'ok',txt:'Contraseña actualizada correctamente'});setPass({actual:'',nueva:'',confirmar:''})}
    }finally{setCargP(false)}
  }

  async function agregarGrado(){
    if(!nuevoG.trim())return
    const r=await fetch('/api/grados',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({nombre:nuevoG.trim(),nivel:nivelG})})
    const d=await r.json()
    if(!r.ok) setMsgG({tipo:'err',txt:d.error||'Error al crear grado'})
    else{setMsgG({tipo:'ok',txt:`Grado "${nuevoG}" (${nivelG}) creado`});setNuevoG('')}
  }

  async function agregarSeccion(){
    if(!nuevaS.trim())return
    const r=await fetch('/api/secciones',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({nombre:nuevaS.trim()})})
    const d=await r.json()
    if(!r.ok) setMsgS({tipo:'err',txt:d.error||'Error al crear'})
    else{setMsgS({tipo:'ok',txt:`Sección "${nuevaS}" creada`});setNuevaS('')}
  }

  const btnBase:React.CSSProperties={padding:'10px 18px',border:'none',borderRadius:'9px',fontSize:'13.5px',fontWeight:600,cursor:'pointer',fontFamily:'inherit'}

  return(
    <div style={{maxWidth:'640px'}}>
      <style>{`input:focus,select:focus{border-color:rgba(240,165,0,.45)!important;box-shadow:0 0 0 3px rgba(240,165,0,.08)!important} input::placeholder{color:var(--t3)}`}</style>
      <div style={{marginBottom:'26px'}}>
        <h1 style={{fontSize:'20px',fontWeight:600,color:'var(--t1)'}}>Configuración</h1>
        <p style={{fontSize:'13px',color:'var(--t3)',marginTop:'4px'}}>Ajustes del sistema escolar</p>
      </div>

      {/* Contraseña */}
      <Card titulo="Cambiar contraseña" desc="Actualiza la contraseña de acceso al sistema">
        {msgP&&<Msg tipo={msgP.tipo} txt={msgP.txt}/>}
        <form onSubmit={cambiarPass} style={{display:'flex',flexDirection:'column',gap:'14px'}}>
          {(['actual','nueva','confirmar'] as const).map(k=>(
            <div key={k}>
              <label style={L}>{k==='actual'?'Contraseña actual':k==='nueva'?'Nueva contraseña':'Confirmar nueva'}</label>
              <input type="password" style={I} value={pass[k]} onChange={e=>setPass(p=>({...p,[k]:e.target.value}))} placeholder={k==='nueva'?'Mínimo 8 caracteres':''}/>
            </div>
          ))}
          <button type="submit" disabled={cargP} style={{...btnBase,background:'var(--accent)',color:'#0f1623',alignSelf:'flex-start',opacity:cargP?.7:1}}>
            {cargP?'Guardando...':'Actualizar contraseña'}
          </button>
        </form>
      </Card>

      {/* Grados */}
      <Card titulo="Grados" desc="Agrega grados adicionales para Primaria o Secundaria">
        {msgG&&<Msg tipo={msgG.tipo} txt={msgG.txt}/>}
        <div style={{display:'flex',gap:'10px',alignItems:'flex-end',flexWrap:'wrap'}}>
          <div style={{flex:1,minWidth:'120px'}}>
            <label style={L}>Nombre del grado</label>
            <input style={I} value={nuevoG} onChange={e=>setNuevoG(e.target.value)} placeholder="Ej: 7°" onKeyDown={e=>e.key==='Enter'&&agregarGrado()}/>
          </div>
          <div>
            <label style={L}>Nivel</label>
            <select style={{...I,cursor:'pointer'}} value={nivelG} onChange={e=>setNivelG(e.target.value)}>
              <option value="Primaria">Primaria</option>
              <option value="Secundaria">Secundaria</option>
            </select>
          </div>
          <button onClick={agregarGrado} style={{...btnBase,background:'var(--surface)',border:'1px solid var(--b1)',color:'var(--t2)',whiteSpace:'nowrap'}}>+ Agregar</button>
        </div>
        <p style={{fontSize:'12px',color:'var(--t3)',marginTop:'10px'}}>Precargados: Primaria 1°–6°, Secundaria 1°–5°</p>
      </Card>

      {/* Secciones */}
      <Card titulo="Secciones" desc="Agrega secciones adicionales (A, B y C ya están precargadas)">
        {msgS&&<Msg tipo={msgS.tipo} txt={msgS.txt}/>}
        <div style={{display:'flex',gap:'10px',alignItems:'flex-end'}}>
          <div style={{flex:1}}>
            <label style={L}>Nombre de la sección</label>
            <input style={I} value={nuevaS} onChange={e=>setNuevaS(e.target.value)} placeholder="Ej: D" onKeyDown={e=>e.key==='Enter'&&agregarSeccion()}/>
          </div>
          <button onClick={agregarSeccion} style={{...btnBase,background:'var(--surface)',border:'1px solid var(--b1)',color:'var(--t2)',whiteSpace:'nowrap'}}>+ Agregar</button>
        </div>
      </Card>

      {/* Info sistema */}
      <Card titulo="Información del sistema" desc="Detalles técnicos de la instalación">
        <div style={{display:'grid',gridTemplateColumns:'1fr 1fr',gap:'16px'}}>
          {[['Versión','1.0.0'],['Framework','Next.js 14'],['Base de datos','Neon PostgreSQL'],['Hosting','Vercel'],['Año activo',String(new Date().getFullYear())],['Niveles','Primaria · Secundaria']].map(([k,v])=>(
            <div key={k}>
              <div style={{fontSize:'10.5px',color:'var(--t3)',textTransform:'uppercase',letterSpacing:'.4px',marginBottom:'3px'}}>{k}</div>
              <div style={{fontSize:'13.5px',color:'var(--t1)'}}>{v}</div>
            </div>
          ))}
        </div>
      </Card>
    </div>
  )
}
