Clear-Host

Write-Host ""
Write-Host "================================="
Write-Host " EPIC PQS Repository Update"
Write-Host "================================="
Write-Host ""

Write-Host "Exporting Solution..."
pac solution export --name PQS_EPIC --path solution.zip --managed false --overwrite

Write-Host ""
Write-Host "Unpacking Solution..."
pac solution unpack --zipfile solution.zip --folder src --packagetype Unmanaged

Write-Host ""
Write-Host "Unpacking Canvas App..."
pac canvas unpack --msapp src\CanvasApps\pqs_epicpqs_63592_DocumentUri.msapp --sources src\CanvasApps\app --overwrite

Write-Host ""
Write-Host "Git Status"
Write-Host "----------"
git status

Write-Host ""
Write-Host "Staging Files..."
git add .

Write-Host ""
$msg = Read-Host "Commit Message"

git commit -m $msg

Write-Host ""
Write-Host "Pushing To GitHub..."
git push

Write-Host ""
Write-Host "================================="
Write-Host " Repository Updated Successfully"
Write-Host "================================="
Write-Host ""