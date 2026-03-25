'use client'
import { useState } from 'react'
import Link from 'next/link'
import { usePathname, useRouter } from 'next/navigation'

const NAV = [
  { href:'/dashboard', exact:true, label:'Inicio',
    icon:<svg width="17" height="17" viewBox="0 0 17 17" fill="none"><rect x="1.5" y="1.5" width="6.5" height="6.5" rx="1.5" stroke="currentColor" strokeWidth="1.4"/><rect x="9" y="1.5" width="6.5" height="6.5" rx="1.5" stroke="currentColor" strokeWidth="1.4"/><rect x="1.5" y="9" width="6.5" height="6.5" rx="1.5" stroke="currentColor" strokeWidth="1.4"/><rect x="9" y="9" width="6.5" height="6.5" rx="1.5" stroke="currentColor" strokeWidth="1.4"/></svg> },
  { href:'/dashboard/estudiantes', exact:false, label:'Estudiantes',
    icon:<svg width="17" height="17" viewBox="0 0 17 17" fill="none"><circle cx="8.5" cy="5.5" r="3" stroke="currentColor" strokeWidth="1.4"/><path d="M2.5 15c0-3.314 2.686-5.5 6-5.5s6 2.186 6 5.5" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/></svg> },
  { href:'/dashboard/reportes', exact:false, label:'Reportes',
    icon:<svg width="17" height="17" viewBox="0 0 17 17" fill="none"><rect x="2.5" y="1.5" width="12" height="14" rx="2" stroke="currentColor" strokeWidth="1.4"/><path d="M5.5 6h6M5.5 9h6M5.5 12h4" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/></svg> },
  { href:'/dashboard/configuracion', exact:false, label:'Configuración',
    icon:<svg width="17" height="17" viewBox="0 0 17 17" fill="none"><circle cx="8.5" cy="8.5" r="2.5" stroke="currentColor" strokeWidth="1.4"/><path d="M8.5 1.5v1.8M8.5 13.7v1.8M1.5 8.5h1.8M13.7 8.5h1.8M3.56 3.56l1.27 1.27M12.17 12.17l1.27 1.27M3.56 13.44l1.27-1.27M12.17 4.83l1.27-1.27" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/></svg> },
]

export default function DashboardLayout({ children }: { children: React.ReactNode }) {
  const pathname = usePathname()
  const router   = useRouter()
  const [mobileOpen, setMobileOpen] = useState(false)

  async function logout() {
    await fetch('/api/auth/logout', { method:'POST' })
    router.push('/login')
  }

  const Sidebar = () => (
    <aside style={{
      width:'230px',
      minWidth:'230px',
      height:'100vh',
      background:'var(--surface)',
      borderRight:'1px solid var(--b1)',
      display:'flex',
      flexDirection:'column',
      padding:'16px 10px',
      position:'sticky',
      top:0
    }}>

      {/* 🔥 LOGO ACTUALIZADO */}
      <div style={{ display:'flex', alignItems:'center', gap:'12px', padding:'6px 10px 18px' }}>
        <div style={{
          width: '48px',
          height: '48px',
          background: 'var(--adim)',
          border: '1px solid rgba(240,165,0,.2)',
          borderRadius: '12px',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          flexShrink: 0,
          overflow: 'hidden',
          boxShadow: '0 4px 10px rgba(0,0,0,.2)'
        }}>
          <img
            src="/logo.png"
            alt="Logo IE"
            style={{
              width: '90%',
              height: '90%',
              objectFit: 'contain'
            }}
          />
        </div>

        <div>
          <div style={{ fontSize:'13px', fontWeight:600, color:'var(--t1)', lineHeight:1.2 }}>
            Sistema Escolar
          </div>
          <div style={{ fontSize:'10px', color:'var(--t3)', textTransform:'uppercase', letterSpacing:'.6px' }}>
            Secretaría
          </div>
        </div>
      </div>

      <div style={{ height:'1px', background:'var(--b1)', margin:'0 0 10px' }}/>
      <div style={{ fontSize:'9.5px', fontWeight:600, color:'var(--t3)', textTransform:'uppercase', letterSpacing:'1px', padding:'0 12px 8px' }}>
        Menú principal
      </div>

      <nav style={{ display:'flex', flexDirection:'column', gap:'2px' }}>
        {NAV.map(n => {
          const a = n.exact ? pathname===n.href : (pathname===n.href||pathname.startsWith(n.href+'/'))
          return (
            <Link key={n.href} href={n.href} onClick={()=>setMobileOpen(false)}
              style={{
                display:'flex',
                alignItems:'center',
                gap:'10px',
                padding:'9px 12px',
                borderRadius:'8px',
                textDecoration:'none',
                fontSize:'13px',
                color:a?'var(--t1)':'var(--t2)',
                fontWeight:a?500:400,
                background:a?'rgba(240,165,0,.08)':'transparent',
                position:'relative'
              }}>
              <span style={{ color:a?'var(--accent)':'var(--t3)', display:'flex' }}>{n.icon}</span>
              {n.label}
              {a && <div style={{ position:'absolute', right:0, top:'50%', transform:'translateY(-50%)', width:'3px', height:'18px', background:'var(--accent)' }}/>}
            </Link>
          )
        })}
      </nav>

      <div style={{ flex:1 }}/>
      <div style={{ height:'1px', background:'var(--b1)', margin:'8px 0' }}/>

      <div style={{ display:'flex', alignItems:'center', gap:'10px', padding:'6px 8px' }}>
        <div style={{
          width:'32px',
          height:'32px',
          borderRadius:'50%',
          background:'var(--adim)',
          display:'flex',
          alignItems:'center',
          justifyContent:'center',
          fontSize:'12px',
          fontWeight:600
        }}>
          S
        </div>

        <div style={{ flex:1 }}>
          <div style={{ fontSize:'12.5px', fontWeight:500 }}>Secretaria</div>
          <div style={{ fontSize:'10.5px', color:'var(--t3)' }}>Administrador</div>
        </div>

        <button onClick={logout} style={{ background:'none', border:'none', cursor:'pointer' }}>
          ⎋
        </button>
      </div>
    </aside>
  )

  return (
    <div style={{ display:'flex', minHeight:'100vh' }}>
      <Sidebar/>
      <div style={{ flex:1 }}>
        <main style={{ padding:'24px' }}>
          {children}
        </main>
      </div>
    </div>
  )
}