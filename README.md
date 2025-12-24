# Pichai
myapp/
├─ client/ (HTML/CSS/JS หรือ Next.js)
│  ├─ layouts/      # Layout Builder / Theme
│  ├─ pages/        # Home, Shop, Video, Profile, Admin
│  ├─ components/   # Menu, Sidebar, Player, Chat, Cart
│  └─ assets/
│
├─ server/ (Node.js + Express/Nest)
│  ├─ auth/         # JWT / OAuth
│  ├─ api/
│  │   ├─ users
│  │   ├─ content (CMS)
│  │   ├─ shop / pos
│  │   ├─ chat / video
│  │   └─ notification
│  ├─ realtime/     # Socket.IO / WebRTC
│  └─ ai/           # AI moderation / assistant
│
├─ database/
│  ├─ users
│  ├─ products
│  ├─ orders
│  ├─ content
│  ├─ chat
│  └─ logs
 
 ----------------
 
✅ Top Menu + Sidebar (พับได้)
✅ Mega Menu / Search / Notification
✅ Dynamic Layout (บทความ / วิดีโอ / สินค้า)
✅ Theme Engine (Dark/Light/Video BG)
✅ Accessibility Mode (Font / Contrast / Text-to-Speech)
✅ Multi-Language (i18n + AI Translate)


# Clone
git clone git@github.com:PichaiTK/myapp-multiplatform.git
cd myapp-multiplatform


# สร้างไฟล์ LICENSE (PowerShell here-string)

@" MIT License

Copyright (c) 2025 PichaiTK

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"@ | Out-File -FilePath LICENSE -Encoding utf8

# commit & push
git add LICENSE
git commit -m "chore: add MIT license (Copyright 2025 PichaiTK)"
git push -u origin add/license-mit

# create PR (requires gh)
gh pr create --title "Add MIT license" --body "$(Get-Content PR_BODY_long.md -Raw)" --base master --head add/license-mit
# or create via web: https://github.com/PichaiTK/myapp-multiplatform/pull/new/add/license-mit?base=master
