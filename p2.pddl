(define (problem Ana-are)
    (:domain easyEx)
    (:objects   
                George - Human
                He - pronoun
                She - pronoun 
                clock - noun
                enjoy - verb
                eat - verb 
                like - verb
                apple - noun
                see - verb
                s - termination
                es - termination
                this - definiteArticle
                the - definiteArticle
                a - indefiniteArticle
                an - indefiniteArticle
                carefully - adjective
                watch - verb
                highschool - noun
                chair - noun
                dog - living
    )
    (:init  (needsTermination Ana)
            (needsTermination George)
            (needsTermination He)
            (needsTermination She)
            (needsTermination apple)
            (needsTermination clock)
            (needsTermination highschool)
            (needsTermination dog)
            (s s)
            (es es)
            (a a)
            (an an)
            (isHuman George)
            (usedByLiving enjoy)
            (usedByLiving eat)
            (usedByLiving see)
            (usedByLiving watch)
            (isHuman Ana)
            (isHuman He)
            (isHuman She)
            (isLocation highschool)
            (isFood apple)
            (startsWithVowel apple)
            (terminationS like)
            (terminationS eat)
            (terminationS see)
            (needsFood eat)
            (needsLocation enjoy)
            (needsNoun like)
            (needsNoun see)
            (needsAdjective watch)
            (terminationEs enjoy)
            (terminationEs watch)
    )
    (:goal (and (isDone eat) (isDone watch) (isDone enjoy) (isDone see) (isDone like)))
)