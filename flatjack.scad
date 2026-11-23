// FlatJack: one-piece, print-in-place folding phone stand.
// All parts nest in one card-thick layer, joined by three captive axles and two ledge pins.
// Print flat as exported (view = print), no supports. Open Window > Customizer to set it up:
// each parameter's description is on the line above it.

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
// Tilt angles you want. Each one that fits gets a slot; the others are skipped and listed in the console (at the default length, 70 falls on the T1/T2 hinge)
wanted_tilts = [40, 45, 50, 55, 60, 65, 70, 75, 80];

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
$fn = resolution;
eps = 0.01;

// Coordinates: the folded card lies flat on the bed. u (= x) runs along the card from the back-rest
// heels to its top bar, y across it (symmetric about y = 0), z up through the thickness.

// ---------------- generic helpers ----------------
function round_to_layers(z) = max(1, round(z / layer_height)) * layer_height;
function ceil_to_layers(z) = max(1, ceil(z / layer_height - 1e-6)) * layer_height;
// item of xs with the smallest key(x) (the first one on a tie)
function argmin(xs, key) = let (d = [for (x = xs) key(x)], m = min(d)) [for (i = [0:len(xs) - 1]) if (d[i] == m) xs[i]][0];
// bisection between lo and hi; go_up(m) says whether the solution lies above m
function bisect(go_up, lo, hi, n = 40) =
  n == 0 ? (lo + hi) / 2
  : let (m = (lo + hi) / 2) go_up(m) ? bisect(go_up, m, hi, n - 1) : bisect(go_up, lo, m, n - 1);
function round1(x) = round(x * 10) / 10;

// ---------------- layers ----------------
t = round_to_layers(thickness); // card thickness
axis_z = t / 2; // every hinge axis runs across the card at mid-thickness
lip = t - round_to_layers(ledge_floor_thickness); // lip height above the ledge surface = ledge recess depth
pad_t = ceil_to_layers(pad_depth);
label_d = ceil_to_layers(0.6);

// ---------------- options and gaps ----------------
root_link = ledge_linking == "root";
front_bar = ledge_linking == "front";
// parts of different rigid materials can sit closer together
gap_ab = two_rigid_materials ? gap_between_materials : part_gap; // side gap between an A part and a B part
end_gap = two_rigid_materials ? gap_between_materials : 0.3; // ledge root / tip | M end gaps, and the ledge stop face
axle_gap = two_rigid_materials ? axle_clearance_between_materials : axle_clearance;
// rigid material of each part (1 = A, 2 = B)
function mat(part) = !two_rigid_materials || part == "M" || part == "T2" ? 1 : 2;
function show(m) = export_material == "all" || export_material == str(m);

// Stop face slant: the ledge's back face turns past the face's angle before closing the gap end_gap
// (contact near the top face: s*sin(d) + r*cos(d) = r + end_gap, with s = r*tan(angle/2), r = t/2)
ledge_face = let (r = t / 2, s = r * tan(ledge_angle / 2)) ledge_angle - (s - sqrt(s * s - 2 * r * end_gap)) / r * 180 / PI;
ledge_open = ledge_angle - 0.5; // drawn just short of the stop

// ---------------- width: every band across the card scales by the same factor ----------------
BANDS = [min_plug_gap / 2, 2.8, 2.4, 2.8]; // half plug gap (tie inside it), prong, M rail, K arm
band_sum = BANDS[0] + BANDS[1] + BANDS[2] + BANDS[3];
min_width = 2 * (band_sum + gap_ab + gap_ab);
w_scale = max(1, (card_width / 2 - gap_ab - gap_ab) / band_sum);
// half widths
y_plug = BANDS[0] * w_scale; // plug gap
y_prong = y_plug + BANDS[1] * w_scale; // prong outer face
y_rail_in = y_prong + gap_ab; // M rail
y_rail_out = y_rail_in + BANDS[2] * w_scale;
y_kick_in = y_rail_out + gap_ab; // K arm
y_kick_out = y_kick_in + BANDS[3] * w_scale; // = card_width / 2
y_t1 = y_plug - part_gap; // T1 outer face (T1 and the prongs are the same material)
y_t1_in = y_t1 - 3.0 * w_scale; // T1 arm inner face (3 mm arms at base width: room for a digit)
y_t2 = y_t1_in - gap_ab; // T2 outer face

