;;;; ***********************************************************************
;;;;
;;;; Name:          view-faction-picker.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       a UI element for picking the faction of a newly-created character
;;;; Author:        mikel evins
;;;; Copyright:     2015 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export
 FactionButtonGroup)

(require "util-java.scm")
(require "client-state.scm")
(require "state-create-character.scm")

(import-as Button tonegod.gui.controls.buttons.Button)
(import-as RadioButtonGroup tonegod.gui.controls.buttons.RadioButtonGroup)
(import-as Screen tonegod.gui.core.Screen)

(define-simple-class FactionButtonGroup (RadioButtonGroup)
  (app-state init-form: #!null)
  ((getAppState) app-state)
  ((setAppState new-state)(set! app-state new-state))
  ((*init* screen::Screen uid::String)
   (invoke-special RadioButtonGroup (this) '*init* screen uid))
  ((onSelect index::int value::Button)
   (let ((button-id (*:getUID value))
         (state::CreateCharacterState (*:getAppState (this))))
     (cond
      ((equal? "CaretakerButton" button-id)(*:setFaction state 'caretakers))
      ((equal? "RoguesButton" button-id)(*:setFaction state 'rogues))
      ((equal? "AbjurersButton" button-id)(*:setFaction state 'abjurers))
      (else (format #t "~%Unknown faction selected"))))))