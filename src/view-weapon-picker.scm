;;;; ***********************************************************************
;;;;
;;;; Name:          view-weapon-picker.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       the weapon picker 
;;;; Author:        mikel evins
;;;; Copyright:     2014 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export
 compute-weapon-picker-rect
 make-weapon-picker)

;;; ---------------------------------------------------------------------
;;; required modules
;;; ---------------------------------------------------------------------

(require client)
(require state)
(require class-CreateCharacterState)
(require state-create-character)
(require model-rect)
(require view-faction-picker)
(require view-weapon-button-group)

;;; ---------------------------------------------------------------------
;;; Java imports
;;; ---------------------------------------------------------------------

(import (class com.jme3.font BitmapFont))
(import (class com.jme3.math ColorRGBA Vector2f))
(import (class tonegod.gui.controls.buttons RadioButton))
(import (class tonegod.gui.controls.windows Window))
(import (class tonegod.gui.core Screen))

;;; ---------------------------------------------------------------------
;;; module variables
;;; ---------------------------------------------------------------------

(define Align BitmapFont:Align)
(define VAlign BitmapFont:VAlign)

;;; (compute-cannon-button-origin screen::Screen)
;;; ---------------------------------------------------------------------
;;; computes and returns a suitable origin for the cannon faction
;;; button

(define (compute-cannon-button-origin screen::Screen)
  (let* ((button-width 96)
         (button-height 96)
         (rect (compute-weapon-picker-rect screen))
         (palette-width (get-width rect))
         (palette-height (get-height rect))
         (x (- (/ palette-width 2.0)
               (/ button-width 2.0)))
         (y (+ 16 (- (* 1 (/ palette-height 9.0))
                     (/ button-height 2.0)))))
    (Vector2f x y)))

;;; (compute-cannon-button-size screen::Screen)
;;; ---------------------------------------------------------------------
;;; computes and returns a suitable size for the cannon faction
;;; button

(define (compute-cannon-button-size screen::Screen)
  (Vector2f 96 96))

;;; (make-cannon-button screen::Screen)
;;; ---------------------------------------------------------------------
;;; returns a newly-constructed cannon faction button

(define (make-cannon-button screen::Screen)
  (RadioButton screen "CannonButton"
               (compute-cannon-button-origin screen)
               (compute-cannon-button-size screen)
               text: "Cannon"
               fontSize: 20
               textAlign: Align:Center
               textVAlign: VAlign:Bottom))


;;; (compute-impulse-button-origin screen::Screen)
;;; ---------------------------------------------------------------------
;;; computes and returns a suitable origin for the impulse faction
;;; button

(define (compute-impulse-button-origin screen::Screen)
  (let* ((button-width 96)
         (button-height 96)
         (rect (compute-weapon-picker-rect screen))
         (palette-width (get-width rect))
         (palette-height (get-height rect))
         (x (- (/ palette-width 2.0)
               (/ button-width 2.0)))
         (y (+ 16 (- (* 3 (/ palette-height 9.0))
                     (/ button-height 2.0)))))
    (Vector2f x y)))

;;; (compute-impulse-button-size screen::Screen)
;;; ---------------------------------------------------------------------
;;; computes and returns a suitable size for the impulse faction
;;; button

(define (compute-impulse-button-size screen::Screen)
  (Vector2f 96 96))

;;; (make-impulse-button screen::Screen)
;;; ---------------------------------------------------------------------
;;; returns a newly-constructed impulse faction button

(define (make-impulse-button screen::Screen)
  (RadioButton screen "ImpulseButton"
               (compute-impulse-button-origin screen)
               (compute-impulse-button-size screen)
               text: "Impulse"
               fontSize: 20
               textAlign: Align:Center
               textVAlign: VAlign:Bottom))

;;; (compute-malware-button-origin screen::Screen)
;;; ---------------------------------------------------------------------
;;; computes and returns a suitable origin for the malware faction
;;; button

(define (compute-malware-button-origin screen::Screen)
  (let* ((button-width 96)
         (button-height 96)
         (rect (compute-weapon-picker-rect screen))
         (palette-width (get-width rect))
         (palette-height (get-height rect))
         (x (- (/ palette-width 2.0)
               (/ button-width 2.0)))
         (y (+ 16 (- (* 5 (/ palette-height 9.0))
                     (/ button-height 2.0)))))
    (Vector2f x y)))

;;; (compute-malware-button-size screen::Screen)
;;; ---------------------------------------------------------------------
;;; computes and returns a suitable size for the malware faction
;;; button