// ---------------- length ----------------
// Extra length stretches the tie, kickstand and back-rest (about 85 %) and the top bar (the rest).
// The split is fine-tuned so that one wanted tilt's T2 slot lands exactly on the ledge hinge, where the
// ledge root link rests in it (otherwise the link needs an odd-angle slot that crowds out its neighbours).
BASE_TIE = 56.5; // tie hinge position at the base length
MIN_TOP_BAR = t; // the top bar holds the kickstand's rounded hinge end
u_foot = t / 2; // foot hinge axis (M <-> T1)
tie_to_top = t / 2 + 0.4 + (front_bar ? 2.95 : 0); // tie hinge -> top bar start
len_delta = card_length - (kick_foot_offset + kick_foot_radius + BASE_TIE + tie_to_top + MIN_TOP_BAR); // < 0: shorter tie
TIE_LO = BASE_TIE + min(0, len_delta);
TIE_HI = BASE_TIE + len_delta;
TIE_TARGET = TIE_LO + 0.85 * (TIE_HI - TIE_LO);

// Side-profile kinematics for a tie hinge at x (the top bar takes the rest of the length).
// Tilt a = angle of M above the table; the kickstand crossbar rests on the table, the tie straddles it.
function top_bar_at(x) = MIN_TOP_BAR + len_delta - (x - BASE_TIE);
function kick_axis_at(x) = x + tie_to_top + top_bar_at(x) / 2; // M <-> K hinge, inside the top bar
function kick_len_at(x) = sqrt(pow(kick_axis_at(x) + kick_foot_offset, 2) + pow(t / 2 - kick_foot_radius, 2));
function kick_axis_world_at(a, x) = let (r = kick_axis_at(x) - u_foot) [r * cos(a), t / 2 + r * sin(a)];
// distance from the foot hinge to the crossbar = slot position along the tie (deployed X)
function slot_x_at(a, x) = let (q = kick_axis_world_at(a, x), dy = q[1] - kick_foot_radius) q[0] + sqrt(pow(kick_len_at(x), 2) - dy * dy);
function t2_slot_u_at(a, x) = 2 * x - u_foot - slot_x_at(a, x); // T2 slot centre, folded
function tie_for_link(a) = bisect(function(m) t2_slot_u_at(a, m) < ledge_height, TIE_LO, TIE_HI);
TIE_CANDIDATES =
  !root_link || TIE_HI - TIE_LO < 0.5 ? []
  : [
    for (a = wanted_tilts) let (x = tie_for_link(a))
      if (abs(t2_slot_u_at(a, x) - ledge_height) < 0.05 && top_bar_at(x) >= MIN_TOP_BAR) x,
  ];

// ---------------- u stations (folded) ----------------
u_tie = len(TIE_CANDIDATES) == 0 ? TIE_TARGET : argmin(TIE_CANDIDATES, function(x) abs(x - TIE_TARGET)); // T1 <-> T2
top_bar = top_bar_at(u_tie);
u_top0 = u_tie + tie_to_top; // M top bar
u_top1 = u_top0 + top_bar;
u_kick = kick_axis_at(u_tie); // M <-> K
kick_drop = atan2(axis_z - kick_foot_radius, u_kick + kick_foot_offset); // crossbar sits below K's centre line
u_prong_tip = ledge_height + t / 2 + ledge_depth + lip_thickness;
u_bar0 = u_tie + t / 2 + part_gap; // front pull bar, just above the tie ends
u_bar1 = u_bar0 + 2.2;
slot_w = 2 * kick_foot_radius + 0.6;
slot_h = ceil_to_layers(2 * kick_foot_radius + 0.3); // cut from the tie's deployed underside

