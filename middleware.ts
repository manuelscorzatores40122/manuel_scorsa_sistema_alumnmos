import { NextRequest, NextResponse } from 'next/server'
export function middleware(req: NextRequest) {
  const { pathname } = req.nextUrl
  const session = req.cookies.get('session')
  const publica = pathname.startsWith('/login') || pathname.startsWith('/api/auth')
  if (publica) {
    if (session && pathname.startsWith('/login'))
      return NextResponse.redirect(new URL('/dashboard', req.url))
    return NextResponse.next()
  }
  if (!session) return NextResponse.redirect(new URL('/login', req.url))
  return NextResponse.next()
}
export const config = { matcher: ['/((?!_next/static|_next/image|favicon.ico).*)'] }
