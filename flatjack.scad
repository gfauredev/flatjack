// FlatJack — one-piece, print-in-place folding phone stand
// Size is parametric (Size tab): default 70 x 32 x 6 mm (13.4 mL bounding box, two-material)
// Tilts: slots made for each wanted angle that fits (default 45 50 55 60 65 75 80 deg), portrait + landscape, USB-C friendly.
// Print flat as-is (view = print), no supports. PLA or PETG, 0.2 mm layers.
// All parts nest in one 6 mm layer, joined by captive bridged axles (3 hinges) and pins (ledge).
// Customizer: Window > Customizer. Descriptions sit on the line above each parameter.

/* [View] */
// What to show: the print plate (folded), the stand set up with a dummy phone, the parts lifted apart, or the hinge test coupon
view = "print"; // [print:Print plate (folded), deployed:Set up with phone, exploded:Exploded parts, hinge_test:Hinge test coupon]
// Tilt shown in the set-up view (snaps to the nearest angle that has a slot)
preview_tilt = 60; // [40:1:85]
// Show a dummy phone and USB-C plug in the set-up view
show_phone = true;
// Dummy phone in landscape instead of portrait
phone_landscape = false;

/* [Size] */
// Folded card length (mm). Extra length goes into the tie, kickstand and back-rest (bigger footprint) and the top bar; a shorter card shortens the tie, kickstand and back-rest
card_length = 70; // [66:0.25:90]
// Folded card width (mm). Extra width is shared by every part across the card: plug gap and tie, ledge prongs, back-rest rails, kickstand arms
card_width = 40; // [26:0.1:60]
// Card thickness (mm). Snapped to a whole number of layers (see Print fit)
thickness = 6; // [4:0.1:10]
// Smallest gap between the ledge prongs, for the USB-C plug (it grows with the card width)
min_plug_gap = 13; // [10:0.5:18]
// Tilt angles you want. Each one that fits gets a slot; the others are skipped (listed in the console)
wanted_tilts = [40, 45, 50, 55, 60, 65, 70, 75, 80]; // NOTE In default length, 70° falls in T1/T2 hinge, hence automatically skipped

/* [Ledge] */
// How the two ledge prongs are tied together. Root link: a bar at the prong roots, the cable slides in from the front. Front pull bar: bar at the tips (closed loop, cable must be threaded). None: independent prongs
ledge_linking = "root"; // [root:Root link (cable friendly), front:Front pull bar, none:Independent prongs]
// Height of the ledge hinge up the back-rest (sets how high the phone sits, i.e. USB-C plug clearance)
ledge_height = 27; // [20:0.1:32]
// Room for the phone between the back-rest and the lip (phone + case thickness)
ledge_depth = 14; // [8:0.5:18]
// Material left under the phone in each prong. The lip is always as tall as the thickness allows: lip = thickness - this
ledge_floor_thickness = 2.0; // [1.5:0.1:3]
// Thickness of the lip at the front of the ledge
lip_thickness = 2.5; // [1:0.1:4]
// Angle the ledge opens to, where it rests on its stop (90 = square to the back-rest; less tips the phone back onto it)
ledge_angle = 87; // [75:0.5:90]

/* [Materials (multi-tool printers)] */
// Which material to render/export. Export one STL per material, load them as parts of one object in the slicer and assign tools. All = everything (preview)
export_material = "all"; // [all:All materials, 1:Material 1 - rigid A (PLA): back-rest + T2, 2:Material 2 - rigid B (PETG): kickstand + ledge + T1, 3:Material 3 - flexible (TPU): pads + catches + labels]
// Two rigid materials that do not bond (e.g. PLA + PETG): every hinge pairs A with B, so clearances can be tight and axles print resting on their bores (no bridging)
two_rigid_materials = false;
// Side gap between parts of different rigid materials
gap_between_materials = 0.1; // [0.05:0.05:0.35]
// Axle clearance between parts of different rigid materials (radial)
axle_clearance_between_materials = 0.1; // [0.05:0.05:0.4]
// TPU grip pads: phone-back strips on the back-rest, soft inner face on the lips, feet under the tie (flush inlays)
grip_pads = false;
// Depth of the TPU pad inlays
pad_depth = 0.6; // [0.4:0.2:1.2]
// TPU snap catches that keep the folded card shut: kickstand, T1, T2 and ledge each click into place
snap_catches = false;
// How far each catch bump reaches into its recess (firmer click when larger)
catch_strength = 0.4; // [0.2:0.05:0.8]
// Tilt angle written on the tie, on the stop wall right behind each slot. Inlay = flush TPU, engrave = cut 0.6 mm deep
angle_labels = "none"; // [inlay:Inlaid (TPU), engrave:Engraved, none:None]
// Extra stroke thickness on each side of the label digits (0.22 gives ~0.7 mm strokes with open 0, 6, 8)
label_boldness = 0.22; // [0:0.02:0.4]