function slot_x(a) = slot_x_at(a, u_tie);
function t2_slot_u(a) = t2_slot_u_at(a, u_tie);
function kick_angle(a) = let (q = kick_axis_world_at(a, u_tie)) atan2(q[1] - kick_foot_radius, slot_x(a) - q[0]); // K below horizontal

// ---------------- tilt slots ----------------
// T1 carries the steep tilts (slots before the T2 knuckle), T2 the shallow ones (behind its bore, before its
// rounded end). The ledge root link gets a T2 slot of its own, centred on the ledge hinge: a wanted angle if
// its slot is within 1 mm, otherwise the nearest whole degree. Wanted angles too close to it are dropped.
T2_END_X = 2 * u_tie - u_foot - tie_end_position - t / 2; // start of T2's rounded end (deployed X)
T1_END_X = u_tie - u_foot - t / 2 - 0.3; // before the T2 knuckle
T1_MIN_X = ledge_height - u_foot + slot_w + 1.5; // clear of T1's link notch
T1_MAX_X = u_tie - u_foot - t / 2 - slot_w / 2;
T2_MIN_X = u_tie - u_foot + axle_radius + axle_gap + 1.0 + slot_w / 2;
T2_MAX_X = T2_END_X - slot_w / 2 - 1.0;
LINK_EXACT = let (x = 2 * u_tie - u_foot - ledge_height) bisect(function(m) slot_x(m) > x, 20, 89.5);
LINK_NEAR = argmin(wanted_tilts, function(a) abs(slot_x(a) - slot_x(LINK_EXACT)));
LINK_TILT =
  !root_link ? -1
  : abs(slot_x(LINK_NEAR) - slot_x(LINK_EXACT)) <= 1.0 ? LINK_NEAR
  : round(LINK_EXACT);
link_fits = !root_link || (slot_x(LINK_TILT) >= T2_MIN_X && slot_x(LINK_TILT) <= T2_MAX_X);
function fits_t1(a) = slot_x(a) >= T1_MIN_X && slot_x(a) <= T1_MAX_X;
function fits_t2(a) = slot_x(a) >= T2_MIN_X && slot_x(a) <= T2_MAX_X && (!root_link || abs(slot_x(a) - slot_x(LINK_TILT)) >= slot_w + 2.0);
T1_TILTS = [for (a = wanted_tilts) if (fits_t1(a)) a];
T2_TILTS = [for (a = wanted_tilts) if (fits_t2(a)) a, if (root_link && link_fits) LINK_TILT];
ALL_TILTS = concat(T1_TILTS, T2_TILTS);

// Root link: fills its T2 slot, minus gaps (T1 gets one matching notch)
link_u = t2_slot_u(LINK_TILT); // = ledge hinge
link_u0 = link_u - slot_w / 2 + part_gap;
link_u1 = link_u + slot_w / 2 - part_gap;
link_z0 = t - slot_h + ceil_to_layers(link_air_gap); // slot floor + air gap

// ---------------- console report ----------------
// Phone (thickness tp) sits on the ledge's front corner; its centre of gravity vs the tipping lines:
// the crossbar (rear) and the back-rest heels (front)
function phone_u(tp) = ledge_height + (t / 2 + tp - (lip - t / 2) * cos(ledge_open)) / tan(ledge_open) - (lip - t / 2) * sin(ledge_open);
function folded_to_world_x(u, z, a) = (u - u_foot) * cos(a) - (z - t / 2) * sin(a);
function phone_cg_x(a, length, tp) = folded_to_world_x(phone_u(tp) + length / 2, t + tp / 2, a);

echo(str("FlatJack ", card_length, " x ", 2 * y_kick_out, " x ", t, " mm = ", round1(card_length * 2 * y_kick_out * t / 1000), " mL"));
echo(
  str(
    "Tilt slots: T1 ", T1_TILTS, "  T2 ", [for (a = T2_TILTS) round1(a)],
    "  skipped: ", [for (a = wanted_tilts) if (!fits_t1(a) && !fits_t2(a) && a != LINK_TILT) a]
  )
);
if (!link_fits) echo("WARNING: the ledge link slot does not fit on T2 at this size");
echo(
  str(
    "Sideways support (half-widths): phone on ledge +/-", round1(y_prong), " mm, front feet +/-", round1(y_rail_out),
    " mm, rear foot +/-", round1(y_kick_out), " mm"
  )
);
for (a = ALL_TILTS)
  echo(
    str(
      "  tilt ", round(a), ": rear margin ", round(slot_x(a) - phone_cg_x(a, 165, 9.5)), " mm (165 mm phone, portrait), front margin ",
      round1(phone_cg_x(a, 77, 9.5)), " mm (landscape)"
    )
  );
