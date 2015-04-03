# similaritysearch


Similarity Search Script
------------------------

This piece of messy code, creates a database for itself and analyses your text, gives it scores and by this way, detects your texts language and topic.

Bu kirli kod, once kendi "data" klasorunu kullanarak bir database olusturur, ardindan verdiginiz dosyayi inceleyerek, dilini ve konusunu ayirt eder. Benzerlikleri getirir.

No extra requirements.

    ruby idea.rb samples/speed_of_light_de.txt
    
Sample output;

(ss) ~/workspace/ruby_projects/ss> ruby idea.rb samples/speed_of_light_de.txt
    Generating language databases
    Generating topic databases
    Learning languages...
    Learning de
    Learning en
    Learning fr
    Learning tr
    Learning topics...
    Learning computer
    Learning food
    Learning history
    Learning literature
    Learning medical
    Learning science
    {
      "language": [
        {
          "lang": "de",
          "score": 0.8808983545329512
        },
        {
          "lang": "en",
          "score": 0.6803693308752947
        },
        {
          "lang": "fr",
          "score": 0.6662551186323952
        },
        {
          "lang": "tr",
          "score": 0.5713271868109921
        }
      ],
      "topic": [
        {
          "topic": "science_de",
          "score": 0.37735782920534316
        },
        {
          "topic": "medical_de",
          "score": 0.3380947304106884
        },
        {
          "topic": "computer_de",
          "score": 0.327963904797962
        },
        {
          "topic": "literature_de",
          "score": 0.312287265491122
        },
        {
          "topic": "food_de",
          "score": 0.306442669043541
        },
        {
          "topic": "history_de",
          "score": 0.27955346733553815
        },
        {
          "topic": "science_tr",
          "score": 0.030420937358335884
        },
        {
          "topic": "computer_tr",
          "score": 0.017716427553713103
        },
        {
          "topic": "history_tr",
          "score": 0.014014429547183273
        },
        {
          "topic": "literature_tr",
          "score": 0.013594089484973516
        },
        {
          "topic": "medical_tr",
          "score": 0.008372732196289099
        },
        {
          "topic": "food_tr",
          "score": -0.007607982629437907
        },
        {
          "topic": "computer_fr",
          "score": -0.11218821599878298
        },
        {
          "topic": "medical_fr",
          "score": -0.11261212632104488
        },
        {
          "topic": "literature_fr",
          "score": -0.11341047735384649
        },
        {
          "topic": "food_en",
          "score": -0.12013040101082428
        },
        {
          "topic": "history_fr",
          "score": -0.12071199209931126
        },
        {
          "topic": "medical_en",
          "score": -0.12085497006391994
        },
        {
          "topic": "food_fr",
          "score": -0.12918377174768397
        },
        {
          "topic": "computer_en",
          "score": -0.13715741012196966
        },
        {
          "topic": "literature_en",
          "score": -0.1410831066147705
        },
        {
          "topic": "science_fr",
          "score": -0.14630152354813317
        },
        {
          "topic": "history_en",
          "score": -0.14941613868557962
        },
        {
          "topic": "science_en",
          "score": -0.1532068751621159
        }
      ]
    }
