;;;; ***********************************************************************
;;;; FILE IDENTIFICATION
;;;;
;;;; Name:          controls.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       JME3 Control objects
;;;; Author:        mikel evins
;;;; Copyright:     2014 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export RotateControl any-rotator FlickerControl)

(require "util-java.scm")
(require "util-lists.scm")
(require "util-general.scm")
(require "util-random.scm")

(define-private-alias AbstractControl com.jme3.scene.control.AbstractControl)
(define-private-alias ColorRGBA com.jme3.math.ColorRGBA)
(define-private-alias Geometry com.jme3.scene.Geometry)
(define-private-alias Material com.jme3.material.Material)

;;; ---------------------------------------------------------------------
;;; a rotation control
;;; ---------------------------------------------------------------------

(define-simple-class RotateControl (AbstractControl)
  (xrate::float init-value: 0.0)
  (yrate::float init-value: 0.0)
  (zrate::float init-value: 0.0)
  ((*init* xr yr zr)(begin
                      (set! xrate xr)
                      (set! yrate yr)
                      (set! zrate zr)))
  ((controlUpdate tpf)
   (when (*:getSpatial (this))
     (*:rotate (*:getSpatial (this))
                (* tpf xrate)
                (* tpf yrate)
                (* tpf zrate))))
  ;; dummy update method to make Java happy
  ((controlRender renderManager viewPort) #!void))


(define (any-rotator)
  (RotateControl (choose-any '(-1.5 -1.25 -1.0 -0.75 -0.5 -0.25 0.25 0.5 0.75 1.0 1.25 1.5))
                    (choose-any '(-1.5 -1.25 -1.0 -0.75 -0.5 -0.25 0.25 0.5 0.75 1.0 1.25 1.5))
                    (choose-any '(-1.5 -1.25 -1.0 -0.75 -0.5 -0.25 0.25 0.5 0.75 1.0 1.25 1.5))))

;;; ---------------------------------------------------------------------
;;; a flicker control
;;; ---------------------------------------------------------------------

(define-simple-class FlickerControl (AbstractControl)
  (dim-color::ColorRGBA init-value: #!null)
  (bright-color::ColorRGBA init-value: #!null)
  (activity::int init-value: 96)
  ((*init* dim bright act)(begin
                            (set! dim-color dim)
                            (set! bright-color bright)
                            (set! activity act)))
  ((controlUpdate tpf)
   (let ((geom::Geometry (*:getSpatial (this))))
     (when geom
     (let ((mat::Material (*:getMaterial geom))
           (die (random-integer activity)))
       (if (< die 4)
           (*:setColor mat "GlowColor" bright-color)
           (*:setColor mat "GlowColor" dim-color))))))
  ;; dummy update method to make Java happy
  ((controlRender renderManager viewPort) #!void))