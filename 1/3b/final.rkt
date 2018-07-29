;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname final) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Growing flower

;; =================
;; Constants:

(define HEIGHT 400)
(define WIDTH 1000)

(define MTS (empty-scene WIDTH HEIGHT))

(define GROWTH-RATE 1)

(define MAX-SIZE 100)



;; =================
;; Data definitions:

(define-struct flower (x y size))
;; Flower is (make-flower Natural[0, WIDTH] Natural[0, HEIGHT] Natural[0, MAX-SIZE])
;; interp. (make-flower Natural Natural Natural) is a flower at position x, y and size big

(define F1 (make-flower 50 100 20))
(define F2 (make-flower 90 200 MAX-SIZE))

(define (fn-for-flower f)
  (... (flower-x f)     ;Natural[0, WIDTH]
       (flower-y f)     ;Natural[0, HEIGHT] 
       (flower-size f)));Natural[0, MAX-SIZE]

;; Template rules used:
;; - compound: 3 fields

;; FlowerState is one of:
;; - false
;; - Flower
;; interp. A flower's state on the screen. either false if it hasn't been planted yet or Flower once planted

(define FS1 false) ;not planted
(define FS2 (make-flower 40 100 10)) ;planted

(define (fn-for-flower-state fs)
  (cond [(false? fs) (...)]
        [else (... (flower-x fs) (flower-y fs) (flower-size fs))]))

;; Template rules used:
;; one-of: 2 cases
;; atomic distinct: false
;; Flower



;; =================
;; Functions:

;; FlowerState -> FlowerState
;; start the world with (main (make-flower 0 0 0))
;; 
(define (main fs)
  (big-bang fs                        ; FlowerState
            (on-tick   next-flower)   ; FlowerState -> FlowerState
            (to-draw   render-flower) ; FlowerState -> Image
            (on-mouse  handle-click))); FlowerState Integer Integer MouseEvent -> FlowerState

;; FlowerState -> FlowerState
;; produce the next flower. Either grow the flower if already planted (the mouse was clicked) or produce false 

(check-expect (next-flower false) false) ; flower not started yet
(check-expect (next-flower (make-flower 30 50 0))  (make-flower 30 50 GROWTH-RATE)) ;flower just started
(check-expect (next-flower (make-flower 100 80 10))  (make-flower 100 80 (+ 10 GROWTH-RATE))) ;flower still growing
(check-expect (next-flower (make-flower 150 60 MAX-SIZE))  (make-flower 150 60 MAX-SIZE)) ;flower at max size. not groeing anymore

;(define (next-flower fs) false) ;stub

;<use template from FlowerState>

(define (next-flower fs)
  (cond [(false? fs)
         false]
        [(> (+ (flower-size fs) GROWTH-RATE) MAX-SIZE)
         (make-flower (flower-x fs) (flower-y fs) MAX-SIZE)]
        [else
         (make-flower (flower-x fs) (flower-y fs) (+ (flower-size fs) GROWTH-RATE))]))


;; FlowerState -> Image
;; render the flower using its size

(check-expect (render-flower (make-flower 250 100 10)) (place-image/align (above (rectangle 4 6 "solid" "red")(rectangle 2 10 "solid" "green")) 250 100 "center" "bottom" MTS))
(check-expect (render-flower (make-flower 30 70 MAX-SIZE)) (place-image/align (above (rectangle 4 6 "solid" "red")(rectangle 2 MAX-SIZE "solid" "green")) 30 70   "center" "bottom"MTS))

;(define (render-flower fs) MTS) ;stub

;<use template from FlowerState>

(define (render-flower fs)
  (cond [(false? fs) MTS]
        [else
         (place-image/align (above (rectangle 4 6 "solid" "red")
                                   (rectangle 2  (flower-size fs) "solid" "green")) (flower-x fs) (flower-y fs) "center" "bottom" MTS)]))


;; FlowerState Integer Integer MouseEvent -> FlowerState
;; start the flower growth after the mouse was clicked

(check-expect (handle-click false 10 20 "button-up") (make-flower 10 20 0))
(check-expect (handle-click (make-flower 40 50 10) 50 80 "button-up") (make-flower 50 80 0))

;(define (handle-click fs x y me) false) ;stub

;<Use template from MouseEvent>

(define (handle-click fs x y me)
  (cond [(mouse=? me "button-up") (make-flower x y 0)]
        [else
         fs]))

