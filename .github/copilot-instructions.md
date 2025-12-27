# Galaxy Sports Management - AI Coding Instructions

## Project Overview
**Static website** for Galaxy Sports Management Ltd (football/soccer player agency). Built with **vanilla JavaScript ES6 modules** — no build tools, frameworks, or npm dependencies. Each HTML page is standalone, sharing common CSS/JS.

**Critical**: This is a **zero-dependency** static site. Never suggest npm, webpack, build tools, or frameworks. All JavaScript uses native ES6 modules loaded directly by the browser.

## Architecture & Data Flow

### Core Data Pattern
- **Single source of truth**: `data/projects.json` contains `players[]`, `teams[]`, and `news[]` arrays
  - **players[]** structure (59+ players):
    ```json
    {
      "id": 3,
      "name": "MACK BS BRIGGS",
      "age": 17,
      "position": "DM",
      "nationality": "Liberia",
      "currentClub": "Free Player",
      "photo": "assets/images/mack bs briggs action.jpg",
      "linkedin": "https://www.linkedin.com/in/mack-bs-briggs-1a4634135/",
      "highlights": "Young defensive midfielder..."
    }
    ```
  - **teams[]** structure (currently empty array, expects future entries):
    ```json
    {
      "name": "Team Name",
      "logo": "assets/images/team-logo.png",
      "description": "Team description text"
    }
    ```
  - **news[]** structure:
    ```json
    {
      "id": 1,
      "title": "News Title",
      "date": "2025-04-01",
      "excerpt": "Brief summary...",
      "content": "Full article text...",
      "image": "santiago signed flyer.JPG"
    }
    ```

- **Dynamic rendering**: `js/scripts.js` fetches JSON on `DOMContentLoaded` and populates:
  - `#players .players` grid on index.html and players.html 
  - `#peopleGrid` on players.html with `data-role`, `data-position`, `data-age`, `data-club` attributes for filtering
  - `#news .news-list` on index.html and news.html
  - `#player-stories .players-grid` on news.html (first 10 players + placeholders to fill 10 slots)
  
- **Static profile pages**: Individual pages (`player-1.html` to `player-9.html`) have hardcoded content — **NOT generated from JSON**. Each profile is manually crafted HTML.

### Image Handling Pattern
All images use consistent fallback logic in js/scripts.js (lines 113-117):
```javascript
const safePlayerSrc = (player.photo && player.photo.toString().trim())
  ? (player.photo.startsWith('http') || player.photo.startsWith('assets/') 
      ? player.photo : `assets/images/${player.photo}`)
  : 'https://via.placeholder.com/320x180?text=No+photo';
```
- **Fallback chain**: Photo field → prepend `assets/images/` if relative → via.placeholder.com if empty
- **Error handler**: All `<img>` tags include `onerror="this.onerror=null;this.src='assets/images/default-player.svg'"`
- **Image naming**: Flexible - supports spaces and hyphens (`acacia small.jpg`, `galaxy-logo.png`)

### News Image Optimization (Responsive Srcset)
**Auto-generates responsive images** for news thumbnails (js/scripts.js lines 150-175):
- **Pattern**: For `assets/images/news-photo.jpg`, checks existence of `-320.jpg`, `-640.jpg`, `-960.jpg`, `-1200.jpg` variants
- **HEAD requests**: Async fire-and-forget fetches verify each size exists before adding to srcset
- **Output**: `<img srcset="news-photo-320.jpg 320w, news-photo-640.jpg 640w" sizes="(min-width:1400px) 23vw, (min-width:980px) 30vw...">`
- **To enable**: Place optimized image variants in `assets/images/` with size suffixes (script auto-detects)

### External Link Handling
Players with `wiki` or `linkedin` field in JSON: card links to external URL with `target="_blank"` instead of `player-{id}.html`:
```javascript
const profileHref = player.wiki ? player.wiki : `player-${player.id}.html`;
const isExternal = !!player.wiki;
// Then: <a href="${profileHref}" ${isExternal ? 'target="_blank" rel="noopener noreferrer"' : ''}>
```
**Example**: Player #3 (MACK BS BRIGGS) has `linkedin` field and opens external link instead of profile page.