/* [Print fit] */
// Your slicer's layer height. Thickness, slot heights, air gaps, pad and label depths are snapped to whole layers
layer_height = 0.2; // [0.08:0.02:0.32]
// Gap between parts of the same material (side by side and end to end)
part_gap = 0.35; // [0.2:0.05:0.6]
// Axle clearance between parts of the same material (radial), single-material prints
axle_clearance = 0.40; // [0.2:0.05:0.7]
// Radius of every hinge axle and pin
axle_radius = 1.5; // [1:0.05:2]
// Circle smoothness (segments per full circle)
resolution = 40; // [24:8:96]

/* [Advanced] */
// Kickstand foot (crossbar) distance ahead of the back-rest heels when folded
kick_foot_offset = 2.35; // [2:0.05:5]
// Kickstand foot (crossbar) radius. It rests on the table across the full width; the tie's slots straddle it
kick_foot_radius = 1.75; // [1.25:0.05:2.25]
// Length over which the kickstand arms slope down into the foot (keeps the foot the lowest point)
kick_foot_taper = 4; // [3:0.5:6]
// Air gap between the ledge root link and the floor of the tie slot it rests in
link_air_gap = 0.5; // [0.3:0.05:0.8]
// Where T2's free end sits when folded (the T1 heel bar ends one gap before it)
tie_end_position = 6.2; // [5:0.1:10]

/* [Hidden] */
// ---- internal names ----
mode = view;
tilt_req = preview_tilt;
phone = show_phone;
landscape = phone_landscape;
function lay_round(z) = max(1, round(z / layer_height)) * layer_height; // nearest whole layer
function lay_up(z) = max(1, ceil(z / layer_height - 1e-6)) * layer_height; // at least z, whole layers
t = lay_round(thickness);
ledge_link = ledge_linking;
uH = ledge_height;
ledge_web = lay_round(ledge_floor_thickness);
lipw = lip_thickness;
material = export_material;
dual_material = two_rigid_materials;
g_nb = gap_between_materials;
ca_nb = axle_clearance_between_materials;
pads = grip_pads;
pad_t = lay_up(pad_depth);
catches = snap_catches;
catch_grip = catch_strength;
label_mode = angle_labels;
label_grow = label_boldness;
g = part_gap;
ca = axle_clearance;
ra = axle_radius;
cK = kick_foot_offset;
rc = kick_foot_radius;
k_taper = kick_foot_taper;
zgLk = lay_up(link_air_gap);
uT2end = tie_end_position;
$fn = resolution;
only = ""; // set-up view: export a single part (debug)
linked = ledge_link == "front";
ax = t / 2; // hinge axis height (mid-thickness)
lip = t - ledge_web; // lip height above the ledge surface = recess depth (max for the thickness)
// gaps: parts of different rigid materials can sit closer (dual_material)
gMP = dual_material ? g_nb : g; // ledge prong | M rail
gMK = dual_material ? g_nb : g; // M rail | K arm
gT = dual_material ? g_nb : g; // T1 arm | T2
caE = dual_material ? ca_nb : ca; // axle clearance actually used
gTM = dual_material ? g_nb : g; // T1 arm | M legs and M filler (side), where T1 does not face the prongs
gPe = dual_material ? g_nb : 0.3; // ledge prong root / tip | M (end gaps), and the ledge stop face
// Stop face slant: the ledge's back face rotates past the face's angle by d before closing the gap gPe
// (contact near the top face: s*sin(d) + R*cos(d) = R + gPe, with s = R*tan(angle/2), R = t/2)
lsR = t / 2;
lsS = lsR * tan(ledge_angle / 2);
ledge_face = ledge_angle - (lsS - sqrt(lsS * lsS - 2 * lsR * gPe)) / lsR * 180 / PI;
ledge_open = ledge_angle - 0.5; // drawn just short of the stop
// ---- width: every band across the card scales by the same factor ----
BASE_BANDS = [min_plug_gap / 2, 2.8, 2.4, 2.8]; // half plug gap (tie inside), prong, M rail, K arm
w_min = 2 * (BASE_BANDS[0] + BASE_BANDS[1] + BASE_BANDS[2] + BASE_BANDS[3] + gMP + gMK);
w_s = max(1, (card_width / 2 - gMP - gMK) / (BASE_BANDS[0] + BASE_BANDS[1] + BASE_BANDS[2] + BASE_BANDS[3]));
// y bands (half widths)
yC = BASE_BANDS[0] * w_s; // plug gap half width
yP = yC + BASE_BANDS[1] * w_s; // prong outer face
yMi = yP + gMP; // M rail inner
yMo = yMi + BASE_BANDS[2] * w_s; // M rail outer
yKi = yMo + gMK; // K arm inner
yKo = yKi + BASE_BANDS[3] * w_s; // K arm outer  (= card_width/2)
yT1 = yC - g; // T1 outer (T1 and the prongs are the same material: keep g)
yT1i = yT1 - 3.0 * w_s; // T1 arm inner (3 mm arms at base width: room for a centred digit)
yT2 = yT1i - gT; // T2 outer
// material of each rigid part (1 = A, 2 = B)
function mat(part) = !dual_material ? 1 : (part == "M" || part == "T2") ? 1 : 2;

