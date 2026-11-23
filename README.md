---
lang: en-US
---

# FlatJack: a one-piece, print-in-place phone stand

Set `card_width` and `card_length` in the **Size** tab. Everything else follows.

- **Width:** every band across the card grows by the same factor: the plug gap
  and the tie inside it, the ledge prongs, the back-rest rails and the kickstand
  arms.
  - **Effect:** the ledge (phone support), the front feet and the rear foot all
    widen together, against sideways rocking, and the side members get stiffer.
    The minimum is 29.8 mm, or 30.4 mm in single material. The default is 32 mm.
- **Length:** about 85 % of any extra length stretches the tie, kickstand and
  back-rest, which makes the footprint deeper and adds margin against tipping
  backward. The rest lengthens the top bar.
  - **Fine-tuning:** the split is adjusted so that one of your wanted angles has
    its T2 slot exactly on the ledge hinge. The ledge root link rests in that
    slot, so no odd-angle slot crowds out its neighbours.
  - **Unchanged:** the ledge hinge height and the ledge itself stay put, so the
    USB-C clearance doesn't change.
  - **Shorter cards:** below 70 mm, the tie, kickstand and back-rest get shorter
    instead. The console shows which tilts still fit.
  - **Top bar:** it is never shorter than the card is thick, because it holds
    the kickstand's rounded hinge end.
- **Tilts:** you list the angles you want in `wanted_tilts`. Each one that fits
  on T1 or T2 gets a slot. The ones that don't fit are listed in the console as
  "skipped". The ledge's root link gets a slot of its own, centred on the ledge
  hinge. That uses one of your wanted angles if its slot falls within 1 mm,
  otherwise the nearest whole degree.
- **Console report:** after each render, the console shows:
  - the size and volume;
  - the slots that were made;
  - the sideways support half-widths: ledge, front feet and rear foot;
  - for each tilt, the rear tipping margin (165 mm phone in portrait) and the
    front margin (landscape).

| Example | Size    | Volume | K Walls Width | M Walls Width | Ledge Prong Width | T1 Walls Width | T2 Width |
| ------- | ------- | ------ | ------------- | ------------- | ----------------- | -------------- | -------- |
| Narrow  | 70×29×6 |        |               |               |                   |                |          |
| Wide    | 70×40×6 |        |               |               |                   |                |          |
| Long    | 78×32×6 |        |               |               |                   |                |          |

**Layer height:** set `layer_height` to your slicer's layer height (Print fit
tab). The model snaps these to whole layers, so none of them falls between two
layers:

- the thickness, rounded to the nearest layer (the console says when it was
  changed);
- the ledge floor;
- rounded up to whole layers: the tilt-slot height, the link's air gap, and the
  pad and label depths.

Each example was checked in the model: parts in one piece, no overlaps when
folded, free hinge sweeps, working catches, no collisions at any tilt, and
labels inside their parts. All of them keep the tilts 45, 50, 55, 60, 65, 75 and
80°. At 90 mm long, 70° fits too.

## How it works

All parts sit side by side in **one 6 mm layer**, nested like a Swiss Army card.
Every hinge axis runs across the width, so each part turns about its own axis:

```
y ▲   K  green   kickstand: closed frame (outer arms + round crossbar that is its foot on the table)
  │   M  blue    phone back-rest: rails + top bar; legs at the foot
  │   P  orange  flip-out ledge: 2 prongs (13 mm plug gap) joined by a thin bar at their roots
  │   T1 yellow  tie, part 1 (hinged at M's foot, lies on the table)
  │   T2 red     tie, part 2 (nested in T1, flips 180° to double the tie length)
```

**Hinges.** The first version used 45° cone pins. They failed in use, because
under load a cone pushes the two parts sideways. The thin arms bent away by more
than the 1 mm the cones engaged, and the stand fell apart. Every hinge is now a
cylinder, so a load on it pushes straight across the axle and not sideways:

