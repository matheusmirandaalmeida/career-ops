# Executar no PowerShell atual. Altera apenas variáveis do processo.
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('tecnologia', 'administrativo')]
    [string]$Perfil
)

$perfilRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot $Perfil))
$caminhos = @{
    CAREER_OPS_ROOT = $perfilRoot
    CAREER_OPS_DATA_DIR = $perfilRoot
    CAREER_OPS_CV = Join-Path $perfilRoot 'cv.md'
    CAREER_OPS_PROFILE = Join-Path $perfilRoot 'config/profile.yml'
    CAREER_OPS_PORTALS = Join-Path $perfilRoot 'portals.yml'
    CAREER_OPS_TRACKER = Join-Path $perfilRoot 'data/applications.md'
    CAREER_OPS_PIPELINE = Join-Path $perfilRoot 'data/pipeline.md'
    CAREER_OPS_SCAN_HISTORY = Join-Path $perfilRoot 'data/scan-history.tsv'
    CAREER_OPS_TRACKER_DB = Join-Path $perfilRoot 'data/applications.db'
    CAREER_OPS_ADDITIONS = Join-Path $perfilRoot 'batch/tracker-additions'
    CAREER_OPS_BATCH_STATE = Join-Path $perfilRoot 'batch/batch-state.tsv'
    CAREER_OPS_REPORTS_DIR = Join-Path $perfilRoot 'reports'
    CAREER_OPS_PDF_INDEX = Join-Path $perfilRoot 'data/pdf-index.tsv'
    CAREER_OPS_FOLLOWUPS = Join-Path $perfilRoot 'data/follow-ups.md'
    CAREER_OPS_BLACKLIST = Join-Path $perfilRoot 'data/blacklist.md'
}

# Validar antes de mudar o ambiente; junctions/symlinks podem unir os perfis.
foreach ($relativo in @('cv.md', 'config/profile.yml', 'portals.yml', 'modes/_profile.md', 'modes/_custom.md', 'data/applications.md')) {
    if (-not (Test-Path -LiteralPath (Join-Path $perfilRoot $relativo) -PathType Leaf)) {
        throw "Perfil incompleto ou inexistente: $Perfil ($relativo)"
    }
}
foreach ($destino in $caminhos.Values) {
    $atual = $destino
    while ($atual) {
        if (Test-Path -LiteralPath $atual) {
            $item = Get-Item -LiteralPath $atual -Force
            if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
                throw "Selecao recusada: caminho redirecionado em $Perfil."
            }
        }
        $atual = Split-Path -Path $atual -Parent
    }
}

foreach ($nome in $caminhos.Keys) {
    [Environment]::SetEnvironmentVariable($nome, $caminhos[$nome], 'Process')
}
Write-Output "Perfil ativo neste PowerShell: $Perfil ($perfilRoot). Inicie o agente a partir desta sessão, na raiz da instalação."
# sync-batch-input: --pipeline/--input/--state sao argumentos proprios;
# batch-runner.sh fixa input/state na instalacao e sobrescreve BATCH_STATE.
# persist-evaluation-report.mjs por CLI grava no cwd, que deve ser o DATA_ROOT.
Write-Warning 'Reinicie agentes e servidores existentes: eles mantem o ambiente anterior. Batch em massa nao e isolado por este seletor. A CLI persist-evaluation-report.mjs exige cwd no DATA_ROOT.'
