# Modèle codeur : implémente le Devoir 1 seul, d'après les plans, puis quitte.
# Le modèle 27B (codermodel, 18 Go) swappe sur 16 Go de RAM : on utilise le 7B.
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
$py = Join-Path $PSScriptRoot "..\.venv\Scripts\python.exe"

$msg = "Dans code/thumb_detector.py, remplace les deux 'raise NotImplementedError' en suivant spec.md : (1) is_thumb_extended retourne d[THUMB_MCP] < d[THUMB_IP] < d[THUMB_TIP] avec d = metrics.distances_to_wrist ; (2) ThumbCounter.update, apres la garde raw_count < 0, ajoute raw_count a self._history, met self._stable = raw_count si len(self._history) == self._window et que toutes les valeurs sont egales, puis retourne self._stable. Garde les docstrings. Ne modifie rien d'autre."

aider --model ollama_chat/codermodel `
  --timeout 3600 `
  --model-settings-file aider.models.yml `
  --no-git --yes-always --no-show-model-warnings `
  --no-auto-commits --no-check-update --no-analytics `
  --test-cmd "$py -m pytest test -q" --auto-test `
  --file code\thumb_detector.py `
  --read docs\superpowers\plans\spec.md `
  --message $msg