### Player Filtering System
players.html implements **client-side filtering** using data attributes:
- **Data attributes**: Each `.person-card` gets `data-role`, `data-position`, `data-age`, `data-club` from JSON
- **Filter UI**: Three dropdowns (position/age/club) + role button group ("All"/"Players"/"Staff")
- **Auto-populate clubs**: Script extracts unique clubs from data attributes and dynamically populates dropdown
- **Filter logic** (players.html inline script):
  ```javascript
  // Auto-populate clubs from data-club attributes
  const clubs = Array.from(new Set(
    personCards.map(c => (c.dataset.club || '').trim()).filter(Boolean)
  )).sort();
  
  // Filter respects role first, then position/age/club
  function applySelectFilters() {
    const pos = posSel.value, age = ageSel.value, club = clubSel.value;
    personCards.forEach(card => {
      // Check role visibility first, then other filters
      if (pos && card.dataset.position !== pos) ok = false;
      // Age ranges: U18 (<18), 18-23, 24+ (>=24)
      card.style.display = ok ? '' : 'none';
    });
  }
  ```
- **Animation distribution**: Cards get rotating `anim-{1-6}` classes in inline script (NOT AnimationManager)
- **Custom event**: After populating `#peopleGrid`, scripts.js fires `playersPopulated` event for page scripts to initialize

## Critical Patterns & Conventions

### 1. Adding New Players (3-step workflow)
1. **Update JSON**: Add object to `data/projects.json` `players[]` array:
   ```json
   {
     "id": 10,
     "name": "Player Name",
     "age": 23,
     "position": "FW",
     "nationality": "Country",
     "currentClub": "Club Name",
     "photo": "player-name.jpg",
     "highlights": "Description text"
   }
   ```
2. **Add photo**: Place image in `assets/images/` (use lowercase with hyphens/spaces)
3. **Create profile page**: Copy player-1.html → `player-10.html`:
   - Update `<title>`, `<h2>`, breadcrumb, photo `src`, bio text
   - Ensure navigation menu has `.active` class on Players link

### 2. Hamburger Menu System (Checkbox Pattern)
Uses **pure CSS** with hidden checkbox + visible label. Every HTML page must include:
```html
<input type="checkbox" id="menu_checkbox" aria-label="Toggle navigation menu">
<label for="menu_checkbox" aria-label="Open navigation menu">
  <div></div><div></div><div></div>
</label>
<nav class="nav-menu">...</nav>
<label for="menu_checkbox" class="nav-overlay" aria-hidden="true"></label>
```
- **Toggle**: `input#menu_checkbox` (display:none) controls `.nav-menu` slide-in from `right:-340px`
- **Hamburger**: `label[for="menu_checkbox"]` at fixed `top:20px; right:20px` with 3 `<div>` dots
- **JS enhancement**: js/menu.js adds `.hamburger-scrolling` class on scroll (scales down hamburger)
- **Accessibility**: Uses proper ARIA labels and roles for screen readers

### 3. Animation System (IntersectionObserver)
Powered by js/modules/animations.js `AnimationManager` class:
- **Setup**: Elements get `.pre-animation` class (opacity:0, translateY:30px)
- **Trigger**: Observer adds `anim-{1-7}` class when entering viewport
- **Keyframes**: Defined in css/animations.css (`fadeUpSmooth`, `fadeScaleIn`, `slideRightFade`, etc.)
- **Distribution**: js/scripts.js rotates through 7 variations via modulo:
  ```javascript
  function distributeAnimations(elements, startIndex = 1) {
    elements.forEach((element, index) => {
      const animationClass = `anim-${((index + startIndex - 1) % 7) + 1}`;
      animManager.setAnimation(element, animationClass);
      element.setAttribute('data-repeat-animation', 'true');
    });
  }
  ```
