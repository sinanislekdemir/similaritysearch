# similaritysearch


Similarity Search Script
------------------------

This piece of messy code, creates a database for itself and analyses your text, gives it scores and by this way, detects your texts language and topic.

Bu kirli kod, once kendi "data" klasorunu kullanarak bir database olusturur, ardindan verdiginiz dosyayi inceleyerek, dilini ve konusunu ayirt eder. Benzerlikleri getirir.

No extra requirements.

For the samples, "debug" mode is optional, lists all scores of all databases

    ruby idea.rb samples/speed_of_light_de.txt debug


    ruby idea.rb samples/cpp_fr.txt debug


Flow;
![alt tag](https://raw.github.com/sinanislekdemir/similaritysearch/master/flow.jpg)

Sample output;
![alt tag](https://raw.github.com/sinanislekdemir/similaritysearch/master/sc.png)