- **Three captive through-axles.** Each axle is printed as one bar bridging
  between the two arms of the outer part, passing through a bore in the inner
  part. The inner part can only come off if something breaks. Each axle also
  ties its two arms together, so K, T1 and M's legs become closed frames that
  cannot spread.
  - Foot: M's legs ↔ T1's heel.
  - Far end of T1: T1's arms ↔ T2.
  - Top: K's arms ↔ M's top bar. K's hinge moved up inside the top bar to make
    room for this axle.
- **Ledge pins.** The two ledge pins go all the way through M's 2.4 mm side
  rails. They are not captive, but the two prongs are tied together and the
  rails are held at both ends, so pushing them out takes several newtons of
  squeeze.
- **Printing the axles (single material).** In single material, each axle is
  printed as a bridge, so it hangs over air with nothing under it while
  printing. In two-material mode none of this applies, because the axles print
  resting on their bores:

  | Axle or link                   | Bridge length | Air gap under it |
  | ------------------------------ | ------------- | ---------------- |
  | T1 ↔ T2 axle (Ø3 mm)           | 7.5 mm        | 1.15 mm          |
  | Foot axle (Ø3 mm)              | 13 mm         | 1.15 mm          |
  | Ledge root link (3.4 × 3.3 mm) | 13 mm         | 0.5 mm           |
  | K ↔ M top-bar axle (Ø3 mm)     | 25 mm         | 1.15 mm          |

  The K crossbar is no longer a bridge: it is printed lying on the bed.

  - The axles have a flat underside so their first layer is a straight bridge.
  - The bores have a 45° teardrop roof, so the material above the axle needs no
    support.
  - Most printers do bridges of 7–13 mm cleanly.
  - The 25 mm K axle is the risky one. With good cooling, PLA usually sags
    0.2–0.5 mm over that span, which the 1.1 mm gap allows for. PETG sags more.
  - **Print `view = hinge_test` first.** It is a 12 × 30 × 6 mm coupon with
    exactly that 25 mm axle, and takes about 10 minutes. If its axle turns after
    a bit of flexing, the stand's hinges will too. If it fuses, raise
    `axle_clearance` (axle clearance) or improve bridge cooling.

In side view, M, K and the T1+T2 tie form a **closed triangle**.

- **Ground contact:** K's round crossbar (Ø3.5 mm) lies on the table across the
  full card width (32 mm by default). The arms slope down into it at the foot
  (`kick_foot_taper`), so the crossbar stays K's lowest point at every tilt. The
  rear of the stand is supported across its full width, where before it rested
  only on the 7–12 mm wide tie. That gives about 2.5× more resistance to tipping
  sideways at 45° and about 1.4× at 75°.
- **Tilt slots:** they are cut into the **underside** of the tie, so the tie
  lies on the table and straddles the crossbar. The slot you pick sets the tilt.
- **Printing:** the crossbar is printed lying on the bed. The tie only ever
  carries tension and the crossbar is held down by the weight, so the stand
  **does not rely on table friction or hinge friction**. It cannot creep or
  collapse.

**Linked ledge (default, `ledge_link="root"`):**

- **The link.** A bar along the card's top face joins the two short prongs at
  their roots.
  - **Where it sits:** when folded, it rests inside T2's tilt slot nearest the
    ledge hinge (the 50° slot by default), so T2 needs no extra notch. T1 has
    one notch, the same size and depth, under it.
  - **Size:** it fills that slot, less a 0.35 mm gap at each side and 0.5 mm of
    air above the slot floor. That makes it 3.4 × 3.3 mm (it was 2 × 1.5 mm), so
    the prongs move together much more firmly.
  - **Adapts automatically:** the slot is picked from the parameters, so the
    link follows if you change `ledge_height` or the angles.
  - **Deployed:** it sits inside M's thickness, at least 1.7 mm behind the USB-C
    plug.
- **How it moves.** Flipping either prong flips both. When deployed, the link
  sits behind the phone's back plane, 1 mm or more behind the plug.