if (card_width < min_width - eps) echo(str("NOTE: card_width below the minimum ", min_width, " mm, using the minimum"));
if (abs(t - thickness) > 0.001) echo(str("NOTE: thickness snapped to ", t, " mm (whole ", layer_height, " mm layers)"));

// ---------------- shape helpers ----------------
module box(u0, u1, y0, y1, z0 = 0, z1 = t) translate([u0, y0, z0]) cube([u1 - u0, y1 - y0, z1 - z0]);
module sym() { children(); mirror([0, 1, 0]) children(); } // the part and its mirror across y = 0
module rod_y(u, z, r, y0, y1) translate([u, y0, z]) rotate([-90, 0, 0]) cylinder(r=r, h=y1 - y0);
// 2D profile drawn in (u, -z), extruded across the card from y0 to y1
module along_y(y0, y1) translate([0, y0, 0]) rotate([-90, 0, 0]) linear_extrude(y1 - y0) children();
// rotation about the hinge axis at u
module hinge_rot(u, a) translate([u, 0, axis_z]) rotate([0, a, 0]) translate([-u, 0, -axis_z]) children();
// full-thickness bar, either end optionally rounded about a hinge axis
module knuckle_bar(u0, u1, y0, y1, round_start = false, round_end = false) {
  hull() {
    box(round_start ? u0 + t / 2 : u0, round_end ? u1 - t / 2 : u1, y0, y1);
    if (round_start) rod_y(u0 + t / 2, axis_z, t / 2, y0, y1);
    if (round_end) rod_y(u1 - t / 2, axis_z, t / 2, y0, y1);
  }
}

// Hinges: cylindrical axles (a radial load cannot wedge the parts apart).
// Single material: the axle has a flat underside so it bridges cleanly.
// Two materials: fully round, dropped by its clearance so it prints resting on the other material's bore.
module axle(u, y0, y1) {
  along_y(y0, y1)
    if (two_rigid_materials)
      translate([u, -(axis_z - axle_gap)]) circle(r=axle_radius);
    else
      intersection() {
        translate([u, -axis_z]) circle(r=axle_radius);
        translate([u - 5, -(axis_z - 0.7 * axle_radius) - 10]) square([10, 10]);
      }
}
// Bore: circle with a 45° teardrop roof (no support), clipped 0.6 mm under the top. In single material it
// drops 0.3 mm below the axis: about 1.1 mm of air under the bridged axle, for sag.
module bore(u, y0, y1) {
  along_y(y0 - eps, y1 + eps) intersection() {
      hull() {
        translate([u, -axis_z]) circle(r=axle_radius + axle_gap);
        translate([u, -axis_z + (two_rigid_materials ? 0 : 0.3)]) circle(r=axle_radius + axle_gap);
        translate([u, -(axis_z + (axle_radius + axle_gap) * sqrt(2))]) square(eps, center=true);
      }
      translate([u - 5, -(t - 0.6)]) square([10, 10]);
    }
}
// tilt slot across the tie, cut from its top or bottom face
module slot_at(u, top = true) translate([u - slot_w / 2, -20, top ? t - slot_h : -eps]) cube([slot_w, 40, slot_h + eps]);

