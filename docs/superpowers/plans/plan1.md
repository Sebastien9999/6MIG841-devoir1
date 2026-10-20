# Plan 1 - Implémentation du Devoir 1 (instructions pour aider)

Lire `audit.md` (état) et `spec.md` (contrat exact). Mettre à jour `progress.md` après chaque étape.

Fichiers à donner à aider : `code/thumb_detector.py` et `docs/superpowers/plans/progress.md` (modifiables) ; en lecture seule (`--read`) : `test/test_thumb_detector.py`, `test/test_thumb_counter.py`, `test/fabrique_mains.py`, `test/conftest.py`, `docs/superpowers/plans/spec.md`.

Règles : modifier UNIQUEMENT `code/thumb_detector.py` et `progress.md`. Ne jamais éditer les tests. Changement minimal par étape. Conserver docstrings et lignes `# Indice` / `# Tests`.

## Étape 0 - Baseline

1. Vérifier l'environnement : `.\.venv\Scripts\python.exe Lab1\code\check_env.py` (racine du dépôt contenant `.venv`).
2. `python -m pytest test -q` dans `dev1`. Attendu : échecs `NotImplementedError`. Noter le décompte dans `progress.md`.

## Étape 1 - Feuille A : `is_thumb_extended`

1. Implémenter selon `spec.md` §1.
2. `python -m pytest test/test_thumb_detector.py -q`
3. Attendu : tout vert. En cas d'échec, relire `test/fabrique_mains.py` avant de changer la règle ; ne pas ajouter de seuil.

## Étape 2 - Feuille B : `ThumbCounter.update`

1. Implémenter selon `spec.md` §2.
2. `python -m pytest test/test_thumb_counter.py -q`
3. Attendu : 5 tests verts.

## Étape 3 - Suite complète

1. `python -m pytest test -q` : tout passe.
2. Vérifier qu'il ne reste aucun `NotImplementedError` dans `code/thumb_detector.py` et que seuls 2 corps de fonction ont changé.

## Étape 4 - Vérification webcam (optionnelle)

`python code/detect_thumbs.py` : le compte affiché reste stable même si la détection hésite une trame sur deux. Noter le résultat.

## Étape 5 - Rapport (rédigé par l'étudiant, hors code)

Sections (100 pts) : Introduction 8, Bibliothèques 7, Méthode 15, Schéma bloc 10, Logigramme 15, Explications du code 10, Tests 15, Résultats et mesures 10, Discussion et limites 5, Conclusion 3, Références et hygiène 2.
Matière : défauts évités (seuil lié à la distance, ordonnées sur main inclinée), filtre temporel (retard de `window` trames, ~100 ms à 30 fps), logigramme (feuilles indépendantes `is_thumb_extended` -> `analyse_hand` -> `count_thumbs_up`, et `ThumbCounter.update`), sortie de pytest.

## Terminé quand

- `pytest test` entièrement vert et `progress.md` entièrement coché.