- **Cable.** The space between the prongs stays open at the front, so a cable
  can slide in from the front without threading.
- **Order matters.** The tie (T1 and T2) must swing out before the ledge flips.
  Folding is the reverse.
- **Slots and the link share a face.** T2's tilt slots and the link are on the
  same face, so no thin wall between them carries the tie's pull. The 50° and
  55° slots are back.
- **Other options:**
  - `ledge_link="front"` gives the earlier pull-bar tray. It is a closed loop,
    so the cable has to be threaded through it.
  - `"none"` gives two independent prongs.

**Ledge shape.**

- **Opening angle.** The ledge swings forward to about **86°**, not 90°, and
  lands on a slanted stop face in M. The weight of the phone presses it harder
  into that stop, so it cannot fold back. Because the ledge rises about 4°
  toward its tip, the phone's weight slides it back against M.
  - The stop face is parallel to the ledge's back face at the stop angle and
    sits 0.35 mm away from it.
  - Set `ledge_angle` (default 86°). The stop face's slant is computed from it
    and from the gap in use (single or two-material), so the ledge rests at that
    angle either way. The hinge sits at `ledge_height` = 26.3. It moved up so
    that, with the 86° stop and the deeper lip, the USB-C plug clearance stays
    at 4.6 mm or more.
- **Lip.** The lip is always as tall as the thickness allows: lip = thickness −
  `ledge_floor_thickness`. With the defaults (6 mm thickness, 2 mm web under the
  phone), that is a **4 mm lip**, 2 mm thick.
- **Fit.** The ledge is 13 mm deep between M and the lip, so phones up to about
  13 mm thick in a case fit.
- **Tuning.** Use `ledge_angle`, `ledge_floor_thickness`, `lip_thickness` and
  `ledge_depth`.

**USB-C:** the bottom of the phone sits 26–27 mm up the back-rest. The plug (12
× 7 mm, up to about 22 mm of rigid length) hangs down between the prongs through
M's open centre. At every tilt it still clears the table by at least 4.6 mm,
even for a 7.5 mm phone. In landscape the plug comes out the side, well past the
30 mm wide stand.

## Stability (250 g phone)

Values come from `geom.py`. "Margin" is the distance from the phone's centre of
gravity to the tipping edge.

| Tilt | Slot (mm from foot hinge) | Ledge height | Rear margin, 165 mm phone, portrait | Rear margin, landscape | Front margin, landscape |
| ---- | ------------------------- | ------------ | ----------------------------------- | ---------------------- | ----------------------- |
| 45°  | 92.0                      | 21.5         | 22.7 mm                             | 54 mm                  | 38 mm                   |
| 60°  | 68.7                      | 24.6         | 22.6 mm                             | 45 mm                  | 24 mm                   |
| 75°  | 43.9                      | 26.2         | 24.0 mm                             | 35 mm                  | 8.5 mm                  |
| 80°  | 36.1                      | 26.3         | 25.4 mm                             | 33 mm                  | 3.1 mm (marginal)       |

- The worst case is a large phone in portrait at 45°. Pushing about 0.40 N
  horizontally at the top edge tips it backwards, with a footprint 95 mm deep.
  With a 147 mm phone the rear margin rises to 28.5 mm.
- At 80° in landscape the phone's centre of gravity is only 3.1 mm behind the
  front edge. Use 80° for portrait.
- There are no 70° slot positions, because that spot is taken by the T1/T2
  hinge. Use 65° or 75° instead.

## Materials (multi-tool printers, e.g. Snapmaker U1)

| Tool | Material            | Parts                      |
| ---- | ------------------- | -------------------------- |
| 1    | Rigid A: PLA        | M (back-rest) and T2       |
| 2    | Rigid B: PETG       | K (kickstand), ledge, T1   |
| 3    | Flexible: TPU (95A) | grip pads and snap catches |

**Two non-bonding rigid materials** (`two_rigid_materials`):