// ---- length: extra length stretches the tie / kickstand / back-rest (about 85 %) and the top bar (rest) ----
// The split is fine-tuned so one wanted tilt's T2 slot lands exactly on the ledge hinge, where the ledge
// root link rests in it (otherwise that link would need an odd-angle slot that crowds out its neighbours).
BASE_UT = 56.5;
BASE_TOPBAR = t; // top bar at least as long as the card is thick (holds the kickstand knuckle)
uF = t / 2; // foot hinge axis (M <-> T1)
uT_off = t / 2 + 0.4 + (linked ? 2.95 : 0); // tie hinge -> top bar start (tie knuckle ends 0.4 mm before it)
L_base = cK + rc + BASE_UT + uT_off + BASE_TOPBAR;
L_delta = card_length - L_base; // may be negative: a shorter card shortens the tie and kickstand
L_extra = max(0, L_delta);
UT_LO = BASE_UT + min(0, L_delta);
UT_HI = BASE_UT + L_delta; // tie hinge range (top bar >= base)
// kinematics as a function of the tie hinge position x (the top bar takes the rest of the length)
function topbar_x(x) = BASE_TOPBAR + L_delta - (x - BASE_UT);
function p_x(x) = x + uT_off + topbar_x(x) / 2;
function kL_x(x) = sqrt(pow(p_x(x) + cK, 2) + pow(t / 2 - rc, 2));
function slotX_x(a, x) = let (q = [(p_x(x) - uF) * cos(a), t / 2 + (p_x(x) - uF) * sin(a)], dy = q[1] - rc) q[0] + sqrt(pow(kL_x(x), 2) - dy * dy);
function t2u_x(a, x) = 2 * x - uF - slotX_x(a, x); // T2 slot centre (folded u) for tie hinge x
function solve_x(a, lo, hi, n = 40) =
  n == 0 ? (lo + hi) / 2
  : let (m = (lo + hi) / 2) (t2u_x(a, m) < uH ? solve_x(a, m, hi, n - 1) : solve_x(a, lo, m, n - 1));
UT_TARGET = UT_LO + 0.85 * (UT_HI - UT_LO);
UT_CANDS =
  (ledge_link != "root" || UT_HI - UT_LO < 0.5) ? []
  : [
    for (a = wanted_tilts) let (x = solve_x(a, UT_LO, UT_HI)) if (abs(t2u_x(a, x) - uH) < 0.05 && topbar_x(x) >= BASE_TOPBAR) x,
  ];
// u stations (x when folded)
uT =
  len(UT_CANDS) == 0 ? UT_TARGET
  : let (d = [for (x = UT_CANDS) abs(x - UT_TARGET)], m = min(d)) [for (i = [0:len(d) - 1]) if (d[i] == m) UT_CANDS[i]][0];
top_bar = topbar_x(uT);
uPt = uH + t / 2 + ledge_depth + lipw; // prong tip
uBar0 = uT + t / 2 + g;
uBar1 = uBar0 + 2.2; // ledge pull bar (front link), just above the tie ends
uTop0 = uT + uT_off;
uTop1 = uTop0 + top_bar; // M top crossbar
p = uTop0 + top_bar / 2; // M <-> K hinge axis: through-axle inside M top bar
sw = 2 * rc + 0.6; // slot width
sd = lay_up(2 * rc + 0.3); // slot height (cut from the tie's deployed underside), whole layers
Yc = rc; // crossbar centre height: it rests on the table
kL = sqrt(pow(p + cK, 2) + pow(ax - rc, 2)); // hinge axis -> crossbar axis
kdel = atan2(ax - rc, p + cK); // crossbar sits below K's centre line (touches the print bed)
// TPU catches: [host, guest, u, host face y, direction to guest, gap, bump radius]  (+y side; mirrored)
emb = 1.5; // bump embedded depth in its host
ccl = 0.25; // clearance around a bump in its recess
CATCHES = [
  ["M", "K", 10, yMo, 1, gMK, 1.0],
  ["M", "T1", 16, yC, -1, gTM, 1.0],
  ["M", "P", uPt - lipw / 2, yMi, -1, gMP, 0.8],
  ["T1", "T2", 11, yT1i, -1, gT, 1.0],
];