(define (compute-malware-button-size screen::Screen)
  (Vector2f 96 96))

;;; (make-malware-button screen::Screen)
;;; ---------------------------------------------------------------------
;;; returns a newly-constructed malware faction button

(define (make-malware-button screen::Screen)
  (RadioButton screen "MalwareButton"
               (compute-malware-button-origin screen)
               (compute-malware-button-size screen)
               text: "Malware"
               fontSize: 20
               textAlign: Align:Center
               textVAlign: VAlign:Bottom))

;;; (compute-bots-button-origin screen::Screen)
;;; ---------------------------------------------------------------------
;;; computes and returns a suitable origin for the bots faction
;;; button

(define (compute-bots-button-origin screen::Screen)
  (let* ((button-width 96)
         (button-height 96)
         (rect (compute-weapon-picker-rect screen))
         (palette-width (get-width rect))
         (palette-height (get-height rect))
         (x (- (/ palette-width 2.0)
               (/ button-width 2.0)))
         (y (+ 16 (- (* 7 (/ palette-height 9.0))
                     (/ button-height 2.0)))))
    (Vector2f x y)))

;;; (compute-bots-button-size screen::Screen)
;;; ---------------------------------------------------------------------
;;; computes and returns a suitable size for the bots faction
;;; button

(define (compute-bots-button-size screen::Screen)
  (Vector2f 96 96))

;;; (make-bots-button screen::Screen)
;;; ---------------------------------------------------------------------
;;; returns a newly-constructed bots faction button

(define (make-bots-button screen::Screen)
  (RadioButton screen "BotsButton"
               (compute-bots-button-origin screen)
               (compute-bots-button-size screen)
               text: "Bots"
               fontSize: 20
               textAlign: Align:Center
               textVAlign: VAlign:Bottom))

(define (compute-weapon-picker-rect screen::Screen)
  (let* ((faction-rect (compute-faction-picker-rect screen))
         (screen-width (screen:getWidth))
         (screen-height (screen:getHeight))
         (picker-width 256)
         (picker-left (- screen-width (+ picker-width 16)))
         (picker-top (+ 16 (get-top faction-rect)(get-height faction-rect)))
         (picker-height (- screen-height picker-top 16)))
    (make-rectangle picker-left picker-top picker-width picker-height)))

(define (make-weapon-picker state::FabricClientState screen::Screen)
  (let* ((state::CreateCharacterState (as CreateCharacterState state))
         (rect (compute-weapon-picker-rect screen))
         (align BitmapFont:Align)
         (valign BitmapFont:VAlign)
         (win (Window screen "WeaponPicker"
                      (Vector2f (get-left rect)(get-top rect))
                      (Vector2f (get-width rect)(get-height rect))
                      windowTitle: "Choose your weapon:"))
         (weapons-group::WeaponButtonGroup (WeaponButtonGroup screen "WeaponGroup" state: state))
         (cannon-button (make-cannon-button screen))
         (impulse-button (make-impulse-button screen))
         (malware-button (make-malware-button screen))
         (bots-button (make-bots-button screen)))
    ;; cannon button
    (cannon-button:setButtonIcon 96 96 "Interface/cannon-weapon-icon96.png")
    (cannon-button:setButtonPressedInfo "Interface/cannon-weapon-icon96.png" (ColorRGBA 0.0 1.0 0.0 1.0))
    (weapons-group:addButton cannon-button)
    (win:addChild cannon-button)
    ;; impulse button
    (impulse-button:setButtonIcon 96 96 "Interface/impulse-weapon-icon96.png")
    (impulse-button:setButtonPressedInfo "Interface/impulse-weapon-icon96.png" (ColorRGBA 0.0 1.0 0.0 1.0))
    (weapons-group:addButton impulse-button)
    (win:addChild impulse-button)
    ;; malware button
    (malware-button:setButtonIcon 96 96 "Interface/malware-weapon-icon96.png")
    (malware-button:setButtonPressedInfo "Interface/malware-weapon-icon96.png" (ColorRGBA 0.0 1.0 0.0 1.0))
    (weapons-group:addButton malware-button)
    (win:addChild malware-button)
    ;; bots button
    (bots-button:setButtonIcon 96 96 "Interface/bots-weapon-icon96.png")
    (bots-button:setButtonPressedInfo "Interface/bots-weapon-icon96.png" (ColorRGBA 0.0 1.0 0.0 1.0))
    (weapons-group:addButton bots-button)
    (win:addChild bots-button)
    win))
