'use client'
import { useState } from 'react'
import { useRouter } from 'next/navigation'

export default function LoginPage() {
  const router = useRouter()
  const [usuario, setUsuario] = useState('')
  const [password, setPassword] = useState('')
  const [verPass, setVerPass] = useState(false)
  const [error, setError] = useState('')
  const [cargando, setCargando] = useState(false)

  async function submit(e: React.FormEvent) {
    e.preventDefault()
    if (!usuario || !password) { setError('Completa todos los campos'); return }
    setCargando(true); setError('')
    try {
      const r = await fetch('/api/auth/login', { method:'POST', headers:{'Content-Type':'application/json'}, body:JSON.stringify({usuario,password}) })
      const d = await r.json()
      if (!r.ok) setError(d.error || 'Credenciales incorrectas')
      else router.push('/dashboard')
    } catch { setError('Error de conexión') } finally { setCargando(false) }
  }

  const inp: React.CSSProperties = { width:'100%', padding:'11px 12px 11px 40px', background:'#1c2640', border:'1px solid rgba(255,255,255,.1)', borderRadius:'10px', color:'#f0f4ff', fontSize:'14px', fontFamily:'inherit', outline:'none' }

  return (
    <div style={{ minHeight:'100vh', background:'#0f1623', display:'flex', alignItems:'center', justifyContent:'center', padding:'20px', position:'relative', overflow:'hidden' }}>
      {/* Grid background */}
      <div style={{ position:'absolute', inset:0, backgroundImage:'linear-gradient(rgba(255,255,255,.025) 1px,transparent 1px),linear-gradient(90deg,rgba(255,255,255,.025) 1px,transparent 1px)', backgroundSize:'40px 40px', pointerEvents:'none' }}/>
      <div style={{ position:'absolute', top:'25%', left:'50%', transform:'translateX(-50%)', width:'500px', height:'200px', background:'radial-gradient(ellipse,rgba(240,165,0,.07) 0%,transparent 70%)', pointerEvents:'none' }}/>

      <div style={{ width:'100%', maxWidth:'380px', position:'relative', animation:'fadeIn .4s ease' }}>
        {/* Logo */}
        <div style={{ textAlign:'center', marginBottom:'32px' }}>
          <div style={{ width:'52px', height:'52px', background:'rgba(240,165,0,.1)', border:'1px solid rgba(240,165,0,.2)', borderRadius:'14px', display:'flex', alignItems:'center', justifyContent:'center', margin:'0 auto 14px' }}>
            <svg width="26" height="26" viewBox="0 0 26 26" fill="none"><path d="M13 3L20 7.5V16L13 21L6 16V7.5L13 3Z" stroke="#f0a500" strokeWidth="1.5" strokeLinejoin="round"/><circle cx="13" cy="12" r="3" fill="#f0a500"/></svg>
          </div>
          <h1 style={{ fontSize:'22px', fontWeight:600, color:'#f0f4ff', marginBottom:'4px' }}>Sistema Escolar</h1>
          <p style={{ fontSize:'12px', color:'#4a5578', textTransform:'uppercase', letterSpacing:'.8px' }}>Gestión de estudiantes</p>
        </div>

        {/* Card */}
        <div style={{ background:'#1c2640', border:'1px solid rgba(255,255,255,.07)', borderRadius:'20px', padding:'32px', boxShadow:'0 20px 60px rgba(0,0,0,.5)' }}>
          <h2 style={{ fontSize:'17px', fontWeight:600, color:'#f0f4ff', marginBottom:'4px' }}>Iniciar sesión</h2>
          <p style={{ fontSize:'12.5px', color:'#4a5578', marginBottom:'24px' }}>Ingresa tus credenciales para continuar</p>

          <form onSubmit={submit} style={{ display:'flex', flexDirection:'column', gap:'16px' }}>
            <div>
              <label style={{ fontSize:'11.5px', fontWeight:500, color:'#8b9cc8', display:'block', marginBottom:'6px', textTransform:'uppercase', letterSpacing:'.3px' }}>Usuario</label>
              <div style={{ position:'relative' }}>
                <span style={{ position:'absolute', left:'12px', top:'50%', transform:'translateY(-50%)', color:'#4a5578' }}>
                  <svg width="15" height="15" viewBox="0 0 15 15" fill="none"><circle cx="7.5" cy="5" r="3" stroke="currentColor" strokeWidth="1.3"/><path d="M2 13c0-3 2.5-4.5 5.5-4.5S13 10 13 13" stroke="currentColor" strokeWidth="1.3" strokeLinecap="round"/></svg>
                </span>
                <input type="text" style={inp} value={usuario} onChange={e=>setUsuario(e.target.value)} placeholder="Tu usuario" autoComplete="username" autoFocus/>
              </div>
            </div>
            <div>
              <label style={{ fontSize:'11.5px', fontWeight:500, color:'#8b9cc8', display:'block', marginBottom:'6px', textTransform:'uppercase', letterSpacing:'.3px' }}>Contraseña</label>
              <div style={{ position:'relative' }}>
                <span style={{ position:'absolute', left:'12px', top:'50%', transform:'translateY(-50%)', color:'#4a5578' }}>
                  <svg width="15" height="15" viewBox="0 0 15 15" fill="none"><rect x="2.5" y="6.5" width="10" height="7" rx="1.5" stroke="currentColor" strokeWidth="1.3"/><path d="M5 6.5V4.5a2.5 2.5 0 015 0v2" stroke="currentColor" strokeWidth="1.3" strokeLinecap="round"/></svg>
                </span>
                <input type={verPass?'text':'password'} style={{ ...inp, paddingRight:'40px' }} value={password} onChange={e=>setPassword(e.target.value)} placeholder="Tu contraseña" autoComplete="current-password"/>
                <button type="button" onClick={()=>setVerPass(!verPass)} style={{ position:'absolute', right:'10px', top:'50%', transform:'translateY(-50%)', background:'none', border:'none', cursor:'pointer', color:'#4a5578', display:'flex', padding:'4px' }}>
                  <svg width="15" height="15" viewBox="0 0 15 15" fill="none"><path d={verPass?"M2 2l11 11M6.2 6.3A2 2 0 009.5 9M3 6.5S5 3 7.5 3s4.5 3.5 4.5 3.5-1 2-2.8 3":"M1.5 7.5S4 3 7.5 3s6 4.5 6 4.5-2.5 4.5-6 4.5S1.5 7.5 1.5 7.5z"} stroke="currentColor" strokeWidth="1.3" strokeLinecap="round"/>{!verPass&&<circle cx="7.5" cy="7.5" r="1.5" stroke="currentColor" strokeWidth="1.3"/>}</svg>
                </button>
              </div>
            </div>

            {error && (
              <div style={{ display:'flex', alignItems:'center', gap:'8px', padding:'10px 14px', background:'rgba(239,68,68,.08)', border:'1px solid rgba(239,68,68,.2)', borderRadius:'9px', fontSize:'13px', color:'#ef4444' }}>
                <svg width="14" height="14" viewBox="0 0 14 14" fill="none"><circle cx="7" cy="7" r="6" stroke="#ef4444" strokeWidth="1.3"/><path d="M7 4.5v3M7 9.5v.5" stroke="#ef4444" strokeWidth="1.3" strokeLinecap="round"/></svg>
                {error}
              </div>
            )}

            <button type="submit" disabled={cargando} style={{ width:'100%', padding:'12px', background:'#f0a500', color:'#0f1623', border:'none', borderRadius:'10px', fontSize:'14px', fontWeight:600, fontFamily:'inherit', cursor:cargando?'not-allowed':'pointer', opacity:cargando?.7:1, display:'flex', alignItems:'center', justifyContent:'center', gap:'8px', marginTop:'4px' }}>
              {cargando ? <><span style={{ width:'16px', height:'16px', border:'2px solid rgba(15,22,35,.3)', borderTopColor:'#0f1623', borderRadius:'50%', animation:'spin .7s linear infinite', display:'inline-block' }}/> Ingresando...</> : <>Ingresar al sistema <svg width="16" height="16" viewBox="0 0 16 16" fill="none"><path d="M3 8h10M9 4l4 4-4 4" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/></svg></>}
            </button>
          </form>
        </div>
        <p style={{ textAlign:'center', fontSize:'12px', color:'#4a5578', marginTop:'20px' }}>© {new Date().getFullYear()} Sistema de Gestión Escolar</p>
      </div>
    </div>
  )
}
