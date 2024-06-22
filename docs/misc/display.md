# Display Upgrade

## Lore

I used to daily drive Asus Vivobook Pro 14X OLED ([M7400QC](https://in.store.asus.com/creator-laptop-asus-vivobook-pro-14x-oled-m7400qc.html)) as my personal laptop. This is a great laptop, but in just two years of owning it, I started to feel a number pain points:

1. 14 inch display was just too small. Especially if you are multiwindowing like me.
2. No thunderbolt port. So connecting to my external display is a chore
3. I can't use Macbook chargers that are laying around. It's own 120W brick is indeed a brick, weight-wise.
3. No expansion option. It has 16GB RAM soldered.

At the time of writing this, the best option was another Asus machine, [Asus Vivobook 16X](https://in.store.asus.com/creator-laptop-asus-vivobook-16x-k3605zv-mb741ws.html). It ticked all the boxes of what I needed, and more:

- [x] Thunberbolt port.
- [x] 16 inch display.
- [x] Expandable memory.
- [x] RTX 4060

It my haste to move on with my life, I didn't look too much into it and ordered one online. Only to discover later that the display is 1960x1200 (WUXGA?). 

## The Downgrade

My previous laptop had an OLED display, 2880x1800 display size with [242PPI](https://www.panelook.com/modeldetail.php?id=52193). For comparison, the new laptop is just [141PPI](https://www.panelook.com/modeldetail.php?id=61970). That's a substantial downgrade, and you feel it. Within 15 mins of booting the laptop up, I knew something was up. 

It turns out, Asus has bunch of SKUs with similar name. There are Vivobook, Vivobook S, Vivobook Pro. I had bought one without OLED screen (which I don't care for much), and more crucially, a very low res screen.

## The Upgrade

Luckly, I stumbled on this video from [NL Tech](https://www.youtube.com/watch?v=FAa2jQ40FhA&t). Don't remember what I was searching for, but thanks Google!

I followed the guide, and found that new laptop is using this panel [NE160WUM-NX1](https://www.panelook.com/modeldetail.php?id=61970) from [HWiNFO](https://www.hwinfo.com/).

### Metrics: display quality

The specs we are concerned are these:

- Panel Type: Oxide TFT-LCD
- Resolution: 1920x1200, 141 PPI
- Viewing angle: 89/89/89/89
- Contrast Ratio: 1200:1
- Adobe Coverage: 74%
- DCI-P3 Overage: 74%
- Brightness: 300 \\(cd/m^2\\)

Write these down somewhere. The idea is to make sure **we don't end up getting a worse panel**. Higher screen resolution is great, but that shouldn't come at the expense of these other metrics. What do they all mean?

- Panel Type: that's LCD, OLED etc. I had past experience IPS panels, so I knew to keep a watch out for this. In short, go for OLED if possible. If not, LCD at the very least.
- Viewing angle: the IPS panel I mentioned had a viewing angle of ~45 deg. You'd know when you see one. Just slightly tilting the panel will make reading the screen impossible, with the background lights bleed through.
- Contrat: that should be obvious. Poor contrast means washed out colors.
- Coverage %: this is not that obvious, but think of this as panel adding a bias/tint to everything you see.
- Brightness: higher the better, otherwise you'll struggle using it in a lit room.

The current panel was pretty good when it comes to all these metrics (other than resolution). So I knew the baseline number to look for.

### Metrics: interface

Now we want to find out about the compatible panels we replace our current display with. Panelook shows this under `Signal Type` on the [Specs tab](https://www.panelook.com/NE160WUM-NX1_BOE_16.0_LCM_parameter_61970.html). For me, this was:

- Signal type: eDP, 4 lane, eDP 1.4
- Pins: 40
- Interface model: `MSAK24025P40G` (optional)
- Interface position: Panelook showed this for my current panel ![](https://www.panelook.com/images/datagifen/sip/WDR.gif).

We want to search for panels with same number of pins (40) and same interface type (eDP 1.4). To be sure without a shred of doubt, you can also limit yourself to panels using the same interface model. Though, this turned out not to be necessary in my case.

### Result

In fact, I order two different panels:

- [NE160QDM-NYD](https://www.panelook.com/modeldetail.php?id=63485): a 2560x1660 panel which used the exact same `MSAK24025P40G` connector and had it placed in the exact same spot.
- [NE160QAM-NZ1](https://www.panelook.com/modeldetail.php?id=55904): a 3840x2400 panel which was best option all around, but didn't have the same connector and had slighly different placement.

You can actually see the comparison between the three panels (stock, NE160QDM-NYD, NE160QAM-NZ1) [here](https://www.panelook.com/modelcompare.php?ids=61970,63485,55904).

Display quality-wise, this is what the upgrade looks like:

- Panel Type: Oxide TFT-LCD *(unchanged)*
- Resolution: 3840x2400, 282PPI *(double the pixels)*
- Viewing angle: 89/89/89/89 *(unchanged)*
- Contrast Ratio: 1200:1 *(unchanged)*
- Adobe Coverage: 88% *(+14%)*
- DCI-P3 Overage: 100% *(+26)*
- Brightness: 500 \\(cd/m^2\\) *(+200)*

I'm now using `NE160QAM-NZ1`, and **it's great!**. Even up close, my eyes can't discern any two pixels apart. It's more vibrant, more bright. There is enough room now on screen to tile 4 different windows on each corner.

## Tools needed

[iFixit Pro toolkit](https://www.ifixit.com/products/pro-tech-toolkit) had all that I needed, which was just the screendriver bits, plastic opening picks (for laptop case), jimmy (for display panel) and tweezer (for adhesive rubber). I used the OSFT 2mm double sided tape to glue the new panel.