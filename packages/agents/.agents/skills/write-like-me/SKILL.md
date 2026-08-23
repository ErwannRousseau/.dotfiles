---
name: write-like-me
description: "Oral écrit. Use whenever Codex drafts, rewrites, or adapts user-facing prose in the user's voice, in French or English."
---

# Write Like Me

Écrire comme un vocal propre envoyé à un collègue malin : oral dans le rythme et les mots, relu juste assez pour retirer les hésitations. Travailler les deux couches : reconstruire les idées quand elles peuvent être plus claires ou plus fortes, puis retravailler les mots qui les portent. Préserver les faits, faire entendre un point de vue et glisser un petit sourire adapté au contexte.

## 1. Régler la température

Identifier le lecteur, l'objectif, son état d'esprit, le niveau d'enjeu et la langue. Choisir une température avant d'écrire :

- **Sobre** pour erreur, incident, sécurité, mauvaise nouvelle ou sujet sensible : humain, calme, factuel, avec un sourire discret qui ne minimise pas le problème.
- **Chaleureux** pour travail courant : direct, détendu, avec une petite tournure qui fait sourire.
- **Joueur** pour tutoriel, lancement ou récit : complice, imagé, avec plusieurs pointes de fun bien espacées.

Terminer cette étape quand le lecteur, le résultat attendu, la température et la forme du clin d'œil tiennent chacun en quelques mots.

## 2. Retrouver le fond

Relever l'intention, les faits, les arguments utiles, les contraintes, les engagements et les degrés de certitude. Pour chaque passage, formuler mentalement ce qu'il veut vraiment dire et pourquoi le lecteur doit s'y intéresser, sans reprendre sa formulation. Quand l'utilisateur reformule lui-même un brouillon, relever aussi son mécanisme : ordre des idées, verbes retenus, niveau de concret, place des détails et manière d'ancrer une responsabilité. Cette correction devient une règle de profil pour les contextes analogues.

Pour une création, définir les idées à transmettre avant de rédiger. Pour une reformulation, séparer ce qui doit rester intact de tout ce qui peut bouger : ordre, paragraphes, titres, rythme et mots.

Pour un article à reformuler, construire un plan de travail depuis cette liste d'idées sans reprendre les intertitres ni les frontières de sections du texte source. Regrouper les passages autour de quelques idées fortes quand cela rend le propos plus net, puis répartir sous chacune les faits qui la prouvent, la nuancent ou montrent sa conséquence. Le nouveau plan doit au minimum regrouper ou déplacer une idée; conserver l'architecture source seulement si l'utilisateur l'a explicitement demandé. Traiter la structure d'origine comme une information, pas comme un moule.

Terminer cette étape quand les idées centrales et les éléments intouchables suffisent à expliquer le texte sans dépendre de ses phrases d'origine. Pour un article reformulé, le plan de travail doit aussi pouvoir se lire sans voir le plan source en transparence.

## 3. Reconstruire le texte

Choisir exactement une opération : création ou reformulation. Choisir exactement un cadre. Si plusieurs cadres semblent possibles, prendre le premier dans cet ordre : professionnel ou sensible, long ou technique, court ou courant.

Lire [le profil de voix](references/voice-profile.md) quand le cadre est long ou technique, ou quand l'opération est une reformulation. Lire [le registre technique](references/technical-register.md) dès que la source ou la cible contient du vocabulaire de dev, de release ou de travail en équipe.

### Opération

#### Création

Construire le texte depuis les idées de l'étape 2. Ouvrir sur une information, une observation franche, une motivation réelle ou un problème reconnaissable. Organiser chaque passage autour d'un point, de sa raison et de sa conséquence.

#### Reformulation

Mettre la formulation source de côté et rédiger depuis le plan de travail de l'étape 2, sans réécrire les paragraphes en place. Travailler depuis l'idée globale pour un article, le message entier pour un texte court et l'ordre des faits pour un email professionnel. Sur un sujet sensible, améliorer le texte sans transformer sa gravité en exercice de style.

Fusionner, déplacer ou supprimer les passages qui répètent la même idée lorsque cela rend l'argument plus naturel. Donner à chaque section une conclusion distincte; fusionner celles qui défendent le même point, même si le texte source les présente comme deux sujets séparés. Reformuler les titres génériques pour qu'ils portent déjà une idée, un bénéfice ou une position. Conserver une phrase source lorsqu'elle est déjà juste.

Si deux sections répondent à la même question ou mènent à la même conclusion, les regrouper. Sans demande explicite de préserver la structure, une correspondance section par section puis paragraphe par paragraphe signale une correction de surface, pas une reconstruction.

Compresser seulement quand cela améliore la clarté, le rythme ou la force du propos : répétition, commentaire inutile, précaution vide ou plusieurs phrases pour une seule idée. Respecter toute longueur demandée; sans contrainte, laisser le contenu décider.

Rendre une position plus nette quand elle est déjà soutenue ou clairement implicite. Ajouter images, comparaisons, transitions et touches de fun sans inventer de fait, d'expérience, de cause, de promesse ni de conclusion. Appliquer les transformations canoniques du profil dans les cas analogues.

### Cadre

#### Professionnel ou sensible

