Simple check
 ./check.sh www.seznam cz
 >>> www.seznam http://www.seznam.cz [302] -> https://www.seznam.cz/ [https://www.seznam.cz 200]

Check multiple with parallel
 cat example_cz | parallel -j32 --no-run-if-empty ./check.sh {} cz
 seznam http://seznam.cz [302] -> https://www.seznam.cz/ [https://seznam.cz 302]
 google http://google.cz [301] -> http://www.google.cz/ [https://google.cz 301]
 www.google http://www.google.cz [200] ->  [https://www.google.cz 200]
 www.seznam http://www.seznam.cz [302] -> https://www.seznam.cz/ [https://www.seznam.cz 200]