- **Available animations**: `.anim-1` through `.anim-7` (fadeUpSmooth, fadeScaleIn, slideRightFade, bounce, scale, slide-left, fade-rotate)
- **Repeat on scroll**: Use `data-repeat-animation="true"` attribute to re-trigger
- **Adding new animations**:
  1. Create keyframe in css/animations.css
  2. Add `.anim-8` class with animation reference
  3. Update modulo divisor in `distributeAnimations()` from `% 7` to `% 8`

### 4. CSS Architecture
**Modular structure** with CSS custom properties:
- css/style.css: Base layout, components, responsive grids
  - Variables: `--accent: #0ea5ff`, `--card: #0b1220`, `--muted: #94a3b8`, `--bg: #0f1724`
- css/menu.css: Checkbox-based hamburger + slide-in panel
- css/animations.css: Keyframe definitions only
- css/brand.css: Logo/brand-specific styles

**Responsive breakpoints** (consistent across site):
```css
@media (max-width: 980px) { /* Tablets: 2-column grids */ }
@media (max-width: 640px) { /* Mobile: single column */ }
```
Common classes: `.grid-3`, `.players`, `.news-list` use `grid-template-columns: repeat(3, 1fr)`

## Developer Workflows

### Local Development
**No build required** — serve directly:
```powershell
# Python (if installed)
python -m http.server 8000

# VS Code Live Server (recommended)
# Right-click index.html → "Open with Live Server"
```

### Deployment
Per README.md:
1. **Netlify** (recommended): Drag-and-drop deploy, auto HTTPS
2. **Vercel/GitHub Pages**: Also supported
3. **Custom domain**: Add `CNAME` file to repo root (see `CNAME.example`)

### Testing Changes
1. Modify `data/projects.json` → refresh page to see dynamic content updates
2. Test fallback images by temporarily breaking `photo` paths
3. Check responsive layouts at 980px and 640px breakpoints

## Common Gotchas

1. **Player ID consistency**: `data/projects.json` `id` field must match `player-{id}.html` filename number
2. **Module imports**: Always include `.js` extension: `import { AnimationManager } from './modules/animations.js'`
3. **Footer year**: Uses `<span id="yr"></span>` auto-populated by js/scripts.js on DOM ready
4. **Active nav state**: Manually add `.active` class to current page's `<nav>` link in each HTML file
5. **External vs internal links**: Players with `wiki` field bypass internal profile pages
6. **Image paths**: Supports both `photo: "filename.jpg"` (prepends `assets/images/`) and `photo: "assets/images/filename.jpg"` (absolute)

## External Dependencies
**Zero runtime dependencies!**
- Google Fonts (Inter family) loaded via `<link>` tag
- Vanilla JavaScript (ES6 modules)
- No npm, webpack, babel, or transpilation

## Adding News Articles

1. **Update JSON**: Add to `data/projects.json` `news[]` array:
   ```json
   {
     "id": 3,
     "title": "Article Title",
     "date": "2025-12-27",
     "excerpt": "Brief summary for cards...",
     "content": "Full article text...",
     "image": "article-photo.JPG"
   }
   ```
2. **Add image**: Place photo in `assets/images/` (supports case-sensitive names)
3. **Create article page**: Copy news-item-1.html → `news-item-3.html`:
   - Update `<title>`, `<h2>`, date, image `src`, and article content
   - Keep `.active` class on News nav link

## Loading States & Skeleton Screens

js/scripts.js implements skeleton loading before JSON data loads:
- **Function**: `showSkeletons(container, count)` creates placeholder cards
- **Applied to**: Players (6), Teams (3), News (4) sections
- **Styling**: css/style.css defines `.skeleton-card`, `.skeleton-image`, `.skeleton-text`
- **Pattern**: Show skeletons → fetch JSON → replace with real content
- **Empty states**: Teams section shows friendly "Building Partnerships" message when array is empty

## Player Image Lightbox

Profile pages support click-to-enlarge for images with `.player-image` class:
- **Markup**: Add `class="player-image"` to `<img>` tag on profile pages
- **Functionality**: js/scripts.js auto-creates `.lightbox` overlay on page load
- **Controls**: Click image to open, click overlay/close button to dismiss, ESC key closes
- **No dependencies**: Pure vanilla JS with event delegation

## Contact Form Configuration

