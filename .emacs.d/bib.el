; Fonctions globales : ensemble?, égaux?, union, intersection, complément, cardinal, 
; Fonctions élémentaires : vide, vide?, appartient?, (adjoindre élt ens), (pigé ensemble) qui pige un
; élément au hasard, (ens- ensemble) qui donne un ensemble réduit d'un élément aléatoire.
; Col = Collections. Synonyme: multi-ensemble. Un même élt peut exister k fois.
;        Mêmes fonctions-titres qu'un ensemble. Et, p.ex., (fréquence élt ens).

;; "generatrices"
;; (define cur2 (lambda (f) (lambda (a) (lambda (b) (f a b))))); (X Y -> Z) -> (X->(Y->Z)) 
;; (define cur3 (lambda (f) (lambda (a) (lambda (b) (lambda (c) (f a b c)))))); XYZ->W  ->  X->(Y->(Z->W))
;; (define o (lambda (f g) (lambda (x) (f (g x))))); (X -> Z) (Y -> X) -> (Y -> Z)
;; (define ocur (cur2 o)); (X -> Z) -> ((Y -> X) -> (Y -> Z))
;; (define decur2 (lambda(f) (lambda(a b)((f a) b)))); (X->(Y->Z)) -> (X Y -> Z)
;; (define perm3.12 (lambda (f) (lambda (a b c) (f b a c)))); (W X Y -> Z) -> (X W Y -> Z)
;; (define perm2.12 (lambda (f) (lambda (a b) (f b a)))); (X Y -> Z) -> (Y X -> Z)
;; (define perm3.23 (lambda (f) (lambda (a b c) (f a c b)))); (W X Y -> Z) -> (W Y X -> Z)
;; (define perm3.13 (lambda (f) (perm3.12 (perm3.23 (perm3.12 f))))); (W X Y -> Z) -> (Y X W -> Z)
;; (define fconst (lambda (a) (lambda (b) a))); X -> (Y->X)

;; "duplication"
;; (define dupn (lambda (x) (if (0? x) x (1+ (dup (1- x)))))); N -> N
;; (define dupl (lambda (l) (if (null? l) l (cons (car l) (dup1 (cdr l)))))); LS -> LS

;; "entiers"
;; (define 0? ((cur2 eq?) 0)); R -> B
;; (defun 1? ((cur2 eq?) 1)); R -> B
;; (define > (perm2.12 <)); R R -> B
;; (define >0? ((cur2 <) 0)); R -> B
;; (define 1/x ((cur2 /) 1)); R-0 -> R-0

(defun sqr (x) (* x x)); R R -> R
(defun cube (x) (* x x x)); R R R -> R

;; "booleens"
;; (defun new-true (a b) a); B
;; (defun new-false (a b) b); B
;; (defun new-or (a b) (a a b)); B B -> B
;; (defun new-and (a b) (a b a)); B B -> B
;; (defun new-not (a) (a false true)); B -> B
;; (defun new-if (a b c) (a b c)); B X Y -> X+Y
;; (defun new-xor (a b) (and (not (and a b)) (or a b))); B B -> B
;; (defun new-equal? (a b) (or (and a b) (not (or a b)))); B B -> B

;; "taille (JH)"
;; (define taille (lambda(x);T -> N
;;                  (cond ((equal? x '()) 0)
;;                        ((equal? x 'define) -3); -1.2 après tp3?
;;                        ((atome? x) 1)
;;                        ((abstraction? x) (+ -1 (taille (cddr x))))
;;                        ((unlet? x) (+ -1
;;                                       (taille (map cadr (cadr x))) 
;;                                       (taille (cddr x))))
;;                        (else (+ (taille(car x)) (taille(cdr x))))))) 

;; (define abstraction? (lambda(x) (and (list? x) (< 2 (lgr x)) (equal? 'lambda (car x)))))
;; (define unlet? (lambda (x); T -> B 
;;                  (and (pair? x)
;;                       (let ((m (car x)))
;;                         (or (equal? m 'let) (equal? m 'let*) (equal? m 'letrec))))))

;; "Utilitaires d'écriture"
;; (define debug '#t)
;; (define affiche (lambda (x) (write x) (newline) x)); X -> X
;; (define voir (lambda (x) (if debug (affiche x) x))); X -> X

;; "Listes"
;; (define list? (lambda (a) (if (atome? a) (null? a) (list? (cdr a))))); X -> B, t=8.4
;; (define tousEgaux (lambda (l) (eq? (lgr l) (lgr (filtre ((cur2 eq?) (car l)) l))))); L(S) -> B, t=10.4
;; (define noms-distincts? (lambda (l); L(S) -> B, t=17.4
;;                           (if (null? l) #t (and (1? (lgr (filtre ((cur2 eq?) (car l)) l)))
;;                                                 (noms-distincts? (cdr l))))))

;; "Listes (traitement par flot)"
;; ((map mapcar) (enum ??) (accum reduce) (filtre ??))

;; "Classe dictionnaire"  ; t=54.6
;; (define valeur (lambda (c d); S Dic -> T, t=17.4
;;                  (cond ((eq? (caar d) c) (cadar d))
;;                        ((null? d) (error "clef introuvable")); validation -> inutile
;;                        (else (valeur (c (cdr d)))))))
;; (define clefs (lambda (d) (if (null? d) '() (cons (caar d) (clefs (cdr d)))))); Dic -> LS, t=10.4
;; (define valeurs (lambda (d) (if (null? d) '() (cons (cadar d) (valeurs (cdr d)))))); Dic -> LS, t=10.4
;; (define dictionnaire (lambda (c v); Ln(S) Ln -> Ln(Ass), t=16.4
;;                        (if (null? c) '() 
;;                            (cons (list (car c) (car v)) (dictionnaire (cdr c) (cdr v))))))

(setq types '((T "Toutes données lisp")
              (nil "Vide")
              (Bo  "Booleens = ensemble #t, #f ")
              (S "Symboles")
              (Z "Entiers")
              (N "Entiers positifs")
              (N+ "Entiers strictement positifs")
              (R "Réels")
              (P "Paires")
              (L "Listes = Lnv + Lv")
              (Lnv "Listes non vides")
              (Lv "Ensemble singleton { ( ) }")
              (E "Ensembles")
              (MD "Multi-dictionnaires")
              (Dic "Dictionnaires")
              (Assoc "Associations")
              (Arb "Arbres")
              (Arbin "Arbres binaires")
              (Tab "Tableaux")
              (Col "Collections")
              ))
(setq equivalents-schemes '((ident identity) 
                            (eq? eq) 
                            (equal? equal)
                            (atome? atom) 
                            (pair? cons) 
                            (cat append)
                            ))