// ---------------- TPU catches (3rd material) ----------------
// A TPU bump is embedded in a host part and reaches across the gap into a recess in the guest part.
// Folding the guest in or out makes the recess rim ride over the cone-shaped bump: a soft click.
CATCH_EMBED = 1.5; // bump depth in its host
CATCH_CLEARANCE = 0.25; // around a bump in its recess
// [host, guest, u, host face y, direction to guest, gap, bump radius] (+y side, mirrored)
CATCHES = [
  ["M", "K", 10, y_rail_out, 1, gap_ab, 1.0],
  ["M", "T1", 16, y_plug, -1, gap_ab, 1.0],
  ["M", "P", u_prong_tip - lip_thickness / 2, y_rail_in, -1, gap_ab, 0.8],
  ["T1", "T2", 11, y_t1_in, -1, gap_ab, 1.0],
];
function bump_r(r, gap, s) = r - 0.5 * r * s / (gap + catch_strength); // cone radius at distance s from the host face
// frame of a catch: origin on the host face, z towards the guest
module catch_frame(c) translate([0, c[3], 0]) mirror([0, c[4] < 0 ? 1 : 0, 0]) translate([c[2], 0, axis_z]) rotate([-90, 0, 0]) children();
module catch_bump(c) catch_frame(c) {
    translate([0, 0, -CATCH_EMBED]) cylinder(r=c[6], h=CATCH_EMBED + eps);
    cylinder(r1=c[6], r2=bump_r(c[6], c[5], c[5] + catch_strength), h=c[5] + catch_strength);
  }
module catch_pocket(c) catch_frame(c) translate([0, 0, -CATCH_EMBED - eps]) cylinder(r=c[6], h=CATCH_EMBED + 2 * eps);
module catch_recess(c) catch_frame(c) hull() {
      translate([0, 0, c[5] - eps]) cylinder(r=bump_r(c[6], c[5], c[5]) + CATCH_CLEARANCE, h=eps);
      translate([0, 0, c[5] + catch_strength + CATCH_CLEARANCE]) cylinder(r=bump_r(c[6], c[5], c[5] + catch_strength) + CATCH_CLEARANCE, h=eps);
    }
function host_catches(n) = snap_catches ? [for (c = CATCHES) if (c[0] == n) c] : [];
function guest_catches(n) = snap_catches ? [for (c = CATCHES) if (c[1] == n) c] : [];

// ---------------- TPU pads (flush inlays: the pocket and the pad are the same shape) ----------------
module pads_of(n) {
  if (grip_pads) {
    if (n == "M") // phone-back strips
      sym() box(u_prong_tip + part_gap + 1, u_top0 - 1, front_bar ? y_rail_in + 0.4 : y_plug + 0.5, y_rail_out - 0.4, t - pad_t, t);
    if (n == "P") // soft inner face of each lip
      sym() box(u_prong_tip - lip_thickness, u_prong_tip - lip_thickness + 0.8, y_plug + 0.4, y_prong - 0.9, 0, lip);
    if (n == "T1") // feet (deployed underside)
      sym() box(ledge_height + slot_w / 2 + 1, min(ledge_height + 9, u_foot + min([99, for (a = T1_TILTS) slot_x(a)]) - slot_w / 2 - 1), y_t1_in + 0.4, y_t1 - 0.4, 0, pad_t);
    if (n == "T2") // rear foot (top when folded)
      box(tie_end_position + 1.5, min(12.8, min([99, for (a = T2_TILTS) t2_slot_u(a)]) - slot_w / 2 - 1), -y_t2 + 0.5, y_t2 - 0.5, t - pad_t, t);
  }
}

