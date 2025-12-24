# ตรวจสอบว่าเป็น git repo
git rev-parse --is-inside-work-tree

# ตรวจสอบ origin URL (ต้องมี PichaiTK/myapp-multiplatform)
git remote get-url origin

# ดู default branch ที่ origin ชี้
git remote show origin | sed -n 's/.*HEAD branch: //p'

# ตรวจสอบว่ามีไฟล์ LICENSE เดิมหรือไม่ (ไม่มีผลถ้าใช้ --force)
git ls-files | grep -i license || true

# หากทุกอย่างเรียบร้อย ให้รันสคริปต์ (Linux/macOS)
chmod +x add_license.sh
./add_license.sh         # หรือ ./add_license.sh --base main  หรือ ./add_license.sh --base master
# Windows PowerShell
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
# .\add_license.ps1 -Base master    # หรือ -Base main
