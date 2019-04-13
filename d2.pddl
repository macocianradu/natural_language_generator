(define (domain easyEx)

	(:requirements :typing :adl)

    (:types adjective - adjective
            noun
            living - noun
            human animal - living
            location - noun
            pronoun - human
            article
            definiteArticle - article
            indefiniteArticle - article
            Verb - verb
            termination - termination
    )

    (:predicates
        (subject ?x)
        (hasSubject ?x)
        (predicate ?x)
        (terminationS ?x)
        (terminationEs ?x)
        (isPredicate ?x)
        (isHuman ?x)
        (isDone ?x)
        (usedByHuman ?x)
        (usedByLiving ?x)
        (usedByNoun ?x)
        (needsTermination ?x)
        (hasTermination ?x)
        (isTermination ?x)
        (used ?x)
        (s ?x)
        (es ?x)
        (a ?x)
        (an ?x)
        (needsHuman ?x)
        (needsLocation ?x)
        (isFood ?x)
        (isLocation ?x)
        (needsFood ?x)
        (needsLiving ?x)
        (needsNoun ?x)
        (needsAdjective ?x)
        (startsWithVowel ?x)
        (plural ?x)
        (hasArticle ?x)
    )

    (:action addPred
        :parameters 
                        (?verb - Verb)
        :precondition 
                        (not (isPredicate ?verb))
        :effect 
                        (and (isPredicate ?verb)
                             (used ?verb))
    )


    (:action addSubjHuman                                                  ;Add subject can be human
        :parameters 
                        (?subject - human
                         ?predicate - verb)
        :precondition 
                        (and (isPredicate ?predicate)
                             (or (usedByLiving ?predicate)
                                 (usedByNoun ?predicate)
                                 (usedByHuman ?predicate)) 
                             (not (subject ?subject))
                             (not (used ?subject)) 
                             (not (hasSubject ?predicate)))
        :effect 
                        (and (subject ?subject) 
                             (hasSubject ?predicate)
                             (used ?subject))
    )

    (:action addSubjLivingIndefinite                                                  ;Add subject can be living with indefinite article
        :parameters 
                        (?article - indefiniteArticle
                         ?subject - living
                         ?predicate - Verb)
        :precondition 
                        (and (or (and (startsWithVowel ?subject)
                                      (an ?article))
                                 (and (not (startsWithVowel ?subject))
                                      (a ?article)))
                             (isPredicate ?predicate)
                             (usedByLiving ?predicate)
                             (not (isHuman ?subject))
                             (not (plural ?subject)) 
                             (not (subject ?subject))
                             (not (used ?subject)) 
                             (not (hasSubject ?predicate)))
        :effect 
                        (and (subject ?subject) 
                             (hasSubject ?predicate)
                             (used ?subject)
                             (used ?article)
                             (hasArticle ?subject))
    )

    (:action addSubjLivingDefinite                                                  ;Add subject can be living with indefinite article
        :parameters 
                        (?article - definiteArticle
                         ?subject - living
                         ?predicate - Verb)
        :precondition 
                        (and (isPredicate ?predicate) 
                             (not (subject ?subject))
                             (not (isHuman ?subject))
                             (usedByLiving ?predicate)
                             (not (plural ?subject))
                             (not (used ?subject)) 
                             (not (hasSubject ?predicate)))
        :effect 
                        (and (subject ?subject) 
                             (hasSubject ?predicate)
                             (used ?subject)
                             (used ?article)
                             (hasArticle ?subject))
    )

    (:action addSubjLivingPlural                                                  ;Add subject can be living plural
        :parameters 
                        (?subject - living
                         ?predicate - Verb)
        :precondition 
                        (and (isPredicate ?predicate) 
                             (not (subject ?subject))
                             (plural ?subject)
                             (not (used ?subject)) 
                             (usedByLiving ?predicate)
                             (not (hasSubject ?predicate)))
        :effect 
                        (and (subject ?subject) 
                             (hasSubject ?predicate)
                             (used ?subject))
    )

    (:action addSubjObjectIndefinite                                                  ;Add subject can be anything with indefinite article                               
        :parameters 
                        (?article - indefiniteArticle
                         ?subject - noun
                         ?predicate - Verb)
        :precondition 
                        (and (or (and (startsWithVowel ?subject)
                                      (an ?article))
                                 (and (not (startsWithVowel ?subject))
                                      (a ?article)))
                             (isPredicate ?predicate)
                             (usedByNoun ?predicate)
                             (not (isHuman ?subject)) 
                             (not (plural ?subject))
                             (not (hasSubject ?predicate)))
        :effect 
                        (and (subject ?subject) 
                             (hasSubject ?predicate)
                             (used ?subject)
                             (used ?article)
                             (hasArticle ?subject))
    )

    (:action addSubjObjectDefinite                                                  ;Add subject can be anything with definite article                               
        :parameters 
                        (?article - definiteArticle
                         ?subject - noun
                         ?predicate - Verb)
        :precondition 
                        (and (isPredicate ?predicate) 
                             (not (plural ?subject))
                             (not (isHuman ?subject))
                             (usedByNoun ?predicate)
                             (not (used ?subject)) 
                             (not (hasSubject ?predicate)))
        :effect 
                        (and (subject ?subject) 
                             (hasSubject ?predicate)
                             (used ?subject)
                             (used ?article)
                             (hasArticle ?subject))
    )

    (:action addSubjObjectPlural                                                  ;Add subject can be anything plural                               
        :parameters 
                        (?subject - noun
                         ?predicate - Verb)
        :precondition 
                        (and (isPredicate ?predicate) 
                             (plural ?subject)
                             (not (used ?subject))
                             (usedByNoun ?predicate) 
                             (not (hasSubject ?predicate)))
        :effect 
                        (and (subject ?subject) 
                             (hasSubject ?predicate)
                             (used ?subject))
    )

    (:action addTermination
        :parameters 
                        (?subject - noun
                         ?predicate - verb
                         ?termination - termination)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject) 
                             (needsTermination ?subject)
                             (or (and (terminationS ?predicate)
                                      (s ?termination)) 
                                 (and (terminationEs ?predicate)
                                      (es ?termination))))
        :effect         
                        (and (hasTermination ?predicate)
                             (isTermination ?termination)
                             (used ?termination))
    )

    ;------------------Add Object------------------

    (:action addObjectPlural                                                                ;Add object without termination plural
        :parameters 
                        (?subject - noun
                         ?predicate - Verb
                         ?object - noun)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (plural ?object)
                             (not (needsTermination ?subject))
                             (not (hasArticle ?subject))
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (not (used ?object))
                             (or (and (needsLocation ?predicate) (isLocation ?object))
                                 (and (needsFood ?predicate) (isFood ?object))
                                 (needsNoun ?predicate)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectWithDefiniteArticle                                                  ;Add object without termination with definite article
        :parameters 
                        (?subject - noun
                         ?predicate - Verb
                         ?article - definiteArticle
                         ?object - noun)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (not (needsTermination ?subject))
                             (or (and (needsLocation ?predicate) (isLocation ?object))
                                 (and (needsFood ?predicate) (isFood ?object))
                                 (needsNoun ?predicate))
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectWithIndefiniteArticle                                                  ;Add object without termination with indefinite article
        :parameters 
                        (?subject - noun
                         ?predicate - Verb
                         ?article - indefiniteArticle
                         ?object - noun)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (or (and (needsLocation ?predicate) (isLocation ?object))
                                 (and (needsFood ?predicate) (isFood ?object))
                                 (needsNoun ?predicate))
                             (not (needsTermination ?subject))
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (or (and (startsWithVowel ?object)
                                      (an ?article))
                                 (and (not (startsWithVowel ?object))
                                      (a ?article)))
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectWithSubjArticlePlural                                 ;Add object without termination with subject article plural
        :parameters 
                        (?article - article
                         ?subject - noun
                         ?predicate - Verb
                         ?object - noun)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (plural ?object)
                             (not (needsTermination ?subject))
                             (hasArticle ?subject)
                             (used ?article)
                             (or (and (needsLocation ?predicate) (isLocation ?object))
                                 (and (needsFood ?predicate) (isFood ?object))
                                 (needsNoun ?predicate))
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectWithSubjArticleWithDefiniteArticle                        ;Add object without termination with subject article with definite article
        :parameters 
                        (?article1 - article
                         ?subject - noun
                         ?predicate - Verb
                         ?article - definiteArticle
                         ?object - noun)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (used ?article1)
                             (hasArticle ?subject)
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (not (needsTermination ?subject))
                             (or (and (needsLocation ?predicate) (isLocation ?object))
                                 (and (needsFood ?predicate) (isFood ?object))
                                 (needsNoun ?predicate))
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectWithSubjArticleWithIndefiniteArticle                       ;Add object without termination with subject article with indefinite article
        :parameters 
                        (?article1 - article
                         ?subject - noun
                         ?predicate - Verb
                         ?article - indefiniteArticle
                         ?object - noun)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (used ?article1)
                             (hasArticle ?subject)
                             (or (and (needsLocation ?predicate) (isLocation ?object))
                                 (and (needsFood ?predicate) (isFood ?object))
                                 (needsNoun ?predicate))
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (not (needsTermination ?subject))
                             (or (and (startsWithVowel ?object)
                                      (an ?article))
                                 (and (not (startsWithVowel ?object))
                                      (a ?article)))
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectTerminationPlural                                                  ;Add object with termination plural
        :parameters 
                        (?subject - noun
                         ?predicate - verb
                         ?termination - termination
                         ?object - noun)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (needsTermination ?subject)
                             (hasTermination ?predicate)
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (plural ?object)
                             (or (and (needsLocation ?predicate) (isLocation ?object))
                                 (and (needsFood ?predicate) (isFood ?object))
                                 (needsNoun ?predicate)) 
                             (isTermination ?termination) 
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    (:action addObjectTerminationWithDefiniteArticle                                  ;Add object with termination with definite article
        :parameters 
                        (?subject - noun
                         ?predicate - Verb
                         ?termination - termination
                         ?article - definiteArticle
                         ?object - noun)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (or (and (needsLocation ?predicate) (isLocation ?object))
                                 (and (needsFood ?predicate) (isFood ?object))
                                 (needsNoun ?predicate))
                             (needsTermination ?subject)
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (hasTermination ?predicate)
                             (isTermination ?termination) 
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    (:action addObjectTerminationWithIndefiniteArticle                                     ;Add object with termination with indefinite article
        :parameters 
                        (?subject - noun
                         ?predicate - Verb
                         ?termination - termination
                         ?article - indefiniteArticle
                         ?object - noun)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (or (and (needsLocation ?predicate) (isLocation ?object))
                                 (and (needsFood ?predicate) (isFood ?object))
                                 (needsNoun ?predicate))
                             (needsTermination ?subject)
                             (hasTermination ?predicate)
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (isTermination ?termination) 
                             (or (and (startsWithVowel ?object)
                                      (an ?article))
                                 (and (not (startsWithVowel ?object))
                                      (a ?article)))
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    (:action addObjectWithSubjArticlePlural                                             ;Add object with termination with subject article plural
        :parameters 
                        (?article - article
                         ?subject - noun
                         ?predicate - Verb
                         ?termination - termination
                         ?object - noun)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (plural ?object)
                             (hasArticle ?subject)
                             (used ?article)
                             (or (and (needsLocation ?predicate) (isLocation ?object))
                                 (and (needsFood ?predicate) (isFood ?object))
                                 (needsNoun ?predicate))
                             (needsTermination ?subject)
                             (hasTermination ?predicate)
                             (isTermination ?termination) 
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    (:action addObjectWithSubjArticleWithDefiniteArticle                                ;Add object with termination with subject article with definite article
        :parameters 
                        (?article1 - article
                         ?subject - noun
                         ?predicate - Verb
                         ?termination - termination
                         ?article - definiteArticle
                         ?object - noun)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (used ?article1)
                             (hasArticle ?subject)
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (needsTermination ?subject)
                             (hasTermination ?predicate)
                             (isTermination ?termination) 
                             (or (and (needsLocation ?predicate) (isLocation ?object))
                                 (and (needsFood ?predicate) (isFood ?object))
                                 (needsNoun ?predicate))
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    (:action addObjectWithSubjArticleWithIndefiniteArticle                              ;Add object with termination with subject article with indefinite article
        :parameters 
                        (?article1 - article
                         ?subject - noun
                         ?predicate - Verb
                         ?termination - termination
                         ?article - indefiniteArticle
                         ?object - noun)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (used ?article1)
                             (hasArticle ?subject)
                             (or (and (needsLocation ?predicate) (isLocation ?object))
                                 (and (needsFood ?predicate) (isFood ?object))
                                 (needsNoun ?predicate))
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (needsTermination ?subject)
                             (hasTermination ?predicate)
                             (isTermination ?termination) 
                             (or (and (startsWithVowel ?object)
                                      (an ?article))
                                 (and (not (startsWithVowel ?object))
                                      (a ?article)))
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    ;------------------Add Object Adjective------------------

    (:action addObjectAdjective                                                                ;Add object adjective without termination
        :parameters 
                        (?subject - noun
                         ?predicate - Verb
                         ?object - adjective)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (not (needsTermination ?subject))
                             (not (hasArticle ?subject))
                             (needsAdjective ?predicate)
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectAdjectiveWithSubjArticle                                ;Add object adjective without termination with subject article
        :parameters 
                        (?article - article
                         ?subject - noun
                         ?predicate - Verb
                         ?object - adjective)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (hasSubject ?predicate)
                             (hasArticle ?subject)
                             (not (needsTermination ?subject))
                             (used ?article)
                             (needsAdjective ?predicate)
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectAdjectiveTermination                                                  ;Add object adjective with termination plural
        :parameters 
                        (?subject - noun
                         ?predicate - verb
                         ?termination - termination
                         ?object - adjective)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (needsTermination ?subject)
                             (hasTermination ?predicate)
                             (needsAdjective ?predicate) 
                             (isTermination ?termination) 
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    (:action addObjectadjectiveTerminationWithSubjArticle                                         ;Add object adjective with termination with subject article
        :parameters 
                        (?article - article
                         ?subject - noun
                         ?predicate - Verb
                         ?termination - termination
                         ?object - adjective)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (hasArticle ?subject)
                             (used ?article)
                             (needsAdjective ?predicate)
                             (needsTermination ?subject)
                             (hasTermination ?predicate)
                             (isTermination ?termination) 
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    ;------------------Add Object Human------------------

    (:action addObjectHuman                                                                ;Add object human without termination
        :parameters 
                        (?subject - noun
                         ?predicate - Verb
                         ?object - human)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (not (hasArticle ?subject))
                             (not (needsTermination ?subject))
                             (needsHuman  ?predicate)
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectHumanWithSubjArticle                                ;Add object human without termination with subject article plural
        :parameters 
                        (?article - article
                         ?subject - noun
                         ?predicate - Verb
                         ?object - human)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (hasArticle ?subject)
                             (not (needsTermination ?subject))
                             (used ?article)
                             (needsHuman  ?predicate)
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectHumanTermination                                                  ;Add object human with termination plural
        :parameters 
                        (?subject - noun
                         ?predicate - verb
                         ?termination - termination
                         ?object - human)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (needsTermination ?subject)
                             (hasTermination ?predicate)
                             (needsHuman  ?predicate) 
                             (isTermination ?termination) 
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    (:action addObjectHumanTerminationWithSubjArticle                                         ;Add object human with termination with subject article
        :parameters 
                        (?article - article
                         ?subject - noun
                         ?predicate - Verb
                         ?termination - termination
                         ?object - human)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (hasArticle ?subject)
                             (used ?article)
                             (needsHuman  ?predicate)
                             (needsTermination ?subject)
                             (hasTermination ?predicate)
                             (isTermination ?termination) 
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    ;------------------Add Object Living------------------

    (:action addObjectLivingPlural                                                                ;Add object living without termination plural
        :parameters 
                        (?subject - noun
                         ?predicate - Verb
                         ?object - living)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (plural ?object)
                             (not (isHuman ?object))
                             (not (needsTermination ?subject))
                             (not (hasArticle ?subject))
                             (needsLiving ?predicate)
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectLivingWithDefiniteArticle                                                  ;Add object living without termination with definite article
        :parameters 
                        (?subject - noun
                         ?predicate - Verb
                         ?article - definiteArticle
                         ?object - living)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (not (needsTermination ?subject))
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (needsLiving ?predicate)
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectLivingWithIndefiniteArticle                                                  ;Add object living without termination with indefinite article
        :parameters 
                        (?subject - noun
                         ?predicate - Verb
                         ?article - indefiniteArticle
                         ?object - living)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (needsLiving ?predicate)
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (not (needsTermination ?subject))
                             (or (and (startsWithVowel ?object)
                                      (an ?article))
                                 (and (not (startsWithVowel ?object))
                                      (a ?article)))
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectLivingWithSubjArticlePlural                                 ;Add object living without termination with subject article plural
        :parameters 
                        (?article - article
                         ?subject - noun
                         ?predicate - Verb
                         ?object - living)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (plural ?object)
                             (hasArticle ?subject)
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (not (needsTermination ?subject))
                             (used ?article)
                             (needsLiving ?predicate)
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectLivingWithSubjArticleWithDefiniteArticle                        ;Add object living without termination with subject article with definite article
        :parameters 
                        (?article1 - article
                         ?subject - noun
                         ?predicate - Verb
                         ?article - definiteArticle
                         ?object - living)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (used ?article1)
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (not (needsTermination ?subject))
                             (hasArticle ?subject)
                             (needsLiving ?predicate)
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectLivingWithSubjArticleWithIndefiniteArticle                       ;Add object living without termination with subject article with indefinite article
        :parameters 
                        (?article1 - article
                         ?subject - noun
                         ?predicate - Verb
                         ?article - indefiniteArticle
                         ?object - living)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (used ?article1)
                             (not (needsTermination ?subject))
                             (hasArticle ?subject)
                             (needsLiving ?predicate)
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (or (and (startsWithVowel ?object)
                                      (an ?article))
                                 (and (not (startsWithVowel ?object))
                                      (a ?article)))
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (isDone ?predicate))
    )

    (:action addObjectLivingTerminationPlural                                                  ;Add object living with termination plural
        :parameters 
                        (?subject - noun
                         ?predicate - verb
                         ?termination - termination
                         ?object - living)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (needsTermination ?subject)
                             (hasTermination ?predicate)
                             (plural ?object)
                             (not (isHuman ?object))
                             (needsLiving ?predicate) 
                             (isTermination ?termination) 
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    (:action addObjectLivingTerminationWithDefiniteArticle                                  ;Add object living with termination with definite article
        :parameters 
                        (?subject - noun
                         ?predicate - Verb
                         ?termination - termination
                         ?article - definiteArticle
                         ?object - living)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (needsLiving ?predicate)
                             (needsTermination ?subject)
                             (hasTermination ?predicate)
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (isTermination ?termination) 
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    (:action addObjectLivingTerminationWithIndefiniteArticle                                     ;Add object living with termination with indefinite article
        :parameters 
                        (?subject - noun
                         ?predicate - Verb
                         ?termination - termination
                         ?article - indefiniteArticle
                         ?object - living)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (needsLiving ?predicate)
                             (needsTermination ?subject)
                             (hasTermination ?predicate)
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (isTermination ?termination) 
                             (or (and (startsWithVowel ?object)
                                      (an ?article))
                                 (and (not (startsWithVowel ?object))
                                      (a ?article)))
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    (:action addObjectLivingTerminationWithSubjArticlePlural                                             ;Add object living with termination with subject article plural
        :parameters 
                        (?article - article
                         ?subject - noun
                         ?predicate - Verb
                         ?termination - termination
                         ?object - living)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (plural ?object)
                             (hasArticle ?subject)
                             (used ?article)
                             (needsLiving ?predicate)
                             (needsTermination ?subject)
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (hasTermination ?predicate)
                             (isTermination ?termination) 
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    (:action addObjectLivingTerminationWithSubjArticleWithDefiniteArticle                                ;Add object living with termination with subject article with definite article
        :parameters 
                        (?article1 - article
                         ?subject - noun
                         ?predicate - Verb
                         ?termination - termination
                         ?article - definiteArticle
                         ?object - living)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (used ?article1)
                             (hasArticle ?subject)
                             (needsTermination ?subject)
                             (hasTermination ?predicate)
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (isTermination ?termination) 
                             (needsLiving ?predicate)
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )

    (:action addObjectLivingTerminationWithSubjArticleWithIndefiniteArticle                              ;Add object living with termination with subject article with indefinite article
        :parameters 
                        (?article1 - article
                         ?subject - noun
                         ?predicate - Verb
                         ?termination - termination
                         ?article - indefiniteArticle
                         ?object - living)
        :precondition 
                        (and (isPredicate ?predicate)
                             (subject ?subject)
                             (used ?article1)
                             (hasArticle ?subject)
                             (needsLiving ?predicate)
                             (needsTermination ?subject)
                             (not (plural ?object))
                             (not (isHuman ?object))
                             (hasTermination ?predicate)
                             (isTermination ?termination) 
                             (or (and (startsWithVowel ?object)
                                      (an ?article))
                                 (and (not (startsWithVowel ?object))
                                      (a ?article)))
                             (not (used ?object)))
        :effect
                        (and (used ?object)
                             (not (isTermination ?termintaion))
                             (isDone ?predicate))
    )
)