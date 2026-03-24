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
    <aside style={{ width:'230px', minWidth:'230px', height:'100vh', background:'var(--surface)', borderRight:'1px solid var(--b1)', display:'flex', flexDirection:'column', padding:'16px 10px', position:'sticky', top:0 }}>
      {/* Logo */}
      <div style={{ display:'flex', alignItems:'center', gap:'10px', padding:'6px 10px 18px' }}>
        <div style={{ width:'36px', height:'36px', background:'var(--adim)', border:'1px solid rgba(240,165,0,.2)', borderRadius:'10px', display:'flex', alignItems:'center', justifyContent:'center', flexShrink:0 }}>
          <svg width="20" height="20" viewBox="0 0 20 20" fill="none"><path d="M10 2.5L17 7v7l-7 4-7-4V7l7-4.5Z" stroke="#f0a500" strokeWidth="1.5" strokeLinejoin="round"/><circle cx="10" cy="10" r="2.5" fill="#f0a500"/></svg>
        </div>
        <div>
          <div style={{ fontSize:'12.5px', fontWeight:600, color:'var(--t1)', lineHeight:1.2 }}>Sistema Escolar</div>
          <div style={{ fontSize:'10px', color:'var(--t3)', textTransform:'uppercase', letterSpacing:'.6px' }}>Secretaría</div>
        </div>
      </div>

      <div style={{ height:'1px', background:'var(--b1)', margin:'0 0 10px' }}/>
      <div style={{ fontSize:'9.5px', fontWeight:600, color:'var(--t3)', textTransform:'uppercase', letterSpacing:'1px', padding:'0 12px 8px' }}>Menú principal</div>

      <nav style={{ display:'flex', flexDirection:'column', gap:'2px' }}>
        {NAV.map(n => {
          const a = n.exact ? pathname===n.href : (pathname===n.href||pathname.startsWith(n.href+'/'))
          return (
            <Link key={n.href} href={n.href} onClick={()=>setMobileOpen(false)}
              style={{ display:'flex', alignItems:'center', gap:'10px', padding:'9px 12px', borderRadius:'8px', textDecoration:'none', fontSize:'13px', color:a?'var(--t1)':'var(--t2)', fontWeight:a?500:400, background:a?'rgba(240,165,0,.08)':'transparent', position:'relative', transition:'background .12s' }}>
              <span style={{ color:a?'var(--accent)':'var(--t3)', display:'flex' }}>{n.icon}</span>
              {n.label}
              {a && <div style={{ position:'absolute', right:0, top:'50%', transform:'translateY(-50%)', width:'3px', height:'18px', background:'var(--accent)', borderRadius:'2px 0 0 2px' }}/>}
            </Link>
          )
        })}
      </nav>

      <div style={{ flex:1 }}/>
      <div style={{ height:'1px', background:'var(--b1)', margin:'8px 0' }}/>
      <div style={{ display:'flex', alignItems:'center', gap:'10px', padding:'6px 8px' }}>
        <div style={{ width:'32px', height:'32px', minWidth:'32px', borderRadius:'50%', background:'var(--adim)', border:'1px solid rgba(240,165,0,.25)', display:'flex', alignItems:'center', justifyContent:'center', fontSize:'12px', fontWeight:600, color:'var(--accent)' }}>S</div>
        <div style={{ flex:1, overflow:'hidden' }}>
          <div style={{ fontSize:'12.5px', fontWeight:500, color:'var(--t1)', whiteSpace:'nowrap', overflow:'hidden', textOverflow:'ellipsis' }}>Secretaria</div>
          <div style={{ fontSize:'10.5px', color:'var(--t3)' }}>Administrador</div>
        </div>
        <button onClick={logout} title="Cerrar sesión" style={{ background:'none', border:'none', cursor:'pointer', color:'var(--t3)', display:'flex', padding:'5px', borderRadius:'6px' }}>
          <svg width="15" height="15" viewBox="0 0 15 15" fill="none"><path d="M5.5 13H3a1 1 0 01-1-1V3a1 1 0 011-1h2.5M10 10.5L13 7.5 10 4.5M13 7.5H5.5" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round"/></svg>
        </button>
      </div>
    </aside>
  )

  return (
    <div style={{ display:'flex', minHeight:'100vh', background:'var(--bg)' }}>
      {mobileOpen && <div style={{ position:'fixed', inset:0, background:'rgba(0,0,0,.6)', zIndex:40 }} onClick={()=>setMobileOpen(false)}/>}
      <div style={{ display:'none' }} className="sidebar-desktop"><Sidebar/></div>
      <div style={{ display:'flex' }}><Sidebar/></div>

      <div style={{ flex:1, display:'flex', flexDirection:'column', minWidth:0 }}>
        <header style={{ height:'56px', borderBottom:'1px solid var(--b1)', display:'flex', alignItems:'center', padding:'0 24px', gap:'12px', background:'var(--surface)', position:'sticky', top:0, zIndex:30 }}>
          <div style={{ flex:1, fontSize:'13px' }}>
            {pathname==='/dashboard'
              ? <span style={{ fontWeight:500, color:'var(--t1)' }}>Inicio</span>
              : <><Link href="/dashboard" style={{ color:'var(--t3)', textDecoration:'none' }}>Inicio</Link><span style={{ color:'var(--t3)', margin:'0 8px' }}>/</span><span style={{ fontWeight:500, color:'var(--t1)' }}>{NAV.find(n=>n.href!=='/dashboard'&&pathname.startsWith(n.href))?.label}</span></>
            }
          </div>
          <div style={{ display:'flex', alignItems:'center', gap:'6px', padding:'5px 12px', background:'var(--card)', border:'1px solid var(--b1)', borderRadius:'8px', fontSize:'12.5px', color:'var(--t2)' }}>
            <svg width="13" height="13" viewBox="0 0 13 13" fill="none"><rect x=".5" y="2" width="12" height="10.5" rx="1.5" stroke="currentColor" strokeWidth="1.2"/><path d="M3.5.5v3M9.5.5v3M.5 6h12" stroke="currentColor" strokeWidth="1.2" strokeLinecap="round"/></svg>
            {new Date().getFullYear()}
          </div>
        </header>
        <main style={{ flex:1, padding:'26px 28px', overflowY:'auto', animation:'fadeIn .25s ease' }}>
          {children}
        </main>
      </div>
    </div>
  )
}