// ---------------- tilt labels ----------------
// Built in deployed tie coordinates (top face up, reading from the front of the stand), then mapped back to
// each part's folded position. On T2 the digits sit side by side; on T1 one digit per arm (the centre is
// open once T2 is flipped out). Each digit is centred on its measured outline (Liberation Sans Regular:
// ink width ~0.66 x size, ink centre offset ~0.01 x size), then grown by label_boldness.
DIGIT_W = 0.66; // ink width / size
LABEL_WALL = 0.45; // minimum wall beside a label (engraving)
function next_rear(x, xs, lim) = min([lim, for (v = xs) if (v > x + 0.1) v - slot_w / 2]); // next slot behind x
module digit2d(ch, h, wx) {
  offset(r=label_boldness) scale([wx, 1])
      translate([-(ch == "1" ? 0.028 : 0.01) * h, -0.011 * h])
        text(ch, size=h, font="Liberation Sans:style=Regular", halign="center", valign="center");
}
// one label centred on (x, y): digit height h (along x), digits side by side across y
module label_at(txt, x, y, h, wx, gap = 0.6) {
  n = len(txt);
  pitch = DIGIT_W * h * wx + 2 * label_boldness + gap;
  translate([x, y, t - label_d]) linear_extrude(label_d + eps) rotate([0, 0, -90]) // text x -> -y: reads from the front
      for (i = [0:n - 1]) translate([(i - (n - 1) / 2) * pitch, 0]) digit2d(txt[i], h, wx);
}
module deployed_labels(n) {
  if (n == "T2")
    for (a = T2_TILTS)
      let (
        x0 = slot_x(a) + slot_w / 2,
        x1 = next_rear(slot_x(a), [for (b = T2_TILTS) slot_x(b)], T2_END_X),
        h = min(2.6, x1 - x0 + 1.0 - 0.4 - 2 * label_boldness), // may reach 0.5 mm over the slot edges
        wx = min(1, ( (2 * y_t2 - 2 * LABEL_WALL - 0.6) / 2 - 2 * label_boldness) / (DIGIT_W * h))
      )
      label_at(str(round(a)), u_foot + (x0 + x1) / 2, 0, h, wx);
  if (n == "T1")
    for (a = T1_TILTS)
      let (
        x0 = slot_x(a) + slot_w / 2,
        x1 = next_rear(slot_x(a), [for (b = T1_TILTS) slot_x(b)], T1_END_X),
        d = str(round(a)),
        h = min(2.6, x1 - x0 - 0.6 - 2 * label_boldness),
        wx = min(1, (y_t1 - y_t1_in - 2 * LABEL_WALL - 2 * label_boldness) / (DIGIT_W * h))
      )
      for (k = [0:1]) label_at(d[k], u_foot + (x0 + x1) / 2, (k == 0 ? 1 : -1) * (y_t1 + y_t1_in) / 2, h, wx);
}
module labels_of(n) {
  if (angle_labels != "none") {
    if (n == "T1") deployed_labels("T1");
    if (n == "T2") hinge_rot(u_tie, 180) deployed_labels("T2");
  }
}

// TPU of part n, and the cut it leaves in the rigid part
module tpu_of(n) {
  pads_of(n);
  for (c = host_catches(n)) sym() catch_bump(c);
  if (angle_labels == "inlay") labels_of(n);
}
module tpu_cut(n) {
  pads_of(n);
  for (c = host_catches(n)) sym() catch_pocket(c);
  for (c = guest_catches(n)) sym() catch_recess(c);
  labels_of(n);
}

// ---------------- parts (folded) ----------------
// Slanted stop face in M (prong band), parallel to the ledge's back face at ledge_face, end_gap away from it
module ledge_stop() {
  intersection() {
    box(ledge_height - t / 2 - 0.5, ledge_height, y_plug, y_rail_in + 0.5); // below the axis, fused into the rail
    hinge_rot(ledge_height, -ledge_face) // half-space behind the opened ledge's back face + gap
      translate([ledge_height - 20, y_plug - 1, t + end_gap]) cube([40, y_rail_in - y_plug + 2, 20]);
  }
}

// M: back-rest (legs, rails, top bar)
module part_M() {
  difference() {
    union() {
      sym() knuckle_bar(u_foot - t / 2, ledge_height - t / 2 - end_gap, y_plug, y_rail_out, round_start=true); // legs
      sym() ledge_stop();
      sym() box(ledge_height - t / 2 - end_gap - eps, u_top0 + eps, y_rail_in, y_rail_out); // rails
      if (!front_bar) sym() box(u_prong_tip + end_gap, u_top0 + eps, y_plug, y_rail_in + eps); // filler above the prong tips
      knuckle_bar(u_top0, u_top1, -y_rail_out, y_rail_out, round_end=true); // top bar, between the K arms
      axle(u_foot, -y_plug - 1, y_plug + 1); // foot axle: ties the legs, runs through T1's heel
    }
    bore(u_kick, -y_rail_out, y_rail_out); // K axle runs inside the top bar
    sym() bore(ledge_height, y_prong, y_rail_out); // ledge pins pass through the rails
    tpu_cut("M");
  }
}

