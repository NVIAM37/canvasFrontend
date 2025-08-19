## NVIAM Frontend — Canvas 3D Scroll Animation

High-performance, static frontend that renders a 300‑frame image sequence into a canvas and synchronizes it with scroll using GSAP ScrollTrigger. Smooth desktop scrolling powered by Locomotive Scroll; native scrolling on mobile/tablet for maximum compatibility.

### Features
- GSAP 3 + ScrollTrigger timeline tied to scroll position
- Desktop-only smooth scrolling via Locomotive Scroll with scrollerProxy
- Mobile/tablet use native scrolling for reliability and performance
- Full-bleed canvas rendering of a 300‑frame sequence (`male0001.png` → `male0300.png`)
- Pinned content sections with text reveals
- Fixed top navigation with current date

---

## Quick Start

This is a static site. You only need a static HTTP server (no build step required).

### 1) Clone
```bash
git clone <your-repo-url> nviam-frontend
cd nviam-frontend
```

### 2) Serve locally (pick ONE option)
- Node.js (recommended):
```bash
npx serve -s -l 5173
# or
npx http-server -p 8080
```

- Python 3 (built-in on many systems):
```bash
python -m http.server 5500
```

- VS Code Live Server:
  - Install the “Live Server” extension
  - Right‑click `index.html` → “Open with Live Server”

Then open the shown URL (for example `http://localhost:5173`) in your browser.

> Do not open with `file://` — browsers block some features and assets when not served over HTTP.

---

## Project Structure
```
.
├── index.html        # Markup (sections, canvas, nav)
├── style.css         # Styles, responsive rules, mobile optimizations
├── script.js         # GSAP + ScrollTrigger + Locomotive Scroll wiring
├── male0001.png
├── male0002.png
├── ...
└── male0300.png      # 300-frame image sequence for the canvas
```

---

## How It Works

### Desktop (smooth scrolling)
- `LocomotiveScroll` is initialized on `#main`, providing smooth wheel/touchpad scroll.
- `ScrollTrigger.scrollerProxy('#main', ...)` bridges GSAP’s ScrollTrigger with LocomotiveScroll.
- The canvas is pinned and its frame index (`imageSeq.frame`) is advanced purely by scroll.

### Mobile & Tablets (native scrolling)
- LocomotiveScroll is intentionally disabled; native scrolling is more reliable across mobile browsers.
- ScrollTrigger runs against the default page scroller.
- The canvas resizes to the viewport and draws the best-fit frame every time the scroll position updates.

### Canvas Rendering
- `script.js` preloads references to 300 PNG frames.
- As you scroll, GSAP tween updates `imageSeq.frame`, and `render()` draws the corresponding image onto the canvas using a cover strategy (maintains aspect and fills viewport).

---

## Running On Windows (CMD/PowerShell)

From the project root (e.g., `D:\cyber-fictionFrontend`):

```bat
:: Option A: Node.js (serve on port 5173)
npx serve -s -l 5173

:: Option B: Node.js (http-server on port 8080)
npx http-server -p 8080

:: Option C: Python 3 (port 5500)
python -m http.server 5500
```

Open the printed URL in your mobile device as well (same Wi‑Fi). Example: `http://<your-computer-ip>:5173`.

---

## Deployment

### GitHub Pages
1. Commit and push all files to your repository (keep `index.html` at the root).
2. In your GitHub repo: Settings → Pages.
3. Source: “Deploy from a branch”. Branch: `main`. Folder: `/ (root)`.
4. Save. Wait for GitHub Pages to deploy and give you a URL.

Notes:
- The image sequence uses relative paths like `./male0001.png`. Ensure all PNGs are at the repository root with exact names.
- Git LFS is not required for these file sizes, but enabling HTTP compression and long‑lived caching on your host is recommended.

### Netlify (no build)
1. “New site from Git” → connect repository.
2. Build command: none. Publish directory: `/` (root).
3. Deploy.

### Vercel (no build)
1. “Add New Project” → import repository.
2. Framework preset: “Other”. Build command: none. Output directory: `/`.
3. Deploy.

---

## Browser Support
- Desktop: Chrome, Edge, Firefox, Safari (latest two versions)
- Mobile: iOS Safari 13+, Chrome for Android, Firefox for Android

> If testing on iOS, disable “Request Desktop Website” for the domain and ensure the site is served over HTTPS for best results.

---

## Performance & Hosting Tips
- The page loads 300 PNG frames on demand as you scroll. On slow networks or low‑memory devices, initial interaction may feel heavier. This is expected for image‑sequence animations.
- Host on a CDN or an edge platform with:
  - HTTP compression enabled (Brotli/Gzip)
  - Long‑lived cache headers for `male*.png` files
  - HTTP/2 or HTTP/3 for parallel requests
- Avoid blocking scripts; keep CDN links to GSAP and Locomotive Scroll accessible (cdnjs/jsDelivr).

---

## Troubleshooting

### Nothing scrolls or the page looks static on mobile
- Make sure you’re serving via HTTP, not opening `index.html` from the file system.
- Clear the browser cache and hard‑reload.
- Ensure CDNs are reachable on your network (no firewall/ad‑block interference):
  - `https://cdn.jsdelivr.net`
  - `https://cdnjs.cloudflare.com`

### Canvas is blank or images 404
- Verify all `maleXXXX.png` files exist and are named exactly (case‑sensitive on some hosts).
- Keep files at the repository root unless you also update the paths in `script.js`.

### Scroll feels choppy on low‑end devices
- This is a heavy, full‑screen image sequence. Prefer Wi‑Fi and newer devices.
- Close other tabs/apps to free memory.

### Desktop scroll looks different from mobile
- That’s by design: desktop uses Locomotive Scroll for smoothness; mobile uses native scrolling for maximum browser compatibility.

---

## Development Notes (for contributors)
- All logic is in `script.js`. The animation key points:
  - Locomotive Scroll initialized only on desktop (`#main` scroller)
  - `ScrollTrigger` proxies to Locomotive on desktop; defaults to the window on mobile
  - Canvas is pinned (`ScrollTrigger.create({ pin: true })`) and the frame index is tweened with scroll
- Styling in `style.css` includes responsive rules for small screens, and keeps the visual identical across devices.

---

## License
This project includes a `LICENSE` file at the repository root. See that file for terms.

---

## Acknowledgements
- GSAP by GreenSock
- Locomotive Scroll
- Sheryians Coding School (see footer link in the UI)