Conserver chaleur et simplicité, puis calibrer la familiarité selon la relation. Rendre demandes, décisions et prochaines actions impossibles à manquer. Pour un report, un incident ou une mauvaise nouvelle, suivre ce fil : conséquence concrète, cause, action en cours, engagement vérifiable. Faire venir la chaleur de la franchise; chaque phrase doit apporter un fait déjà fourni. Placer le sourire sur l'action existante, avec une courte relance orale comme `Bref, pas le timing idéal, mais l'équipe corrige ça avant la livraison.` Garder la conséquence sobre et intacte. Convertir les formules d'entreprise en langage parlé et précis : `Nous souhaitons vous informer que X` devient `X`; `merci pour votre compréhension` devient `merci pour votre patience`.

#### Long ou technique

Partir du problème ou de la motivation, montrer rapidement un exemple concret, puis expliquer le mécanisme et ses limites. Avancer comme pendant un pair programming : concret d'abord, mécanisme ensuite, limite à la fin.

#### Court ou courant

Donner le résultat dès la première phrase. Garder la sortie facile à scanner et traiter le message comme une seule idée.

### Option de style

Activer le flag `--dm` uniquement quand l'utilisateur le demande, surtout pour un message privé court. Alléger la ponctuation au jugé, sans la supprimer mécaniquement : garder les points pour séparer les idées, les virgules pour les pauses naturelles ou les listes, et les autres signes quand ils clarifient réellement le message. Retirer surtout la ponctuation décorative ou trop formelle pour obtenir un texte qui ressemble à un message tapé à la main. Écrire en minuscules par défaut, y compris en début de phrase quand la lecture reste claire, mais garder les majuscules utiles aux noms propres, aux sigles et à la compréhension. Garder les apostrophes et contractions naturelles, les marqueurs et la structure des listes à puces, ainsi que la ponctuation indispensable aux URLs, au code, aux nombres ou à la compréhension. Ne pas activer ce mode pour un article, un email professionnel, une documentation ou un sujet sensible sans demande explicite.

Terminer cette étape quand une opération et un cadre ont été appliqués, que chaque passage porte une idée utile et que les références exigées ont été suivies.

## 4. Retravailler les mots

- Prendre position quand les éléments le permettent : dire ce qui est simple, pénible, solide, limité ou réellement utile, puis donner la raison.
- Parler au lecteur avec `vous`, `on` ou `you`; utiliser `je`/`I` uniquement pour une expérience ou une opinion réellement fournie.
- Garder la syntaxe de l'oral : `ça`, `on va`, `en gros`, `juste`, `bon`, `au final`, `et c'est tout` lorsque ces mots viennent naturellement. Commencer une phrase par `Et` ou `Mais` si c'est ainsi qu'elle serait dite.
- Nettoyer le vocal, pas sa personnalité : retirer hésitations, répétitions involontaires et mots de remplissage accumulés; garder les reprises qui donnent volontairement du rythme.
- Alterner une phrase courte qui tranche avec des phrases plus développées qui expliquent.
- Préférer verbes concrets, vocabulaire courant et détails observables aux abstractions de présentation.
- En français, employer un oral maîtrisé : `on va`, `voilà`, `petit`, `sympa` ou `attaquons-nous à` seulement quand la phrase les appelle.
- En anglais, employer les contractions et des transitions parlées comme `let's`, `here's`, `first things first` ou `and that's it` quand elles tombent juste. Adapter les images au lieu de traduire une expression française mot à mot.
- Quand le registre technique est chargé, appliquer toutes ses formes exactes.
- Bannir le caractère `—` dans la sortie. Le remplacer par une ponctuation naturelle ou une nouvelle phrase.
- Ajouter au moins un petit sourire par texte. Pour un article, garder une présence légère tout au long du texte et une ou deux formulations vraiment mémorables. Accrocher chaque touche à l'idée voisine.

Terminer cette étape quand les mots renforcent les idées reconstruites, que le texte se lit naturellement à voix haute et que le sourire respecte la température.

## 5. Faire le test de la chaise voisine

Relire une fois comme si le lecteur était assis à côté. Le texte est prêt seulement si :

- la première phrase apporte déjà quelque chose;
- chaque passage dit clairement ce qu'il veut dire et pourquoi le lecteur doit s'y intéresser;
- une opinion ou un angle précis distingue le texte d'un contenu interchangeable;
- le rythme comporte une variation naturelle;
- le texte ressemble à quelque chose que l'utilisateur pourrait dire dans un vocal propre;
- le petit sourire choisi respecte la température et repose uniquement sur les faits fournis;
- les faits, citations, engagements et degrés de certitude sont restés intacts;
- chaque modification améliore la clarté, le rythme, la structure, le point de vue ou la mémorisation;
- une bonne phrase source n'a pas été changée sans bénéfice;
- une compression éventuelle sert le texte au lieu de viser une réduction arbitraire;
- l'opération, le cadre et les références exigées ont tous été appliqués;
- la fin avance au lieu de répéter l'introduction;
- la version anglaise ou française sonne écrite dans cette langue.
- le caractère `—` n'apparaît nulle part dans la sortie.
- si le flag `--dm` est actif, la ponctuation et les majuscules ont été allégées avec discernement sans rendre le message ambigu et la structure des listes à puces est intacte.

Si une reformulation suit encore l'ordre et la syntaxe des phrases sources avec surtout des synonymes, revenir à l'étape 2. Pour un article, faire de même quand le résultat conserve à la fois la même suite de sections et une correspondance paragraphe par paragraphe, sauf si l'utilisateur a demandé de préserver la structure. Une phrase déjà juste peut rester intacte; le reste doit être reconstruit quand cela apporte un gain réel.

Si une modification n'apporte aucun gain identifiable, restaurer la formulation source. Refaire ensuite toute la liste. Terminer quand chaque ligne est vraie.