// P: ledge, two prongs (+ root link or front pull bar)
module prong() { // +y side
  difference() {
    union() {
      knuckle_bar(ledge_height - t / 2, front_bar ? u_bar1 : u_prong_tip, y_plug, y_prong, round_start=true);
      axle(ledge_height, y_prong - 1, y_rail_out); // pin through the M rail, flush with its outer face
    }
    // ledge recess (folded bottom = deployed top face), leaves the lip at the tip
    box(ledge_height + t / 2, u_prong_tip - lip_thickness, y_plug - eps, y_prong + eps, -eps, lip);
  }
}
module part_P() {
  difference() {
    union() {
      sym() prong();
      if (front_bar) box(u_bar0, u_bar1, -y_prong + 0.5, y_prong - 0.5);
      if (root_link) {
        // fills the T2 slot over the ledge hinge; its top follows the hinge curve
        intersection() {
          box(link_u0, link_u1, -y_plug, y_plug, link_z0, t);
          knuckle_bar(ledge_height - t / 2, max(link_u1, ledge_height) + 1, -y_plug - eps, y_plug + eps, round_start=true);
        }
        // fused into the prongs, only inside them
        sym() intersection() {
            box(link_u0, link_u1, y_plug - eps, y_plug + 0.5, link_z0, t);
            knuckle_bar(ledge_height - t / 2, u_prong_tip, y_plug - eps, y_plug + 0.5, round_start=true);
          }
      }
    }
    tpu_cut("P");
  }
}

// K: kickstand, two arms joined by the axle and the crossbar foot
module part_K() {
  r = kick_foot_radius;
  foot_u = -kick_foot_offset;
  difference() {
    union() {
      sym() knuckle_bar(foot_u + kick_foot_taper, u_kick + t / 2, y_kick_in, y_kick_out, round_end=true); // arms
      sym() hull() { // arms taper down into the foot
          box(foot_u + kick_foot_taper, foot_u + kick_foot_taper + eps, y_kick_in, y_kick_out);
          rod_y(foot_u, r, r, y_kick_in, y_kick_out);
        }
      rod_y(foot_u, r, r, -y_kick_out, y_kick_out); // crossbar = foot, prints on the bed
      axle(u_kick, -y_kick_in - 1, y_kick_in + 1); // ties both arms, runs through M's top bar
    }
    tpu_cut("K");
  }
}

// T1: tie, part 1 (hinged at M's foot)
module part_T1() {
  difference() {
    union() {
      sym() knuckle_bar(u_foot - t / 2, u_tie + t / 2, y_t1_in, y_t1, round_start=true, round_end=true); // arms
      knuckle_bar(u_foot - t / 2, tie_end_position - gap_ab, -y_t1, y_t1, round_start=true); // heel crossbar
      // wider where T1 faces M (heel and legs, and above the prong tips), not where it faces the prongs
      sym() knuckle_bar(u_foot - t / 2, ledge_height - t / 2 - 0.5, y_t1 - eps, y_plug - gap_ab, round_start=true);
      if (!front_bar) sym() knuckle_bar(u_prong_tip + end_gap + 0.5, u_tie + t / 2, y_t1 - eps, y_plug - gap_ab, round_end=true);
      axle(u_tie, -y_t1_in - 1, y_t1_in + 1); // ties both arm tips, runs through T2
    }
    bore(u_foot, -(y_plug - gap_ab), y_plug - gap_ab); // M's foot axle
    for (a = T1_TILTS) slot_at(u_foot + slot_x(a), top=false); // underside: straddles K's crossbar
    if (root_link) slot_at(link_u); // notch under the root link
    tpu_cut("T1");
  }
}