// ---------------- helpers ----------------
module box(u0, u1, y0, y1, z0 = 0, z1 = t) { translate([u0, y0, z0]) cube([u1 - u0, y1 - y0, z1 - z0]); }
module sym_box(u0, u1, a, b) { box(u0, u1, a, b); box(u0, u1, -b, -a); }
// bar whose end(s) are semicircles about a hinge axis
module knuckle_bar(u0, u1, y0, y1, round0 = false, round1 = false) {
  hull() {
    box(round0 ? u0 + t / 2 : u0, round1 ? u1 - t / 2 : u1, y0, y1);
    if (round0) translate([u0 + t / 2, y0, ax]) rotate([-90, 0, 0]) cylinder(r=t / 2, h=y1 - y0);
    if (round1) translate([u1 - t / 2, y0, ax]) rotate([-90, 0, 0]) cylinder(r=t / 2, h=y1 - y0);
  }
}
module sym() { children(); mirror([0, 1, 0]) children(); }
// Hinges: cylindrical axles along y (no cones -> radial load cannot wedge parts apart).
// Profiles are drawn in (u, -z) and extruded along +y from y0 to y1.
module along_y(y0, y1) { translate([0, y0, 0]) rotate([-90, 0, 0]) linear_extrude(y1 - y0) children(); }
// axle: circle with a flat bottom so it bridges cleanly when printed
// dual_material: full round axle, offset down by its clearance so it prints resting on the bore
// floor of the other (non-bonding) material -> no bridge at all
module axle(u, y0, y1) {
  along_y(y0, y1) if (dual_material)
    translate([u, -(ax - caE)]) circle(r=ra);
  else
    intersection() {
      translate([u, -ax]) circle(r=ra);
      translate([u - 5, -(ax - 0.7 * ra) - 10]) square([10, 10]);
    }
}
// bore: circle + 45-deg teardrop roof (prints without support), roof clipped 0.6 mm under the top
// (bore drops 0.3 mm extra below the axis: ~1.1 mm of air under the bridged axle for sag)
module bore(u, y0, y1) {
  along_y(y0 - 0.01, y1 + 0.01) intersection() {
      hull() {
        translate([u, -ax]) circle(r=ra + caE);
        translate([u, -ax + (dual_material ? 0 : 0.3)]) circle(r=ra + caE);
        translate([u, -(ax + (ra + caE) * sqrt(2))]) square(0.01, center=true);
      }
      translate([u - 5, -(t - 0.6)]) square([10, 10]);
    }
}
module slot_at(u, zTop = true) {
  // slot across, cut from top (zTop) or bottom face
  translate([u - sw / 2, -20, zTop ? t - sd : -0.01]) cube([sw, 40, sd + 0.01]);
}

// ---------------- slot table (computed from the side-profile kinematics) ----------
function Q(th) = [(p - uF) * cos(th), ax + (p - uF) * sin(th)];
function slotX(th) = let (q = Q(th), dy = q[1] - Yc) q[0] + sqrt(kL * kL - dy * dy);
function beta(th) = let (q = Q(th), dy = q[1] - Yc) atan2(dy, slotX(th) - q[0]);
// Which wanted tilts fit: T1 carries the steep ones (slots in front of the T2 knuckle), T2 the shallow
// ones (behind its hinge bore, before its rounded end). The ledge root link gets a slot of its own,
// centred exactly on the ledge hinge (its angle is solved for), and wanted angles too close to it are dropped.
T2_END_X = 2 * uT - uF - uT2end - t / 2; // start of T2's rounded end (deployed X)
T1_END_X = uT - uF - t / 2 - 0.3; // before the T2 knuckle
T1_MIN_X = uH - uF + sw + 1.5; // clear of T1's link notch
T1_MAX_X = uT - uF - t / 2 - sw / 2;
T2_MIN_X = uT - uF + ra + caE + 1.0 + sw / 2;
T2_MAX_X = T2_END_X - sw / 2 - 1.0;
function t2_slot_u(a) = 2 * uT - uF - slotX(a);
function solve_tilt(X, lo = 20, hi = 89.5, n = 40) =
  n == 0 ? (lo + hi) / 2
  : let (m = (lo + hi) / 2) (slotX(m) > X ? solve_tilt(X, m, hi, n - 1) : solve_tilt(X, lo, m, n - 1));
