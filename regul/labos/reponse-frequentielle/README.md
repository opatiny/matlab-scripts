# Reponse frequentielle experimentale et theorique
- flexplant N1
- on utilise la pleine échelle des mesures -> on s'assure que la mesure couvre toute la plage de l'instrument, ce qui permet de réduire le rapport signal sur bruit
- on doit faire bien attention de prendre un nombre de période entier afin d'obtenir une transformée de fourrier correcte
- on observe un pic du bode d'amplitude à omega = 119.4 rad/s 
- frequence du signal:  
- Le bode d'amplitude est extrêmement bruité pour les hautes fréquences, car le bruit du signal est justement dans ces fréquences et que en réalité on s'attend à une faible excitation, puisqu'on a un signal carré. Le rapport des deux donne donc des valeurs qui varient énormément.
- signal binaire pseudo aleatoire (SBPA): quand on effectue plusieurs périodes, on voit que la réponse du système est un régime permanant périodique au bout d'un moment.
- le sbpa contient toutes les fréquences excepté zéro, car on n'a pas d'offset. Le spectre d'amplitude de ce signal est donc plat (on excite toutes les fréquences de la même manière).
- trouver le Bode de notre systeme pour toutes les fréquences nous permettra de retrouver la fonction de transfert et donc de pouvoir réguler le système correctement.
