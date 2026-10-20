# Audit - état du dépôt (Devoir 1, 6MIG841)

But : photographie de l'existant avant de coder. Voir `plan1.md` pour les étapes et `spec.md` pour le contrat.

## Arborescence

```
dev1/
  enonce.md
  code/thumb_detector.py     <- À ÉCRIRE (2 fonctions)
  code/detect_thumbs.py      <- fourni (webcam + MediaPipe), ne pas modifier
  code/emotion_detector.py   <- fourni, ne pas modifier
  test/conftest.py           <- fixtures cfg, emotion_cfg ; ajoute code/ à sys.path
  test/fabrique_mains.py     <- fabrique de mains synthétiques (21 points normalisés)
  test/test_thumb_detector.py, test_thumb_counter.py, test_hud.py, test_emotion_detector.py
```

## Ce qui manque (2 `raise NotImplementedError` dans `code/thumb_detector.py`)

| Fonction | Rôle | Dépend de |
| --- | --- | --- |
| `is_thumb_extended(metrics: HandMetrics) -> bool` | Vrai si `d[THUMB_MCP] < d[THUMB_IP] < d[THUMB_TIP]` (`metrics.distances_to_wrist`) | rien (feuille) |
| `ThumbCounter.update(raw_count: int) -> int` | Ajoute à `self._history` (deque `maxlen=window`), publie dans `self._stable` seulement si l'historique est plein ET unanime | rien (feuille) |

Les deux sont des feuilles indépendantes ; ordre libre.

## Déjà en place (ne pas toucher)

- `ThumbCounter.__init__`, `window`, `stable_count`, `reset`, et la garde `raw_count < 0` -> `ValueError` au début de `update`.
- `hand_metrics`, `count_folded_fingers`, `thumb_vertical_angle`, `analyse_hand`, `count_thumbs_up`, `to_pixels`.
- Constantes `THUMB_MCP=2`, `THUMB_IP=3`, `THUMB_TIP=4`.

## Contraintes lues dans les tests

- `test_is_thumb_extended_refuse_un_pouce_en_crochet_non_monotone` : MCP < TIP seul est INSUFFISANT ; il faut la chaîne stricte MCP < IP < TIP. Retourner un vrai `bool` (le test utilise `is False`).
- `test_verdict_des_cinq_mains_canoniques` : pouce levé -> `is_up=True`; ouverte, poing, pouce horizontal, pouce vers le bas -> `False`.
- Invariance d'échelle (x0.6, x1.5) : aucun seuil absolu dans `is_thumb_extended`.
- `test_les_premieres_maj_ne_publient_quau_dernier_tour_de_la_fenetre` : les `window-1` premiers appels rendent 0, le `window`-ième rend la valeur.
- Valeurs alternées : le stable reste à la dernière valeur publiée (pas de retour à 0).
- Valeur répétée moins de `window` fois : stable inchangé.

## Risques / pièges

- Pas de seuil normalisé fixe ni de comparaison d'ordonnées (pièges de l'énoncé).
- `window` peut valoir 1 : `update` doit alors publier immédiatement.
- Les tests importent `ihr_ros` (paquet de `Lab1/code/ihr_ros`, installé en mode éditable dans `.venv`, absent de ce dossier). La config `devoir1` vient de `ihr_config.json`.
- Les docstrings parlent de `Devoir1/` alors que le dossier est `dev1` ; `conftest.py` résout les chemins relativement à lui-même, donc sans impact.
- Ne pas modifier les tests ; pas de `print`.
