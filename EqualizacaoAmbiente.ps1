$base_path = "C:\tfsaz\CI\Squads\Toll"

$ci_branches = @()
$squad_branches = @(
    "$($base_path)\REPOM.ATENDIMENTO",
    "$($base_path)\REPOM.CALLCENTERASP",
    "$($base_path)\REPOM.CORE",
    "$($base_path)\REPOM.DOCUMENTACAO",
    "$($base_path)\REPOM.EXPRESS",
    "$($base_path)\REPOM.EXPRESSNET",
    "$($base_path)\REPOM.FINANCEIRO",
    "$($base_path)\REPOM.FRETE",
    "$($base_path)\Repom.Integracao.Interna.Rotas.Automaticas.API",
    "$($base_path)\REPOM.INTRANETASP",
    "$($base_path)\REPOM.INTRANETROTASNET",
    "$($base_path)\REPOM.INTRANETWEB",
    "$($base_path)\REPOM.SISTEMAAPOIO",
    "$($base_path)\REPOM.SISTEMABASE",
    "$($base_path)\REPOM.SISTEMACONTAS",
    "$($base_path)\REPOM.SISTEMAEXTERNO",
    "$($base_path)\REPOM.SISTEMAGESTAOFRETE",
    "$($base_path)\REPOM.SISTEMAINTEGRACA",
    "$($base_path)\REPOM.SISTEMAPAGAMENTO",
    "$($base_path)\REPOM.SISTEMAROTERIZACAO",
    "$($base_path)\REPOM.SISTEMAVPR",
    "$($base_path)\REPOM.TITULONET",
    "$($base_path)\REPOM.USUARIO",
    "$($base_path)\REPOM.VALEPEDAGIO",
    "$($base_path)\REPOM.VPRASP",
    "$($base_path)\REPOM.VPRCARDDATAASP2",
    "$($base_path)\REPOM.VPRNET",
    "$($base_path)\VISA.CARGA"
)

foreach ($item in $squad_branches) {
    $item = $item -replace "\\Squads\\Toll", ""
    $ci_branches += $item
}

for ($i = 0; $i -lt $squad_branches.Count; $i++) {
    Write-Host "Getting $($ci_branches[$i])"
    tf get $ci_branches[$i] /recursive /version:T

    Write-Host "Getting $($squad_branches[$i])"
    tf get $squad_branches[$i] /recursive /version:T

    Write-Host "Merging $($ci_branches[$i]) to $($squad_branches[$i])"
    tf merge $ci_branches[$i] $squad_branches[$i] /recursive /version:T /noprompt
}
