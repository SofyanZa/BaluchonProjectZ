#  BaluchonProjectZ


<img width="197" alt="Capture d’écran 2022-07-25 à 13 06 48" src="https://zupimages.net/up/22/30/181d.png"><img width="194" alt="Capture d’écran 2022-07-25 à 13 08 44" src="https://zupimages.net/up/22/30/h1cr.png"><img width="196" alt="Capture d’écran 2022-07-25 à 13 09 40" src="https://zupimages.net/up/22/30/ll0n.png">


**Description de l'application :**

Le Baluchon est donc une application de trois pages :

Obtenez le taux de change entre le dollar et votre monnaie actuelle.
Traduisez depuis votre langue favorite vers l'anglais
Comparez la météo locale et celle de votre bon vieux chez vous (histoire d'être bien content d'être parti... ou pas !)
Pour naviguer entre les pages, vous utiliserez une barre d'onglet ("tab bar"), chaque onglet correspondant à une des trois pages décrites précédemment.

Lors des appels au réseaux dans l'application, si une erreur a lieu, vous devez la présenter sous forme de pop up en utilisant la classe UIAlertController.

**Objectifs et Techniques utilisés :**

- Coder une application multi-pages avec Swift :
navigation controller, Tab Bar Controller pour les onglets, Tap Gesture Recognizer pour cliquer n'importe où en dehors du champ de texte pour faire disparaître le clavier notamment avec des extensions, UIAlertController pour gérer les pop up d'alerte 


- Faire des tests unitaires :
Ajout des doubles pour tester nos appels reseaux pour eviter les requetes trop longues pour les tests URLSessionFake, ajout des fausses reponses json et de la classe URLSessionDataTaskFake, 


- Effectuer des appels réseaux standards avec Swift :
Adaptation de la methode d'exctraction des données sur une API avec URLSession URLSessionConfiguration URLSessionTask URLSessionDataTask, accéssion aux ressources dans les API avec des URI, format json, verbes http get post, stockage de l'apikey dans un fichier caché et requete requise dans le header, gestion des status de la reponse ( 200 succes, 400 erreur client etc ), comprehension d'une documentation d'une API


**Bonus :**

Auto detection de la langue grace au mot clé detect

https://cloud.google.com/translate/docs/basic/detecting-language?hl=fr


**API Utilisés :**

...
https://openweathermap.org/
https://cloud.google.com/translate/
https://apilayer.com/marketplace/fixer-api
