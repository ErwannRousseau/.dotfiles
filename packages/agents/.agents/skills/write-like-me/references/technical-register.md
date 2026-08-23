# Registre technique parlé

Charger ce registre pour tout texte qui contient du vocabulaire de dev, de release ou de travail en équipe. Appliquer chaque règle pertinente avant de rendre le texte.

## Vocabulaire

Le texte reste français, mais les mots de travail restent ceux des devs.

| Formulation distante | Forme attendue |
|---|---|
| `la branche principale` | `main`, seulement quand c'est son vrai nom |
| `fusionner` | `merge` |
| `revue` ou `révision` du code | `review` |
| `modifications` | `changes` |
| `les développeurs` | `les devs` |
| `demande de fusion` | `PR` ou `pull request` |
| `mise en production` dans un contexte de release | `release` |

Employer naturellement `pipeline`, `changelog`, `commit`, `build`, `deploy`, `rollback` et `workflow` lorsque l'équipe utiliserait ces mots à l'oral.

## Formes exactes

Employer `merge` et `review` directement comme verbes : `avant de merge`, `peut être review`, `les devs review les changes`. Laisser l'objet implicite quand le contexte le donne déjà.

Garder ces formes positives. Écarter `fusionner`, `revue`, `faire une review`, `reviewer`, `reviewé`, `reviewable` et `la merge` dans ce registre.

## Transformations canoniques

| Avant | Cible |
|---|---|
| `La release part bien de la branche principale.` | `La release part de main.` |
| `Cette pull request est mon espace de préparation. Depuis mon téléphone, je peux relire le changelog, vérifier les fichiers modifiés et voir le résultat des validations avant de fusionner. La release devient un changement normal du projet, visible et révisable, plutôt qu'une suite de commandes lancées hors de GitHub.` | `Depuis mon téléphone, je peux relire le changelog, vérifier une dernière fois les changes avant de merge. La release est clairement visible et peut être review, plutôt qu'une suite de commandes lancées hors de GitHub.` |
| `Je n'ai donc pas supprimé l'humain du pipeline. J'ai limité son rôle aux décisions qui lui appartiennent.` | `Je n'ai donc pas supprimé l'humain du pipeline. Je limite juste son rôle et son temps dans ce pipeline.` |

Terminer la passe quand chaque terme technique pertinent correspond à ce registre et que `main` n'a pas été inventé comme nom de branche.
