# Reponse frequentielle experimentale et theorique

- flexplant N1
- on utilise la pleine échelle des mesures -> on s'assure que la mesure couvre toute la plage de l'instrument, ce qui permet de réduire le rapport signal sur bruit
- on doit faire bien attention de prendre un nombre de période entier afin d'obtenir une transformée de fourrier correcte
- on observe un pic du bode d'amplitude à omega = 119.4 rad/s
- frequence du signal:
- Le bode d'amplitude est extrêmement bruité pour les hautes fréquences, car le bruit du signal est justement dans ces fréquences et que en réalité on s'attend à une faible excitation, puisqu'on a un signal carré. Le rapport des deux donne donc des valeurs qui varient énormément.On voit aussi qu'il y a des fréquences pour lesquelles on a résonnance. Elles sont précédées par des anti-résonnances.
- signal binaire pseudo aleatoire (SBPA): quand on effectue plusieurs périodes, on voit que la réponse du système est un régime permanant périodique au bout d'un moment.
- le sbpa contient toutes les fréquences excepté zéro, car on n'a pas d'offset. Le spectre d'amplitude de ce signal est donc plat (on excite toutes les fréquences de la même manière).
- trouver le Bode de notre systeme pour toutes les fréquences nous permettra de retrouver la fonction de transfert et donc de pouvoir réguler le système correctement.
- sbpa: on peut voir que le diagramme de phase du signal est très bizarre à droite. Comme on a un système d'ordre 2, on s'attendrait à ce que la phase tende vers -180° pour les hautes fréquences. Ce qu'on observe est dû au fait que la phase réelle est parfois supérieure à 180°, mais que la fonction clamp entre -180 et 180°. C'est pour ça qu'on observe ces oscillations.
- On adapte les paramètres du modèle pour le faire correspondre le mieux possible aux mesures. La fréquence de résonnance observée nous donne $\omega_n$ et on modifie un peu le coefficient d'amortissement $K$.
- identification: on fait correspondre les valeurs expérimentales à un modèle
- n: nombre de bits de la sbpa
- pour augmenter la résolution spatiale, on augmente la durée de la période de la SBPA en posant n = 16 et Ns = 65'535
