;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname quiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define IMAGE1 (rectangle 32 12 "solid" "orange"))
(define IMAGE2 (rectangle 15 10 "solid" "blue"))
(define IMAGE3 (rectangle 46 23 "solid" "red"))
(define IMAGE4 (rectangle 32 12 "solid" "purple"))
(define IMAGE5 (rectangle 12 32 "solid" "grey"))
(define IMAGE6 (rectangle 12.4 23.6 "solid" "green"))


;; Image -> Natural
;; return the area of the given image

(check-expect (image-area IMAGE1) (* 32 12))
(check-expect (image-area IMAGE2) (* (image-width IMAGE2) (image-height IMAGE2)))
(check-expect (image-area IMAGE6) (* 12 24))

;(define (image-area image) 0)    ;stub

;(define (image-area image)       ;template
;  (... image))

(define (image-area image)
   (* (image-width image) (image-height image)))


;; Image Image -> Boolean
;; return true if image1 is larger than image2. An image is larger if its area (hight * width) is greater

(check-expect (image-larger? IMAGE1 IMAGE2) true)
(check-expect (image-larger? IMAGE1 IMAGE3) false)
(check-expect (image-larger? IMAGE1 IMAGE4) false)
(check-expect (image-larger? IMAGE1 IMAGE5) false)

;(define (image-larger? image1 image2) false)    ;stub

;(define (image-larger? image1 image2)           ;template
;  (... image1 ... image2))

(define (image-larger? image1 image2)
  (> (image-area image1) (image-area image2)))