// T2: tie, part 2 (nested in T1, flips 180° about the T1 tip)
module part_T2() {
  difference() {
    knuckle_bar(tie_end_position, u_tie + t / 2, -y_t2, y_t2, round_start=true, round_end=true);
    bore(u_tie, -y_t2, y_t2);
    for (a = T2_TILTS) slot_at(t2_slot_u(a)); // folded top = deployed underside
    tpu_cut("T2");
  }
}

// [name, colour, label] in stacking order, bottom to top
PARTS = [
  ["T2", "Tomato", "T2 tie, part 2"],
  ["T1", "Gold", "T1 tie, part 1"],
  ["M", "SteelBlue", "M back-rest"],
  ["P", "Orange", "ledge prongs"],
  ["K", "SeaGreen", "K kickstand"],
];
function part_info(n) = [for (p = PARTS) if (p[0] == n) p][0];
module rigid_part(n) {
  if (n == "M") part_M();
  if (n == "P") part_P();
  if (n == "K") part_K();
  if (n == "T1") part_T1();
  if (n == "T2") part_T2();
}
// one part and its TPU, filtered by export_material
module part(n) {
  if (show(mat(n))) color(part_info(n)[1]) rigid_part(n);
  if (show(3)) color([0.12, 0.12, 0.12]) tpu_of(n);
}

// ---------------- views ----------------
module stand_print() for (p = PARTS) part(p[0]);

// folded parts lifted apart to show the nesting
module stand_exploded(dz = 14) {
  for (i = [0:len(PARTS) - 1]) let (level = (i - 2) * dz) {
      translate([0, 0, level]) part(PARTS[i][0]);
      color("DimGray") translate([u_top1 + 6, -3, level + 1]) rotate([90, 0, 0]) linear_extrude(0.6) text(PARTS[i][2], size=4);
    }
}

// the longest bridged axle (K <-> M top bar), ~10 min print: if it turns after a little flexing, the stand will too
module hinge_test() {
  if (show(mat("K"))) color("SeaGreen") {
      sym() box(-6, 6, y_kick_in, y_kick_out); // two "K arms"
      axle(0, -y_kick_in - 1, y_kick_in + 1);
    }
  if (show(mat("M"))) color("SteelBlue") difference() { // "M top bar"
        knuckle_bar(-t / 2, t / 2, -y_rail_out, y_rail_out, round_start=true, round_end=true);
        bore(0, -y_rail_out, y_rail_out);
      }
}

module dummy_phone(tp = 9) {
  h = phone_landscape ? 76 : 160;
  w = phone_landscape ? 160 : 76;
  u = phone_u(tp);
  color([0.15, 0.15, 0.18, 0.55]) translate([u, -w / 2, t + 0.1]) cube([h, w, tp]);
  color("White") // USB-C plug: down between the prongs, or out the side in landscape
    if (!phone_landscape) translate([u - 22, -6, t + tp / 2 - 3.5]) cube([22, 12, 7]);
    else translate([u + h / 2 - 3.5, w / 2, t + tp / 2 - 3.5]) cube([7, 22, 7]);
}

module stand_deployed(tilt) {
  b = kick_angle(tilt);
  kick_open = 180 - b - tilt - kick_drop;
  echo(str("tilt ", tilt, " slotX ", slot_x(tilt), " K-angle ", b, " K-open ", kick_open));
  part("T1");
  hinge_rot(u_tie, 180) part("T2");
  hinge_rot(u_foot, -tilt) {
    part("M");
    hinge_rot(ledge_height, -ledge_open) part("P");
    hinge_rot(u_kick, -kick_open) part("K");
    if (show_phone) dummy_phone();
  }
  color([0.85, 0.85, 0.85]) translate([-40, -60, -1]) cube([170, 120, 1]); // table
}

if (view == "print") stand_print();
else if (view == "deployed") stand_deployed(argmin(ALL_TILTS, function(a) abs(a - preview_tilt)));
else if (view == "exploded") stand_exploded();
else if (view == "hinge_test") hinge_test();
else rigid_part(view); // debug: one rigid part by name (M, P, K, T1, T2)
