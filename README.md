Temps-Réel pour le Big Data avec Spark Streaming
1 Introduction
Sylvain Gault
15 juin 2021

Ce TP est à réaliser sous Linux par groupe de 3 ou 4. Il sera à rendre sur Teams à une date précisée ultérieurement.
Vous rendrez un rapport en PDF contenant au moins les réponses aux questions ainsi que toute description nécessaire à la reproduction de vos résultats. Numérotez vos réponses dans votre rapport et incluez au moins une phrase pour chaque question.
Vous compilerez les programmes C avec gcc avec les options -pedantic -Wall -Wextra et vous vérifierez tous les retours de fonction pour les cas d’erreur. Vous joindrez un Makefile pour compiler vos programmes.

2 Threads
Dans cette section vous aurez certainement besoin de vous référer aux pages de manuel des fonctions pthread.


Exercice 1 Premiers threads
Dans cet exercice on écrira un premier programme qui ne fait rien d’autre que de l’affichage basique.
1. Créez une fonction qui affiche Hello World, puis attend 10 secondes avec la fonction sleep, et affiche Bye. Testez-la. Ce sleep servira à simuler le travail du thread.
2. Lisez le man pthread_create et décrivez ses différents arguments et sa valeur de retour.
3. Utilisez la fonction pthread_create pour créer un thread qui exécutera votre fonction.
4. Que se passe-t-il si vous exécutez votre programme ?
5. Lisez le man pthread_join et décrivez ses différents arguments et sa valeur de retour.
6. Rajoutez un appel à pthread_join pour attendre la fin de votre thread.
7. Modifiez votre programme pour lancer N threads en parallèle. Testez-le.

Dans les exercices suivants, il ne sera pas demandé explicitement de lire et décrire les pages de man des différentes fonctions citées. Cependant, leur lecture attentive est probablement indispen- sable.
Exercice 2 Passage d’arguments et récupération de résultats

Le but de cet exercice est de passer correctement des arguments aux threads sans tomber dans les pièges classiques.

1. Utilisez le dernier argument de la fonction pthread_create pour donner un numéro unique à chaque thread. Chaque thread devra afficher son numéro au début et à la fin de son exécution.
2. Que se passe-t-il ? Tous vous threads ont-il un numéro unique ?
3. Utilisez un tableau pour stocker tous les arguments des threads et testez à nouveau. Désor- mais, chaque fois que vous afficherez un message dans vos threads, vous le préfixerez de son numéro entre crochets.
4. Utilisez les fonctions srand et rand pour que chaque thread attende entre 1 et 5 secondes après avoir affiché son premier message, puis affiche un deuxième message avant de commen- cer le sleep de 10 secondes.
5. Pourrécupérerlerésultatducalculdechaquethread,ilyaplusieurspossibilités.Lapremière est de placer le résultat dans une structure passée en argument. Utilisez cette technique pour que chaque thread renvoie son numéro au carré. Affichez ces résultats dans le thread principal.
6. Uneautresolutionestd’utiliserlavaleurderetourdelafonctionduthread.Cepointeurest récupéré tel quel par l’appel à pthread_join. Implémentez cette technique et testez-la. Note : Il existe d’autres solutions, comme utiliser des variables globales ou d’autres mécanismes de communication.

Exercice 3 Manque de synchronisation
Cet exercice sert simplement à mettre en évidence les problèmes de synchronisation.

1. Déclarez une variable globale entière initialisée à 0.
2. Lancez N threads qui ne font rien d’autre qu’incrémenter cette variable globale avec l’opé- rateur ++ 1000000 de fois avec une boucle for.
3. Affichez le résultat final dans votre fonction principale une fois que tous les threads sont terminés.
4. Quelle devrait être la valeur affichée? Quelle est la valeur réellement affichée? Comment expliquer ce phénomène ?


Exercice 4 Pattern Master - Workers

Dans cet exercice on réalisera des calculs simples avec le pattern Master - Workers pour faire la somme des éléments d’un tableau.

1. Créez un nouveau programme qui initialise aléatoirement un tableau de M entiers. M est supposé très grand.
2. Lancez N threads dans la fonction principale en passant en argument le tableau. Attention à ne pas dupliquer le tableau.
3. Faites en sorte que chaque thread ait accès à un segment de tableau distinct des autres et de taille approximativement égale.
4. Vérifiezquecelafonctionneenaffichantlecontenudusegmentdanschaquethread.N’oubliez pas de préfixer chaque message par le numéro du thread.
5. Faites en sorte que chaque thread calcul la somme des éléments du segment de tableau qui lui a été assigné et le renvoie au thread principal.
6. Faites la somme finale des éléments dans le thread principal. 2

Exercice 5 Mesure du temps d’exécution

Le but de cet exercice est de rendre l’utilité des threads un peu plus concrète en mesurant des durées d’exécution en utilisant la fonction clock.

1. Utilisezcettefonctionpourmesurerdesduréesd’exécutionensecondesavecuneprécisionau centième de seconde. Utilisez-la pour mesurer des centaines de fois la durée d’un sleep(1) et faites la moyenne de ces mesures.
2. Mesurez des centaines de fois la durée de rien du tout (placez simplement deux appels à clock consécutifs). Quelle valeur mesurez-vous ? Qu’en déduisez-vous ?
3. Utilisez cette fonction pour mesurer la durée d’exécution de votre somme de tableau de l’exercice précédent. Faites en sorte que le tableau soit suffisamment grand pour que la durée d’exécution soit significativement supérieure à 0.
4. Faites varier le nombre de threads et observez la variation du temps de calcul.
5. Modifiez votre programme de somme de tableau pour que chaque thread ne fasse pas la somme d’un segment contigue du tableau, mais d’une valeur sur M. Vérifiez que votre programme est correct en le testant sur des petits exemples.
6. Pourunemêmetailledetableauetunmêmenombredethread,ya-t-ilunedifférencedeper- formance entre les deux techniques de sommation de tableau ? Si oui, comment l’expliqueriez- vous ?
3 OpenMPI
