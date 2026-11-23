# Side-profile statics/geometry check for the nested "FlatJack" stand.
# X = horizontal (backward +), Y = up. Table at Y=0. Units mm.
import math
t   = 6.0     # plate thickness (folded)
uF  = t/2     # foot hinge position along M (M-local u), axis at z=t/2
uH  = 26.3    # ledge hinge axis along M
alpha = 86.0  # ledge opening angle (deg, 90 = perpendicular to M)
rd  = 4.0     # ledge recess depth = lip height
p   = 63.5    # K hinge position along M
c   = 2.5     # K crossbar centre sits at M-local u=-c when folded  -> k = p+c
rc  = 1.75    # crossbar radius
Yc  = rc                             # crossbar rests on the table
k   = math.hypot(p + c, t/2 - rc)
def uL(tp):
    """phone bottom position along M: the ledge rises outward, phone sits on its front-bottom corner"""
    a = math.radians(alpha); zr = rd - t/2           # ledge surface, folded z_rel
    z_front = t/2 + tp                                # phone front face, z_rel
    return uH + (z_front - zr*math.cos(a))/math.tan(a) - zr*math.sin(a)
def M2W(u, z, th):                   # M-local -> world
    th = math.radians(th); du, dz = u-uF, z-t/2
    return (du*math.cos(th) - dz*math.sin(th), t/2 + du*math.sin(th) + dz*math.cos(th))
def solve(th, Hp=165, tp=9.5, Lp=22):
    Q = M2W(p, t/2, th)
    dy = Q[1]-Yc
    if dy > k: return None
    CX = Q[0] + math.sqrt(k*k-dy*dy)
    L = uL(tp)
    G  = M2W(L+Hp/2, t+tp/2, th)
    plug = M2W(L-Lp, t+tp/2-3.5, th)
    ledge = M2W(L, t, th)
    psi = math.degrees(math.atan2(dy, CX-Q[0]))   # K angle below horizontal
    return dict(slot=CX, G=G[0], margin=CX-G[0], plugY=plug[1], ledgeY=ledge[1], Kang=psi, uL=L)
if __name__ == "__main__":
    print("phone bottom along M: tp7.5 %.2f  tp9.5 %.2f  tp13 %.2f" % (uL(7.5), uL(9.5), uL(13)))
    for th in range(40, 85, 5):
        r = solve(th); rl = solve(th, Hp=75); rs = solve(th, Hp=147, tp=7.5)
        print(f"{th:2d}deg slot@{r['slot']:6.1f}  p165 margin {r['margin']:5.1f}  p147 {rs['margin']:5.1f}  land {rl['margin']:5.1f} landFront {rl['G']:5.1f}  plugY {r['plugY']:4.1f} (thin {rs['plugY']:4.1f})  ledgeY {r['ledgeY']:5.1f}")

