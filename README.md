---
lang: en-US
---

# FlatJack

A one-piece, print-in-place phone stand that folds into a 70 × 40 × 6 mm card.
It holds a phone at 40–80° in portrait or landscape, with room for a USB-C plug.

All parts nest side by side in one 6 mm layer, like a Swiss Army card, and every
hinge axis runs across the width:

```
K   green   kickstand: two arms + round crossbar, its foot on the table
M   blue    back-rest: legs, side rails and top bar
P   orange  ledge: two flip-out prongs around a plug gap, joined at their roots
T1  yellow  tie, part 1: hinged at M's foot, lies on the table
T2  red     tie, part 2: nested in T1, flips out to double the tie's length
```

Deployed, M, K and the tie form a closed triangle. The tie only carries tension
and K's crossbar is held down by the phone's weight, so the stand relies neither
on table friction nor on hinge friction.

## Quick start

1. Open `flatjack.scad` in OpenSCAD (2021.01 or newer) and open **Window ›
   Customizer**.
2. Set `card_length` and `card_width` (**Size**) and `layer_height` (**Print
   fit**).
3. Check `view = deployed` to see the stand set up with a dummy phone.
4. Print `view = hinge_test` first (about 10 minutes, see [Hinges](#hinges)).
5. Render `view = print` and export the STL.

After each render, the console lists the size and volume, the tilt slots made
(and skipped), the sideways support widths, and for each tilt the tipping
margins of a 165 mm phone.

## Parameters

### Size

- `card_width` (default 40 mm, minimum 30.4 mm): every band across the card
  grows by the same factor (plug gap and tie, prongs, rails, kickstand arms), so
  the ledge and the feet widen against sideways rocking.
- `card_length` (default 70 mm): about 85 % of the extra length goes into the
  tie, kickstand and back-rest (deeper footprint, more margin against tipping
  back), the rest into the top bar. The split is tuned so one wanted tilt's T2
  slot sits exactly over the ledge hinge, where the ledge's root link rests when
  folded. The ledge itself does not move, so the USB-C clearance is unchanged.
- `thickness` (default 6 mm).
- `wanted_tilts`: each angle that fits on T1 or T2 gets a slot, the others are
  reported as skipped. At 70 mm, 70° falls on the T1/T2 hinge and is skipped; at
  90 mm it fits.

The model snaps the thickness, ledge floor, slot height, link air gap, pad and
label depths to whole layers of `layer_height`.

### Ledge

- `ledge_linking`:
  - `root` (default): a bar at the prong roots joins them. Flipping either prong
    flips both, and the plug gap stays open at the front so a cable slides in.
    When folded, the bar rests in a T2 tilt slot and a matching T1 notch.
  - `front`: a pull bar at the tips. It closes a loop, so the cable must be
    threaded.
  - `none`: two independent prongs.
- `ledge_height` (27 mm): hinge height up the back-rest. It sets how high the
  phone sits, so the plug clearance above the table.
- `ledge_angle` (87°): the ledge lands on a slanted stop face in M, just short
  of square, so the phone's weight presses it into the stop and slides the phone
  back against M.
- `ledge_depth` (14 mm): room for the phone and its case.
- `ledge_floor_thickness` (2 mm) and `lip_thickness` (2.5 mm): the lip is always
  as tall as the thickness allows (4 mm by default).

### Materials

Single material by default. On a multi-tool printer:

| Tool | Material       | Parts                           |
| ---- | -------------- | ------------------------------- |
| 1    | Rigid A (PLA)  | M, T2                           |
| 2    | Rigid B (PETG) | K, ledge, T1                    |
| 3    | TPU (95A)      | grip pads, snap catches, labels |

- `two_rigid_materials`: PLA and PETG don't bond, and every hinge pairs one with
  the other. Gaps between them drop to `gap_between_materials` (0.1 mm) and the
  axles print fully round, resting in their bores: no bridging.
- `grip_pads`: flush TPU inlays on M's face under the phone, the lips' inner
  faces, and the tie's feet.
- `snap_catches`: small TPU bumps that click K, T1, T2 and the ledge shut. Tune
  the click with `catch_strength`.
- `angle_labels`: each slot's angle written on the tie, as a flush TPU `inlay`
  or `engrave`d. T2's labels print against the bed, since T2 flips over when
  deployed: turn on elephant-foot compensation.
- `export_material`: renders one material at a time. Export the three STLs and
  load them as parts of one object in the slicer.

## How it works

### Hinges

Every hinge is a plain cylinder, so a load pushes across the axle, never
sideways. An earlier cone-pin version failed: the cones pushed the thin arms
apart until the parts fell off.

- **Three captive through-axles**, each printed as one bar from arm to arm of
  the outer part, through a bore in the inner part. They also tie the arms
  together into closed frames: foot (M ↔ T1), tie (T1 ↔ T2), top (K ↔ M's top
  bar).
- **Two ledge pins** pass through M's side rails.
- **Single material**: axles bridge over 1.15 mm of air, with a flat underside,
  and the bores have a 45° teardrop roof. At 40 mm width the spans are about 9
  mm (tie), 17 mm (foot) and 33 mm (K). The K axle is the risky one: PLA with
  good cooling sags a few tenths of a millimetre over that span. If the hinge
  test coupon fuses, raise `axle_clearance` or improve bridge cooling.

### Stability

K's crossbar lies on the table across the full card width, and the tie's slots,
cut in its underside, straddle it. The arms slope down into it
(`kick_foot_taper`), so it stays K's lowest point at every tilt.

The worst case is a large phone in portrait at 40–60°: about 21 mm between its
centre of gravity and the rear tipping edge (console report). At 80° in
landscape it is only 3 mm behind the front edge, so use 80° in portrait only.

## Print

- PLA or PETG, 0.2 mm layers, no supports, flat as exported. Brim only if your
  bed needs it.
- Turn on elephant-foot compensation, or squish the first layer a bit less, and
  use good part cooling for the bridges.
- After printing, flex each hinge a few times to break it free.
- Too tight or too loose: adjust `part_gap` and `axle_clearance` (single
  material), or `gap_between_materials` and `axle_clearance_between_materials`.

## Unfold (about 5 s)

1. Hold the card with the blue top bar up and swing the green kickstand out.
2. Let the yellow tie hang from the foot, then flip the red half out in line
   with it.
3. Only then flip either orange prong forward until it stops. Folding is the
   reverse: ledge first, then the tie.
4. Stand it on the green crossbar and lay the tie over it, with a slot
   straddling it. The slot nearest the foot is the steepest (80°).

## Design notes

In portrait the USB-C plug puts the ledge about 21 mm above the table. At 45°
that puts a big phone's centre of gravity about 70 mm behind the foot, so the
deployed footprint must be about 85 mm deep. FlatJack folds that into 70 mm.

Concepts tried and dropped:

- Stacked tri-fold strip: works, but 7.5 mm thick for the same length.
- Kickstand on table friction, no tie: slides on smooth desks.
- Detent hinge holding the angle: too much torque for printed flexures.
- Easel with notches on the back-rest: impossible over 45–75° with short parts.
- Fixed ledge: adds its depth to the folded thickness.
- One-piece tie: needs a 95–100 mm card; the T1 + T2 flip pair saves 25 mm.
- Rocker base: not stable with the centre of gravity this high.

`geom.py` is a standalone side-profile check with its own hard-coded constants.