js/scripts.js `window.handleContact()` supports external form redirects:
- **Setup**: Add `<script>window.contactRedirectUrl = 'https://forms.office.com/...';</script>` in HTML head
- **Behavior**: Opens external form (Microsoft Forms, Google Forms) with pre-filled query params
- **Fallback**: Without URL, shows demo alert and logs to console
- **Example** (index.html lines 41-51): Commented-out configuration example

## SEO & Meta Tags Pattern

index.html demonstrates full SEO implementation (lines 1-32):
- **Open Graph**: Facebook sharing with image preview
- **Twitter Cards**: Optimized social media previews
- **Structured data**: Proper meta descriptions, keywords, author, geo tags
- **Canonical URL**: Points to production domain (update for deployment)
- **Robots**: Index/follow enabled for search engines

## File Naming Conventions
- **HTML**: lowercase-with-hyphens (`player-1.html`, `news-item-1.html`)
- **Images**: flexible (spaces/hyphens: `acacia small.jpg`, `galaxy-logo.png`)
- **JS modules**: camelCase in `js/modules/` directory
- **CSS**: lowercase words/hyphens (`style.css`, `menu.css`)

## GitHub & Domain Deployment Checklist

### Pre-Deployment Steps
1. **Update production URLs** in index.html (lines 11-32):
   - Change `og:url` and `twitter:url` to your domain
   - Update `og:image` and `twitter:image` to full URLs with your domain
   - Update `link rel="canonical"` href to production domain
   
2. **Configure contact form** (optional):
   - Uncomment and set `window.contactRedirectUrl` in index.html (lines 41-51)
   - Test form submission redirects to external service

3. **Verify all assets**:
   - Check all images exist in `assets/images/`
   - Verify `data/projects.json` is valid JSON
   - Test all player profile pages load correctly

### GitHub Push
```powershell
# Initialize and push to GitHub
cd "c:\Users\MACK\Desktop\galaxy - Copy"
git init
git add .
git commit -m "Initial commit - Galaxy Sports Management website"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO.git
git push -u origin main
```

### Netlify Deployment (Recommended)
1. Go to https://app.netlify.com/
2. Click "Add new site" → "Import an existing project"
3. Connect to GitHub and select your repository
4. Deploy settings:
   - **Build command**: Leave empty (static site)
   - **Publish directory**: `/` (root)
   - Click "Deploy site"
5. **Custom domain setup**:
   - Go to Site settings → Domain management
   - Click "Add custom domain"
   - Enter your domain (e.g., `galaxysportsmanagement.com`)
   - Configure DNS records at your registrar:
     - **A Record**: `@` → Netlify IP (provided by Netlify)
     - **CNAME**: `www` → `your-site.netlify.app`
   - Netlify auto-provisions SSL (HTTPS)

### Alternative: GitHub Pages
1. Go to repository Settings → Pages
2. Source: Deploy from branch `main` → root
3. Save and wait for deployment
4. **Custom domain**:
   - Create `CNAME` file in repo root with your domain
   - Configure DNS at registrar:
     - **A Records** (4 records for `@`):
       - 185.199.108.153
       - 185.199.109.153
       - 185.199.110.153
       - 185.199.111.153
     - **CNAME**: `www` → `YOUR-USERNAME.github.io`

### Alternative: Vercel
1. Sign up at https://vercel.com/
2. Import repository from GitHub
3. Deploy with default settings
4. **Custom domain**: Add domain in project settings → Domains

### Post-Deployment Verification
- [ ] Test site loads at production URL
- [ ] Verify all pages work (Home, Players, News, etc.)
- [ ] Check images load correctly
- [ ] Test mobile responsive layouts
- [ ] Verify contact form redirect (if configured)
- [ ] Test player filtering on players.html
- [ ] Check hamburger menu works on mobile
- [ ] Verify animations trigger on scroll
- [ ] Test lightbox on player profile pages
- [ ] Confirm HTTPS works (green padlock)

### DNS Propagation
- DNS changes take 24-48 hours to fully propagate
- Test at https://www.whatsmydns.net/ to check propagation status
- Clear browser cache if you see old content