LINK_EXACT = solve_tilt(2 * uT - uF - uH); // angle whose slot is centred on the hinge
LINK_NEAR = let (d = [for (a = wanted_tilts) abs(slotX(a) - slotX(LINK_EXACT))], m = min(d)) [for (i = [0:len(d) - 1]) if (d[i] == m) wanted_tilts[i]][0];
// use that wanted angle if its slot is within 1 mm of the hinge, else the nearest whole degree
LINK_A = ledge_link != "root" ? -1 : abs(slotX(LINK_NEAR) - slotX(LINK_EXACT)) <= 1.0 ? LINK_NEAR : round(LINK_EXACT);
link_ok = ledge_link != "root" || (slotX(LINK_A) >= T2_MIN_X && slotX(LINK_A) <= T2_MAX_X);
function ok1(a) = slotX(a) >= T1_MIN_X && slotX(a) <= T1_MAX_X;
function ok2(a) = slotX(a) >= T2_MIN_X && slotX(a) <= T2_MAX_X && (ledge_link != "root" || abs(slotX(a) - slotX(LINK_A)) >= sw + 2.0);
T1_angles = [for (a = wanted_tilts) if (ok1(a)) a];
T2_angles = concat([for (a = wanted_tilts) if (ok2(a)) a], (ledge_link == "root" && link_ok) ? [LINK_A] : []);
ALL_TILTS = concat(T1_angles, T2_angles);
echo(str("FlatJack ", card_length, " x ", 2 * yKo, " x ", t, " mm = ", round(card_length * 2 * yKo * t / 100) / 10, " mL"));
echo(
  str(
    "Tilt slots: T1 ", T1_angles, "  T2 ", [for (a = T2_angles) round(a * 10) / 10],
    "  skipped: ", [for (a = wanted_tilts) if (!ok1(a) && !ok2(a) && a != LINK_A) a]
  )
);
if (!link_ok) echo("WARNING: the ledge link slot does not fit on T2 at this size");
echo(
  str(
    "Sideways support (half-widths): phone on ledge +/-", round(yP * 10) / 10, " mm, front feet +/-", round(yMo * 10) / 10,
    " mm, rear foot +/-", round(yKo * 10) / 10, " mm"
  )
);
// Stability report (side profile, 250 g phone): distance from the phone's centre of gravity to the rear
// tipping line (crossbar) and, for landscape, to the front edge (heels).
function phone_uL(tp) = uH + (t / 2 + tp - (lip - t / 2) * cos(ledge_open)) / tan(ledge_open) - (lip - t / 2) * sin(ledge_open);
function m2w_x(u, z, th) = (u - uF) * cos(th) - (z - t / 2) * sin(th);
function cg_x(th, Hp, tp) = m2w_x(phone_uL(tp) + Hp / 2, t + tp / 2, th);
for (a = ALL_TILTS)
  echo(
    str(
      "  tilt ", round(a), ": rear margin ", round(slotX(a) - cg_x(a, 165, 9.5)), " mm (165 mm phone, portrait), front margin ",
      round(cg_x(a, 77, 9.5) * 10) / 10, " mm (landscape)"
    )
  );
if (card_width < w_min - 0.01) echo(str("NOTE: card_width below the minimum ", w_min, " mm, using the minimum"));
if (abs(t - thickness) > 0.001) echo(str("NOTE: thickness snapped to ", t, " mm (whole ", layer_height, " mm layers)"));
// Root link: rests in its own T2 slot (see above) and fills it, minus gaps; T1 gets one matching notch.
LK_U = t2_slot_u(LINK_A); // centre of that slot (folded u) = ledge hinge
uLk0 = LK_U - sw / 2 + g;
uLk1 = LK_U + sw / 2 - g; // link span along u
zLk0 = t - sd + zgLk; // link underside (slot floor + air gap)
module link_notch_T1() { if (ledge_link == "root") slot_at(LK_U, true); }

// ---------------- TPU catches and pads (3rd material) ----------------
// A catch = a TPU bump embedded in a host part, reaching across the gap into a recess in the guest part.
// Folding the guest in or out makes the recess rim ride over the cone-shaped bump: a soft click.
module along_dir(yf, dir) { translate([0, yf, 0]) mirror([0, dir < 0 ? 1 : 0, 0]) children(); }
function bump_r(r, gap, s) = r - 0.5 * r * s / (gap + catch_grip);
module catch_bump(c) {
  along_dir(c[3], c[4]) translate([c[2], 0, ax]) rotate([-90, 0, 0]) {
        translate([0, 0, -emb]) cylinder(r=c[6], h=emb + 0.01);
        cylinder(r1=c[6], r2=bump_r(c[6], c[5], c[5] + catch_grip), h=c[5] + catch_grip);
      }
}
module catch_pocket(c) {
  along_dir(c[3], c[4]) translate([c[2], 0, ax]) rotate([-90, 0, 0])
        translate([0, 0, -emb - 0.01]) cylinder(r=c[6], h=emb + 0.02);
}
module catch_recess(c) {
  along_dir(c[3], c[4]) translate([c[2], 0, ax]) rotate([-90, 0, 0]) hull() {
          translate([0, 0, c[5] - 0.01]) cylinder(r=bump_r(c[6], c[5], c[5]) + ccl, h=0.01);
          translate([0, 0, c[5] + catch_grip + ccl]) cylinder(r=bump_r(c[6], c[5], c[5] + catch_grip) + ccl, h=0.01);
        }
}
module catches_of_host(h) { if (catches) for (c = CATCHES) if (c[0] == h) sym() catch_bump(c); }
module pockets_of_host(h) { if (catches) for (c = CATCHES) if (c[0] == h) sym() catch_pocket(c); }
module recesses_of_guest(gp) { if (catches) for (c = CATCHES) if (c[1] == gp) sym() catch_recess(c); }

