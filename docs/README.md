# Sentient UI — Frontend (Static)

Overview
- Static demo site and UI reference for the Sentient UI project. It demonstrates:
  - A refined video modal with custom controls (play/pause, mute, progress seek, fullscreen)
  - A research paper preview and full-paper modal (PDF view)
  - A responsive hero and image carousel
  - Accessibility and keyboard shortcuts for the video modal
- The site is intentionally simple (HTML/CSS/JS) so it can be previewed locally or hosted as static files.

What's included / Key files
- `index.html` — main page and component initializations (includes the `VideoModal` class and UI helpers).
- `assets/icons/` — SVG icons used by the site (including `pub-dev-logo.svg`).
- `assets/videos/` — demo video(s) (e.g., `Sentient_UI.mp4`).
- `assets/papers/` — research PDF(s) (e.g., `Engineering_Sentient_UI__Bridging_Emotion__Behavior__and_Context_for_Dynamic_UI_Adaptation.pdf`).
- Inline and modular scripts:
  - `VideoModal` (defined in `index.html`): handles playback, controls, seeking, fullscreen, keyboard shortcuts, and focus management.
  - `handlePaperDownload` / fallback: opens the paper PDF in a new tab (no loading spinner by default) and includes a fallback implementation for non-module environments.

Notable features & implementation notes
- VideoModal
  - Play/pause, mute, progress (buffer + played), hover thumb, seek by drag/click.
  - Fullscreen implementation listens to `fullscreenchange` and updates icons and ARIA labels.
  - Uses keyboard shortcuts when the modal is open: Space/K, F, M, Esc, ArrowLeft/ArrowRight.
  - Auto-play attempts are handled gracefully (catch and show paused state if autoplay prevented).
- Fullscreen controls
  - Two separate SVG icons for Enter / Exit fullscreen are toggled based on real fullscreen state.
  - Accessible labels and titles update with state.
- Paper modal & download
  - The "Open Paper" button opens a fullscreen modal to read the paper.
  - "Download Full Paper (PDF)" opens the PDF in a new tab (immediate viewing). Fallback code exists to trigger downloads even when modules are unavailable.
- Progressive enhancements & fallbacks
  - `assets/js/fallback.js` provides minimal global functions (open/close modals, handle paper download) for file:// use or environments where module loading is blocked.
  - Note: modern browsers block module loading over file:// (CORS). For full behavior, serve the files over HTTP (see below).
- Responsive & styling fixes
  - Control icons have responsive sizing and non-scaling strokes to avoid thick/clipped icons on small screens.
  - A `.control-btn::before` overlay masks the progress stripe under controls to prevent visual bleed-through.
  - Pub.dev logo is responsive and scales with viewport using `clamp()`.
  - Custom cross-browser scrollbar styling (WebKit + Firefox fallbacks) for a consistent look.
- Accessibility
  - Focus management in modals (close button receives focus on open and focus is restored on close).
  - Buttons use `aria-pressed` where applicable and labels update on state changes.

How to run locally (recommended)
1. Use a static local server (recommended so ES modules and fetch behave correctly):
   - Python 3: `python -m http.server 8000` (open http://localhost:8000)
   - Node: `npx http-server -p 8000` (open http://localhost:8000)
   - VS Code: Live Server extension
2. Open the site in your browser and use the header "Watch Intro" or the hero "Watch Video" button to open the video modal.

Troubleshooting
- If `assets/js/main.js` or other module scripts fail to load with a CORS/ERR_FAILED when using `file://`, you'll see console errors such as:
  - "Access to script at 'file:///...' from origin 'null' has been blocked by CORS policy"
  - This is expected — serve over HTTP to fix the issue.
- If the video does not play automatically, browsers may block autoplay; clicking Play will work (autoplay rejections are caught by the code).
- If a PDF fails to download, the code opens it in a new tab as a fallback.

Manual test checklist
- Video modal
  - Open modal → Play, Pause, Seek, Mute, Toggle fullscreen, Use keyboard shortcuts.
  - Enter fullscreen → confirm Enter/Exit icons switch correctly and ESC closes fullscreen.
- Paper
  - Open Paper modal → Scroll through content, Close with ESC or Close button.
  - Click "Download Full Paper (PDF)" → PDF should open in a new tab.
- Responsive
  - Verify controls and icons render acceptably at mobile widths; pub.dev logo scales with viewport.

Developer notes & suggestions
- The project keeps most behavior inside `index.html` for simplicity; you can extract `VideoModal` into `assets/js/video-modal.js` and the UI helpers into `assets/js/ui.js` if you want a strict modular layout.
- Consider adding automated integration tests (Playwright or Puppeteer) to verify modal behavior (playback, controls, keyboard shortcuts) across browsers.

Report Issues & Contribute
- Please use the repository to report issues or open PRs: https://github.com/AhmadRob/sentient_ui
- For quick fixes, run a local static server and validate the pages in Chrome/Firefox/Safari.


