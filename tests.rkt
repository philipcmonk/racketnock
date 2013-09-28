#lang racket

(require rackunit "nock.rkt")

(test-case
 "cell"
 (check-equal?
  (cell 0 1 2 3)
  '(0 1 2 . 3))
 (check-equal?
  (cell 0 (cell 10 11) 2 3)
  '(0 (10 . 11) 2 . 3))
 (check-equal?
  (cell 0 (cell 10 11) 2 (cell 30 31 32))
  '(0 (10 . 11) 2 30 31 . 32))
 (check-equal?
  (cell 0 (cell 10 11 (cell 120 (cell 1210 1211 1212) (cell 1220 1221))) 2 (cell 30 (cell 310 311 312 313) (cell 320 321)))
  '(0 (10 11 . (120 (1210 1211 . 1212) 1220 . 1221)) 2 30 (310 311 312 . 313) 320 . 321)))

(test-case
 "wut"
 (check-equal?
  (wut (cell 0 1))
  0)
 (check-equal?
  (wut 0)
  1))

(test-case
 "lus"
 (check-equal?
  (lus (cell 0 1 2))
  (cell 0 1 2))
 (check-equal?
  (lus 5)
  6))

(test-case
 "tis"
 (check-equal?
  (tis (cell (cell 0 1 2) (cell 0 1 2)))
  0)
 (check-equal?
  (tis (cell 5 5))
  0)
 (check-equal?
  (tis (cell (cell 0 1 2) (cell 0 1 2 3)))
  1)
 (check-equal?
  (tis (cell 5 6))
  1))

(test-case
 "fas"
 (check-equal?
  (fas (cell 1 (cell 4 5) 6 14 15))
  (cell (cell 4 5) 6 14 15))
 (check-equal?
  (fas (cell 2 (cell 4 5) 6 14 15))
  (cell 4 5))
 (check-equal?
  (fas (cell 3 (cell 4 5) 6 14 15))
  (cell 6 14 15))
 (check-equal?
  (fas (cell 4 (cell 4 5) 6 14 15))
  4)
 (check-equal?
  (fas (cell 5 (cell 4 5) 6 14 15))
  5)
 (check-equal?
  (fas (cell 6 (cell 4 5) 6 14 15))
  6)
 (check-equal?
  (fas (cell 7 (cell 4 5) 6 14 15))
  (cell 14 15))
 (check-equal?
  (fas (cell 14 (cell 4 5) 6 14 15))
  14)
 (check-equal?
  (fas (cell 15 (cell 4 5) 6 14 15))
  15))

(test-case
 "tar"
 (check-equal?
  (tar (cell (cell (cell 4 5) (cell 6 14 15)) (cell 0 7)))
  (cell 14 15))
 (check-equal?
  (tar (cell 42 (cell (cell 4 0 1) (cell 3 0 1))))
  (cell 43 1))
 (check-equal?
  (tar (cell 42 1 153 218))
  (cell 153 218))
 (check-equal?
  (tar (cell 77 (cell 2 (cell 1 42) (cell 1 1 153 218))))
  (cell 153 218))
 (check-equal?
  (tar (cell (cell 132 19) (cell 4 0 3)))
  20)
 (check-equal?
  (tar (cell (cell 132 19) (cell 10 37 (cell 4 0 3))))
  20)
 (check-equal?
  (tar (cell 42 7 (cell 4 0 1) (cell 4 0 1)))
  44)
 (check-equal?
  (tar (cell 42 8 (cell 4 0 1) (cell 4 0 3)))
  43)
 (check-equal?
  (tar (cell 42 6 (cell 1 0) (cell 4 0 1) (cell 1 233)))
  43)
 (check-equal?
  (tar (cell 42 6 (cell 1 1) (cell 4 0 1) (cell 1 233)))
  233))

(test-case
 "nock-eval"
 (check-equal?
  (nock-eval [42 [8 [1 0] 8 [1 6 [5 [0 7] 4 0 6] [0 6] 9 2 [0 2] [4 0 6] 0 7] 9 2 0 1]])
  41))