// Pads: flush TPU inlays (the pocket in the host and the pad are the same shape)
module pads_of(h) {
  if (pads) {
    if (h == "M") sym() box(uPt + g + 1, uTop0 - 1, linked ? yMi + 0.4 : yC + 0.5, yMo - 0.4, t - pad_t, t); // phone-back strips
    if (h == "P") sym() box(uPt - lipw, uPt - lipw + 0.8, yC + 0.4, yP - 0.9, 0, lip); // soft inner face of each lip
    if (h == "T1") sym() box(uH + sw / 2 + 1, min(uH + 9, uF + min(concat([for (a = T1_angles) slotX(a)], [99])) - sw / 2 - 1), yT1i + 0.4, yT1 - 0.4, 0, pad_t); // feet (deployed bottom)
    if (h == "T2") box(uT2end + 1.5, min(12.8, min(concat([for (a = T2_angles) t2_slot_u(a)], [99])) - sw / 2 - 1), -yT2 + 0.5, yT2 - 0.5, t - pad_t, t); // rear foot (top when folded)
  }
}
// Tilt labels, built in deployed tie coordinates (top face up, text readable from the front of the stand),
// then mapped back to each part's folded print position. T2 digits sit side by side; on T1 one digit
// per arm (the centre is open once T2 is flipped out).
label_d = lay_up(0.6);
function next_rear(X, xs, lim) = min(concat([for (v = xs) if (v > X + 0.1) v - sw / 2], [lim]));
// Digits are placed one by one, centred on their measured outline (Liberation Sans Regular:
// ink width ~0.66 x size, ink centre offset ~0.01 x size), then grown by label_grow.
DIG_W = 0.66; // ink width / size
lab_m = 0.45; // minimum wall beside a label (engraving)
module digit2d(ch, h, wx) {
  offset(r=label_grow) scale([wx, 1])
      translate([-(ch == "1" ? 0.028 : 0.01) * h, -0.011 * h])
        text(ch, size=h, font="Liberation Sans:style=Regular", halign="center", valign="center");
}
// one label in deployed coordinates: centre (x, y), digit height h (along X), digits side by side across y
module label_at(txt, x, y, h, wx, gap = 0.6) {
  n = len(txt);
  wd = DIG_W * h * wx + 2 * label_grow;
  pitch = wd + gap;
  translate([x, y, t - label_d]) linear_extrude(label_d + 0.01) rotate([0, 0, -90]) // text x -> -y: reads from the front
      for (i = [0:n - 1]) translate([(i - (n - 1) / 2) * pitch, 0]) digit2d(txt[i], h, wx);
}
module labels_world(h) {
  xs1 = [for (a = T1_angles) slotX(a)];
  xs2 = [for (a = T2_angles) slotX(a)];
  if (h == "T2")
    for (a = T2_angles)
      let (
        X = slotX(a),
        x0 = X + sw / 2,
        x1 = next_rear(X, xs2, T2_END_X),
        hh = min(2.6, x1 - x0 + 1.0 - 0.4 - 2 * label_grow), // may reach 0.5 mm over the slot edges
        wx = min(1, ( (2 * yT2 - 2 * lab_m - 0.6) / 2 - 2 * label_grow) / (DIG_W * hh))
      )
      label_at(str(round(a)), uF + (x0 + x1) / 2, 0, hh, wx);
  if (h == "T1")
    for (a = T1_angles)
      let (
        X = slotX(a),
        x0 = X + sw / 2,
        x1 = next_rear(X, xs1, T1_END_X),
        d = str(round(a)),
        hh = min(2.6, x1 - x0 - 0.6 - 2 * label_grow),
        wx = min(1, (yT1 - yT1i - 2 * lab_m - 2 * label_grow) / (DIG_W * hh))
      ) // one digit per arm
      for (k = [0:1]) label_at(d[k], uF + (x0 + x1) / 2, (k == 0 ? 1 : -1) * (yT1 + yT1i) / 2, hh, wx);
}
module labels_of(h) {
  if (label_mode != "none") {
    if (h == "T1") labels_world("T1");
    if (h == "T2") translate([uT, 0, ax]) rotate([0, 180, 0]) translate([-uT, 0, -ax]) labels_world("T2");
  }
}
module tpu_of(h) { pads_of(h); catches_of_host(h); if (label_mode == "inlay") labels_of(h); }
module tpu_cut(h) { pads_of(h); pockets_of_host(h); recesses_of_guest(h); labels_of(h); }

