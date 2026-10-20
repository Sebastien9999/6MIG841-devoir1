# Spécification - fonctions à implémenter

Fichier unique à modifier : `code/thumb_detector.py`. Ne modifier ni les tests, ni `detect_thumbs.py`, ni `emotion_detector.py`, ni les signatures, ni les docstrings.

## 1. `is_thumb_extended(metrics: HandMetrics) -> bool`

- Entrée : `metrics.distances_to_wrist` (21 distances poignet -> point, en pixels).
- Règle : `d[THUMB_MCP] < d[THUMB_IP] < d[THUMB_TIP]` (inégalités strictes chaînées).
- Sortie : un `bool` Python.
- Interdits : seuil absolu (pixels ou normalisé), comparaison d'ordonnées `y`.
- Remplacer le `raise NotImplementedError` (garder docstring et commentaires Indice/Tests) par :

```python
d = metrics.distances_to_wrist
return d[THUMB_MCP] < d[THUMB_IP] < d[THUMB_TIP]
```

| Main | Résultat |
| --- | --- |
| pouce levé (chaîne croissante) | True |
| pouce replié (chaîne décroissante) | False |
| pouce en crochet (MCP < TIP mais IP > TIP) | False |
| pouce à l'échelle x0.6 ou x1.5 | inchangé |

## 2. `ThumbCounter.update(self, raw_count: int) -> int`

- Garder la garde existante `if raw_count < 0: raise ValueError(...)`.
- Remplacer le `raise NotImplementedError` par :
  1. `self._history.append(raw_count)` (deque `maxlen=self._window`).
  2. Si `len(self._history) == self._window` ET `len(set(self._history)) == 1` : `self._stable = raw_count`.
  3. `return self._stable`.

| Scénario (window = W) | Résultat |
| --- | --- |
| W fois la même valeur v | le W-ième appel rend v ; `stable_count == v` |
| W-1 fois une nouvelle valeur après un stable connu | stable inchangé |
| alternance 0/1 après stable = 5 | stable reste 5 |
| W premiers appels avec 1 depuis l'init | W-1 fois 0 puis 1 |
| W = 1 | publie immédiatement |
| `update(-1)` | `ValueError` |

Ne pas changer `__init__`, `reset`, `window`, `stable_count`.

## Critères d'acceptation

- `python -m pytest test -q` (depuis `dev1`, avec le `.venv` du dépôt) : tout passe.
- Aucun autre fichier source modifié ; pas de `print` ; pas de nouvel import.
