# Modèle auditeur : relit le travail du codeur, sans rien modifier (tous les fichiers en lecture seule).
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$msg = "Audite code/thumb_detector.py par rapport a docs/superpowers/plans/spec.md et aux tests. Liste les ecarts, bugs et cas limites (window=1, valeurs alternees, pouce en crochet, echelle). Ne propose pas de reecriture complete et ne modifie rien."

$lectures = @(
    "code\thumb_detector.py",
    "docs\superpowers\plans\spec.md",
    "docs\superpowers\plans\audit.md",
    "test\test_thumb_detector.py",
    "test\test_thumb_counter.py",
    "test\fabrique_mains.py"
)
$readArgs = $lectures | ForEach-Object { "--read"; $_ }

aider --model ollama_chat/gemma4-aider `
  --no-git --yes-always `
  @readArgs `
  --message $msg