// ---------------- parts (folded coordinates) ----------------
// Slanted stop face in M (prong band): parallel to the ledge's back face at angle ledge_face,
// offset by g. The ledge swings out, its back face lands on this face -> opens to ~ledge_open.
module ledge_stop() {
  intersection() {
    box(uH - t / 2 - 0.5, uH, yC, yMi + 0.5); // below the axis; spans into the rail so it is fused to it
    translate([uH, 0, ax]) rotate([0, -ledge_face, 0]) // frame of the opened ledge
        translate([-20, yC - 1, t / 2 + gPe]) cube([40, yMi - yC + 2, 20]);
    // half-space beyond its back face + gap
  }
}
module part_M() {
  difference() {
    union() {
      // legs (prong band + rail) from heel to block top
      sym() knuckle_bar(uF - t / 2, uH - t / 2 - gPe, yC, yMo, round0=true);
      sym() ledge_stop();
      // rails
      sym() box(uH - t / 2 - gPe - 0.01, uTop0 + 0.01, yMi, yMo);
      // prong-band filler above prong tips
      if (!linked) sym() box(uPt + gPe, uTop0 + 0.01, yC, yMi + 0.01);
      // top bar between the K arms, rounded end
      knuckle_bar(uTop0, uTop1, -yMo, yMo, round1=true);
      // foot axle: bridges leg to leg through T1's heel (ties the legs, captures T1)
      axle(uF, -yC - 1, yC + 1);
    }
    bore(p, -yMo, yMo); // K through-axle runs inside the top bar
    sym() bore(uH, yP, yMo); // ledge pins pass through the rails (and the stop where it joins them)
    tpu_cut("M");
  }
}

module part_prong() {
  // one side (+y); mirrored for the other
  difference() {
    union() {
      knuckle_bar(uH - t / 2, linked ? uBar1 : uPt, yC, yP, round0=true);
      axle(uH, yP - 1, yMo); // pin through the M rail, flush with its outer face
    }
    // ledge recess (folded bottom face -> deployed top face), leaves the lip at the tip
    box(uH + t / 2, uPt - lipw, yC - 0.01, yP + 0.01, -0.01, lip);
  }
}

module part_ledge() {
  difference() {
    union() {
      part_prong();
      mirror([0, 1, 0]) part_prong();
      if (linked) box(uBar0, uBar1, -yP + 0.5, yP - 0.5); // pull bar: rigidly couples both prongs
      if (ledge_link == "root") {
        // root link: fills the T2 slot nearest the hinge
        intersection() {
          box(uLk0, uLk1, -yC, yC, zLk0, t); // top follows the hinge curve
          knuckle_bar(uH - t / 2, max(uLk1, uH) + 1, -yC - 0.01, yC + 0.01, round0=true);
        }
        sym() intersection() {
            box(uLk0, uLk1, yC - 0.01, yC + 0.5, zLk0, t); // fused into the prongs,
            knuckle_bar(uH - t / 2, uPt, yC - 0.01, yC + 0.5, round0=true);
          }
        // only inside them
      }
    }
    tpu_cut("P");
  }
}

module part_K() {
  difference() {
    union() {
      sym() knuckle_bar(-cK + k_taper, p + t / 2, yKi, yKo, round1=true); // arms
      sym() hull() {
          box(-cK + k_taper, -cK + k_taper + 0.01, yKi, yKo); // tapered feet
          translate([-cK, yKi, rc]) rotate([-90, 0, 0]) cylinder(r=rc, h=yKo - yKi);
        }
      translate([-cK, -yKo, rc]) rotate([-90, 0, 0]) cylinder(r=rc, h=2 * yKo); // crossbar = foot, prints on the bed
      axle(p, -yKi - 1, yKi + 1); // through-axle: ties both arms, runs through M top bar
    }
    tpu_cut("K");
  }
}

module part_T1() {
  difference() {
    union() {
      sym() knuckle_bar(uF - t / 2, uT + t / 2, yT1i, yT1, round0=true, round1=true);
      knuckle_bar(uF - t / 2, uT2end - gT, -yT1, yT1, round0=true); // heel crossbar
      // closer to M where T1 faces M (heel and legs, and above the prong tips), not where it faces the prongs
      sym() knuckle_bar(uF - t / 2, uH - t / 2 - 0.5, yT1 - 0.01, yC - gTM, round0=true);
      if (!linked) sym() knuckle_bar(uPt + gPe + 0.5, uT + t / 2, yT1 - 0.01, yC - gTM, round1=true);
      axle(uT, -yT1i - 1, yT1i + 1); // through-axle: ties both arm tips, runs through T2
    }
    bore(uF, -(yC - gTM), yC - gTM); // M foot axle runs through the heel
    for (a = T1_angles) slot_at(uF + slotX(a), false); // underside: straddles K's crossbar
    link_notch_T1();
    tpu_cut("T1");
  }
}

