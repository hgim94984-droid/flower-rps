# 오늘의 꽃 가위바위보 - 인터넷에 올리기
#
# 내용을 고친 뒤 터미널에서 .\deploy.ps1 을 입력하면 됩니다.
# 1~2분 뒤 https://hgim94984-droid.github.io/flower-rps/ 에 반영됩니다.
#
# 처음 한 번은 저장소부터 만들어야 합니다:
#   gh repo create flower-rps --public --source=. --remote=origin --push
# 그다음 GitHub 저장소 화면에서 Settings > Pages > Source 를 main / (root) 로 지정하세요.

# git 은 정상 동작 중에도 경고 문구를 내보내므로 여기서 멈추지 않도록 한다
$ErrorActionPreference = 'Continue'
Set-Location $PSScriptRoot

$REPO = 'https://github.com/hgim94984-droid/flower-rps.git'
$NAME = 'hgim94984-droid'
$MAIL = '306952544+hgim94984-droid@users.noreply.github.com'

if (-not (Test-Path .git)) {
  Write-Host ''
  Write-Host '[준비] 이 폴더를 git 저장소로 만드는 중...' -ForegroundColor Cyan
  git init -q
  git branch -M main
  git remote add origin $REPO
}

# 실명 메일이 노출되지 않도록 이 저장소에만 noreply 메일을 쓴다
git config user.name $NAME
git config user.email $MAIL

Write-Host ''
Write-Host '[1/2] 바뀐 내용 확인 중...' -ForegroundColor Cyan
git add -A
git commit -q -m "가위바위보 업데이트"
if ($LASTEXITCODE -ne 0) {
  Write-Host '바뀐 내용이 없습니다. 그대로 다시 올립니다.' -ForegroundColor DarkGray
}

Write-Host ''
Write-Host '[2/2] 인터넷에 올리는 중...' -ForegroundColor Cyan
git push -q -u origin main
if ($LASTEXITCODE -ne 0) {
  Write-Host ''
  Write-Host '올리지 못했습니다. 아래를 확인하세요.' -ForegroundColor Red
  Write-Host ' - 저장소를 아직 안 만들었다면: gh repo create flower-rps --public --source=. --remote=origin --push'
  Write-Host ' - 로그인 상태 확인: gh auth status'
  exit 1
}

Write-Host ''
Write-Host '완료했습니다.' -ForegroundColor Green
Write-Host '1~2분 뒤 아래 주소에 반영됩니다.'
Write-Host 'https://hgim94984-droid.github.io/flower-rps/' -ForegroundColor Yellow
Write-Host ''
Write-Host '바로 안 바뀌면 브라우저에서 Ctrl+Shift+R 을 눌러 새로고침하세요.'
Write-Host ''