- **Hinge pairing:** PLA and PETG barely stick to each other, and every hinge
  pairs one with the other: foot (M/T1), T1/T2, K/M and the ledge pins
  (ledge/M).
- **Tighter clearances:** wherever a PLA part meets a PETG part, the gap is
  `gap_between_materials` (0.1 mm) instead of 0.35 mm, and the axle clearance is
  0.1 mm instead of 0.4 mm. That covers:
  - side gaps: M | ledge, M | K, T1 | T2, and T1 | M's legs. T1 steps 0.25 mm
    wider where it faces M, so it no longer slides sideways on the foot axle.
  - end gaps: ledge roots and tips | M, the ledge stop, and T2's free end | T1's
    heel bar.
  - **Unchanged:** where two parts are the same material, gaps stay at
    `part_gap` (0.35 mm): ledge prongs | T1 (both PETG), kickstand foot | T1
    heel. These cause no play in use. Once T1 swings out, the ledge is held
    sideways only by M's rails.
- **No more bridging:** each axle is fully round and printed resting on the
  floor of its bore, in the other material. The 25 mm bridge is gone.
- **Where gaps stay 0.35–0.5 mm:** where two parts are the same material, which
  is the ledge next to T1 and the root link over T1.
- **Tuning:** `gap_between_materials` (side gap between materials) and
  `axle_clearance_between_materials` (axle clearance between materials).

**TPU grip pads** (`grip_pads`). These are flush inlays 0.6 mm deep, so the
stand's dimensions don't change:

- Strips on M's front face, under the phone's back, so the phone can't slide
  sideways.
- A soft inner face on each ledge lip.
- Foot pads under T1 and at T2's rear end. These touch the table level with the
  PLA/PETG around them, so they add some grip but don't carry the stand on their
  own.

**Tilt labels** (`angle_labels`):

- **What:** each slot's angle is written on the tie's top, on the wall right
  behind the slot, which is where K's crossbar bears.
- **Reading:** labels read upright from the front of the stand.
- **Layout:** each digit is placed on its own and centred on its measured
  outline, so it doesn't drift off-centre. On T2 the two digits sit side by
  side. On T1 there is one digit per arm, because the centre is open once T2 is
  flipped out. T1's arms are 3 mm wide (T2 is 5.9 mm), so every digit keeps at
  least 0.45 mm of wall on each side, which keeps the engraved version intact.
- **Modes:** `inlay` (default) makes them flush TPU, since TPU bonds to both PLA
  and PETG. `engrave` cuts them 0.6 mm deep, and `none` leaves them off.
- **Print size:** the digits are about 2.5–2.6 mm tall, in a regular-weight font
  grown by `label_boldness` (0.22 mm per side). Strokes come out about 0.7 mm
  wide, and the holes in 0, 6 and 8 stay open: in the engraved version the
  islands left inside them are about 0.55 mm.
- **T2's labels print against the bed.** T2 flips over when deployed, so its
  visible face is the one printed on the bed.
  - **Inlay:** TPU digits are laid down in the first three layers.
  - **Engraved:** 0.8 mm grooves in those first layers, with the layer above
    simply bridging them. Turn on elephant-foot compensation so the grooves
    don't close.
- **Fit:** where a wall is short, a label may reach up to 0.5 mm over the edge
  of the slot below it.

**TPU catches** (`snap_catches`):

- **What they are:** four pairs of small cone-tipped TPU bumps. Each is set 1.5
  mm into one part and reaches across the gap into a recess in its neighbour.
- **Which joints:** K ↔ M, T1 ↔ M, T2 ↔ T1 and the ledge ↔ M.
- **What you feel:** folding or unfolding any part clicks over its bump in the
  first few degrees. Measured in the model, that squeezes about 1 mm³ of TPU
  over 2–12°, and after that the part moves freely.
- **When folded:** each part is held shut. T2 is also held by the ledge's root
  link above it.
- **Tuning:** `catch_strength` (default 0.4 mm) sets how firm the click is.

## Print

