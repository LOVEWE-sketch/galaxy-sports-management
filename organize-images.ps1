$imagesPath = "c:\Users\MACK\Desktop\galaxy-clean\assets\images"
$backupPath = "c:\Users\MACK\Desktop\galaxy-clean\assets\images-backup"

Write-Host "=== Galaxy Sports Image Organizer ===" -ForegroundColor Cyan

if (!(Test-Path $backupPath)) {
    Copy-Item -Path $imagesPath -Destination $backupPath -Recurse -Force
    Write-Host "Backup created" -ForegroundColor Green
}

$folderMappings = @{
    "mack" = "mack-bs-briggs"
    "ajayi" = "ajayi-adeniran"
    "acacia" = "acacia-small"
    "lucy" = "lucy-massaquoi"
    "linda" = "linda-amoka"
    "lisa" = "lisa-shazelle"
    "shazelle" = "lisa-shazelle"
    "elshaddi" = "elshaddi-achempong"
    "fred" = "fred-nayou"
    "tartev" = "tartev-kchernian"
    "rianna" = "rianna-cyrus"
    "sarah" = "sarah-essam"
    "trial" = "trials"
    "academy" = "academy"
    "flyer" = "news"
    "signed" = "news"
    "logo" = "logos"
    "flag" = "flags"
}

$imageFiles = Get-ChildItem -Path $imagesPath -File -Include *.jpg,*.jpeg,*.png,*.webp,*.svg,*.JPG,*.PNG
$movedCount = 0

foreach ($file in $imageFiles) {
    $fileName = $file.Name.ToLower()
    $folderName = $null
    
    foreach ($keyword in $folderMappings.Keys) {
        if ($fileName -like "*$keyword*") {
            $folderName = $folderMappings[$keyword]
            break
        }
    }
    
    if ($folderName) {
        $targetFolder = Join-Path $imagesPath $folderName
        if (!(Test-Path $targetFolder)) {
            New-Item -Path $targetFolder -ItemType Directory -Force | Out-Null
            Write-Host "Created: $folderName" -ForegroundColor Green
        }
        
        $targetPath = Join-Path $targetFolder $file.Name
        if (!(Test-Path $targetPath)) {
            Move-Item -Path $file.FullName -Destination $targetPath -Force
            Write-Host "  Moved: $($file.Name)" -ForegroundColor Gray
            $movedCount++
        }
    }
}

Write-Host "`nMoved $movedCount files" -ForegroundColor Green
Get-ChildItem -Path $imagesPath -Directory | ForEach-Object {
    $count = (Get-ChildItem -Path $_.FullName -File).Count
    Write-Host "$($_.Name): $count images" -ForegroundColor Cyan
}
