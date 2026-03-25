'use client'
import { useState } from 'react'
import { useRouter } from 'next/navigation'

export default function LoginPage() {
  const router = useRouter()
  const [usuario, setUsuario] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [cargando, setCargando] = useState(false)

  async function submit(e: React.FormEvent) {
    e.preventDefault()

    if (!usuario || !password) {
      setError('Completa todos los campos')
      return
    }

    setCargando(true)
    setError('')

    try {
      const r = await fetch('/api/auth/login', {
        method:'POST',
        headers:{'Content-Type':'application/json'},
        body: JSON.stringify({ usuario, password })
      })

      const d = await r.json()

      if (!r.ok) {
        setError(d.error || 'Credenciales incorrectas')
      } else {
        router.push('/dashboard')
      }

    } catch {
      setError('Error de conexión')
    } finally {
      setCargando(false)
    }
  }

  const inp: React.CSSProperties = {
    width:'100%',
    padding:'12px',
    background:'#1c2640',
    border:'1px solid rgba(255,255,255,.1)',
    borderRadius:'10px',
    color:'#f0f4ff',
    fontSize:'14px',
    outline:'none'
  }

  return (
    <div style={{
      minHeight:'100vh',
      background:'#0f1623',
      display:'flex',
      alignItems:'center',
      justifyContent:'center',
      padding:'20px'
    }}>

      <div style={{ width:'100%', maxWidth:'380px' }}>

        {/* 🔥 LOGO + TITULO */}
        <div style={{ textAlign:'center', marginBottom:'28px' }}>

         

          <h1 style={{
            fontSize:'22px',
            fontWeight:600,
            color:'#e8ec00',
            marginBottom:'4px'
          }}>
            MANUEL SCORZA TORRES
          </h1>

          <p style={{
            fontSize:'12px',
            color:'#4a5578',
            textTransform:'uppercase',
            letterSpacing:'.8px'
          }}>
            GESTIÓN DE ESTUDIANTES
          </p>

        </div>

        {/* 🔥 CARD LOGIN */}
        <div style={{
          background:'#1c2640',
          border:'1px solid rgba(255,255,255,.07)',
          borderRadius:'20px',
          padding:'30px',
          boxShadow:'0 20px 60px rgba(0,0,0,.5)'
        }}>

          <h2 style={{
            fontSize:'17px',
            fontWeight:600,
            color:'#f0f4ff',
            marginBottom:'20px'
          }}>
            Iniciar sesión
          </h2>

          <form onSubmit={submit} style={{ display:'flex', flexDirection:'column', gap:'15px' }}>

            <input
              type="text"
              placeholder="Usuario"
              value={usuario}
              onChange={e => setUsuario(e.target.value)}
              style={inp}
            />

            <input
              type="password"
              placeholder="Contraseña"
              value={password}
              onChange={e => setPassword(e.target.value)}
              style={inp}
            />

            {error && (
              <div style={{ color:'#ef4444', fontSize:'13px' }}>
                {error}
              </div>
            )}

            <button
              type="submit"
              disabled={cargando}
              style={{
                padding:'12px',
                background:'#0ae034',
                color:'#0f1623',
                border:'none',
                borderRadius:'10px',
                fontSize:'14px',
                fontWeight:600,
                cursor:cargando?'not-allowed':'pointer'
              }}
            >
              {cargando ? 'Ingresando...' : 'Ingresar'}
            </button>

          </form>
        </div>

        {/* FOOTER */}
        <p style={{
          textAlign:'center',
          fontSize:'12px',
          color:'#ffffff',
          marginTop:'20px'
        }}>
          © {new Date().getFullYear()} Sistema de Gestión Escolar
        </p>

      </div>
    </div>
  )
}