- **Multi-material:** import the three `flatjack_mat*` STLs together and, when
  the slicer asks, load them as one object with several parts. Assign tool 1 =
  PLA, tool 2 = PETG, tool 3 = TPU. Use 0.2 mm layers, no supports, printed flat
  as exported. A prime tower is optional on a tool-changer.
- **Single material:** PLA or PETG, 0.2 mm layers, no supports, printed flat
  exactly as exported. Use a brim only if your bed needs it.
- Turn on elephant-foot compensation, or squish the first layer slightly less.
  Single material: the gaps between parts are 0.35 mm, and each axle has 0.4 mm
  of radial clearance in its bore. Use bridging settings with good part cooling.
  Either way, print the matching hinge-test coupon first.
- After printing, flex each hinge a few times to break it free: K, the prongs,
  T1 and T2.
- To make it tighter or looser, adjust `gap_between_materials` and
  `axle_clearance_between_materials` for parts in different materials, or
  `part_gap` and `axle_clearance` for single material. `axle_radius` sets the
  axle radius.
- In the Customizer, the `export_material` setting picks which body to render or
  export: all, 1, 2 or 3.

## Unfold (about 5 s)

1. Hold the card with the blue top bar up. Swing the green kickstand out of the
   back.
2. Let the yellow tie hang down from the foot, then flip the red half out until
   it lines up with the yellow half.
3. Only after the tie is out, flip either orange prong forward until it stops.
   The root link brings the other prong with it.
4. Stand it on the table with the green crossbar on the table, then lay the tie
   over the crossbar so that a slot on the tie's underside straddles it. The
   slot nearest the foot gives the steepest tilt (80°). Then come 75°, 65°, 60°,
   55°, 50° and 45°.

## Concepts explored (and why FlatJack won)

| Concept                                                                      | Outcome                                                                                                                                                                                         |
| ---------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Stacked tri-fold strip (base, back-rest, strut), 3 layers of 2.5 mm          | Works, but it ends up ~7.5 mm thick and the same length. A nested single layer is about 35 % smaller.                                                                                           |
| Kickstand plus table friction, no tie                                        | Rejected. The feet need a friction coefficient of 0.4 to 0.6, so it slides on smooth desks.                                                                                                     |
| Detent or ratchet hinge holding the kickstand angle                          | Rejected. The hinge would have to hold about 60 N·mm of torque, too much for printed flexures, and they wear.                                                                                   |
| Easel (strut top in notches on the back-rest, fixed base)                    | Geometrically impossible across 45 to 75° with members under 90 mm.                                                                                                                             |
| Kickstand whose top end also forms the ledge                                 | The ledge angle swings by ±30° with tilt, so it fails at 45°.                                                                                                                                   |
| Linking the prongs with a rod along their hinge axis, or a bar under the tie | Rejected. A rod would need a hole through the tie at mid-thickness. A bar under the tie jams whichever part moves first. A thin bar on the top face works, as long as the tie swings out first. |
| Linking the prongs with a bar at their tips (the `"front"` option)           | It works, but it closes a loop around the USB-C cable.                                                                                                                                          |
| Fixed ledge on the back-rest                                                 | It adds the ledge depth to the folded thickness (over 8 mm), hence the flip-out prongs.                                                                                                         |
| One-piece tie                                                                | It needs about 85 mm of length, so the card would be 95 to 100 mm long. Splitting it into the T1+T2 flip pair saves about 25 mm.                                                                |
| Rocker or curved base                                                        | Not stable with the centre of gravity this high.                                                                                                                                                |

Key constraint driving the size: in portrait the USB-C plug forces the ledge
about 21 mm above the table. At 45° that puts a big phone's centre of gravity
about 70 mm behind the foot, so the deployed footprint must be about 85 mm.
FlatJack folds that 85 mm footprint and 65 mm height into a 70 × 32 × 6 mm card.

## Possible next steps

- Engrave the tilt numbers next to the slots.
- Try a bigger card with `card_width` and `card_length` (see Size), within your
  volume budget.