module part_T2() {
  difference() {
    union() {
      knuckle_bar(uT2end, uT + t / 2, -yT2, yT2, round0=true, round1=true);
    }
    bore(uT, -yT2, yT2);
    for (a = T2_angles) slot_at(2 * uT - uF - slotX(a), true); // folded top = deployed underside
    tpu_cut("T2");
  }
}

function show(m) = material == "all" || material == str(m);
TPU_COLOR = [0.12, 0.12, 0.12];
// one part with its TPU inlays; ms = material filter applies
module part(n) {
  if (show(mat(n))) {
    if (n == "M") color("SteelBlue") part_M();
    if (n == "P") color("Orange") part_ledge();
    if (n == "K") color("SeaGreen") part_K();
    if (n == "T1") color("Gold") part_T1();
    if (n == "T2") color("Tomato") part_T2();
  }
  if (show(3)) color(TPU_COLOR) tpu_of(n);
}
module stand_print() { for (n = ["M", "P", "K", "T1", "T2"]) part(n); }

// ---------------- hinge test coupon: the longest bridged axle (K <-> M top bar), ~10 min print ----
// Print it first: if the axle turns freely after a little flexing, the full stand will too.
module hinge_test() {
  if (show(mat("K"))) color("SeaGreen") { sym() box(-6, 6, yKi, yKo); axle(0, -yKi - 1, yKi + 1); } // two "K arms" + axle
  if (show(mat("M"))) color("SteelBlue") difference() { knuckle_bar(-t / 2, t / 2, -yMo, yMo, true, true); bore(0, -yMo, yMo); } // "M top bar"
}

// ---------------- exploded view (folded parts lifted apart to show the nesting) ----------
module stand_exploded(dz = 14) {
  parts = [["T2 tie, part 2", -2], ["T1 tie, part 1", -1], ["M back-rest", 0], ["ledge prongs", 1], ["K kickstand", 2]];
  translate([0, 0, -2 * dz]) part("T2");
  translate([0, 0, -1 * dz]) part("T1");
  part("M");
  translate([0, 0, 1 * dz]) part("P");
  translate([0, 0, 2 * dz]) part("K");
  for (pt = parts) color("DimGray") translate([uTop1 + 6, -3, pt[1] * dz + 1]) rotate([90, 0, 0]) linear_extrude(0.6) text(pt[0], size=4);
}

// ---------------- deployed preview ----------------
module hingeRot(u, a) { translate([u, 0, ax]) rotate([0, a, 0]) translate([-u, 0, -ax]) children(); }
module stand_deployed(th) {
  b = beta(th);
  phi = 180 - b - th - kdel;
  echo(str("tilt ", th, " slotX ", slotX(th), " K-angle ", b, " K-open ", phi));
  function on(n) = only == "" || only == n;
  if (on("T1")) part("T1");
  if (on("T2")) hingeRot(uT, 180) part("T2");
  hingeRot(uF, -th) {
    if (on("M")) part("M");
    if (on("P")) hingeRot(uH, -ledge_open) part("P");
    if (on("K")) hingeRot(p, -phi) part("K");
    if (phone && only == "") {
      Hp = landscape ? 76 : 160;
      Wp = landscape ? 160 : 76;
      tp = 9;
      uL = uH + (t / 2 + tp - (lip - t / 2) * cos(ledge_open)) / tan(ledge_open) - (lip - t / 2) * sin(ledge_open);
      color([0.15, 0.15, 0.18, 0.55]) translate([uL, -Wp / 2, t + 0.1]) cube([Hp, Wp, tp]);
      if (!landscape)
        color("White") translate([uL - 22, -6, t + tp / 2 - 3.5]) cube([22, 12, 7]);
      // USB-C plug
      else
        color("White") translate([uL + Hp / 2 - 3.5 - 0, Wp / 2, t + tp / 2 - 3.5]) cube([7, 22, 7]);
    }
  }
  if (only == "") color([0.85, 0.85, 0.85]) translate([-40, -60, -1]) cube([170, 120, 1]); // table
}

if (mode == "print")
  stand_print();
else if (mode == "deployed")
  stand_deployed(let (d = [for (a = ALL_TILTS) abs(a - tilt_req)], m = min(d)) [for (i = [0:len(d) - 1]) if (d[i] == m) ALL_TILTS[i]][0]);
else if (mode == "exploded")
  stand_exploded();
else if (mode == "hinge_test")
  hinge_test();
else if (mode == "M")
  part_M();
else if (mode == "P")
  part_ledge();
else if (mode == "K")
  part_K();
else if (mode == "T1")
  part_T1();
else if (mode == "T2")
  part_T2();
else if (mode == "tpu") tpu_of(only);
