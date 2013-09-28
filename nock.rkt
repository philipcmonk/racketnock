#lang racket

(provide (all-defined-out))

(define cell? cons?)
(define atom? (negate cell?))

(define (nock a)
 (tar a))

(define cell
 (lambda l
  (if (null? (cdr l))
   (car l)
   (cons (car l) (apply cell (cdr l))))))

(define (wut a) (if (atom? a) 1 0))

(define (lus a) (if (atom? a) (add1 a) a))

(define (tis a) (if (equal? (car a) (cdr a)) 0 1))

(define (fas noun)
 (let ((n (car noun))
       (l (cdr noun)))
  (cond
   ((= 1 n) l)
   ((= 2 n) (car l))
   ((= 3 n) (cdr l))
   ((even? n) (fas (cell 2 (fas (cell (/ n 2) l)))))
   ((odd? n) (fas (cell 3 (fas (cell (floor (/ n 2)) l))))))))

(define (tar noun)
 (if (or (atom? noun) (atom? (cdr noun)))
  noun
  (let ((a (car noun))
        (n (cadr noun))
        (l (cddr noun)))
   (cond
    ((cell? n) (cell (tar (cell a (car n) (cdr n))) (tar (cell a l))))
    ((= 0  n) (fas (cell l a)))
    ((= 1  n) l)
    ((= 2  n) (tar (cell (tar (cell a (car l))) (tar (cell a (cdr l))))))
    ((= 3  n) (wut (tar (cell a l))))
    ((= 4  n) (lus (tar (cell a l))))
    ((= 5  n) (tis (tar (cell a l))))
    ((= 6  n) (tar (cell a 2 (cell 0 1) 2 (cell 1 (cadr l) (cddr l)) (cell 1 0) 2 (cell 1 2 3) (cell 1 0) 4 4 (car l))))
    ((= 7  n) (tar (cell a 2 (car l) 1 (cdr l))))
    ((= 8  n) (tar (cell a 7 (cell (cell 7 (cell 0 1) (car l)) 0 1) (cdr l))))
    ((= 9  n) (tar (cell a 7 (cdr l) (cell 2 (cell 0 1) (cell 0 (car l))))))
    ((= 10 n) (if (cell? (car l))
               (tar (cell a 8 (cdar l) 7 (cell 0 3) (cdr l)))
               (tar (cell a (cdr l)))))
    (#t noun)))))

(define-syntax (nock-eval syntax)
 (let* ((data (cdr (syntax->datum syntax)))
	(celldata (let loop ((d data))
		   (if (and (list? d) (not (null? d)))
		    (if (null? (cdr d)) `(cell ,(loop (car d))) `(cell ,(loop (car d)) ,(loop (cdr d))))
		    d))))
  (datum->syntax syntax `(tar ,celldata))))

(define (noun->string c)
 (let loop ((c c))
  (if (cell? c)
   (string-join
    (map noun->string (improper-list->list c))
    " "
    #:before-first "["
    #:after-last "]")
   (format "~a" c))))

(define (improper-list->list l)
 (if (cons? l)
  (cons (car l) (improper-list->list (cdr l)))
  (cons l '())))

