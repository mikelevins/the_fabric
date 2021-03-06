;;;; ***********************************************************************
;;;;
;;;; Name:          state-create-character.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       the create-character AppState
;;;; Author:        mikel evins
;;;; Copyright:     2015 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export
 %create-character-state-cleanup
 %create-character-state-initialize
 %create-character-state-initialized?
 %create-character-state-attached
 %create-character-state-detached
 %create-character-state-handle-analog-event
 %create-character-state-handle-action-event
 %create-character-state-enabled?
 set-character-armor!
 set-character-augment!
 set-character-weapon!)

;;; ---------------------------------------------------------------------
;;; required modules
;;; ---------------------------------------------------------------------

(require data-assets)
(require model-character)
(require model-namegen)
(require model-rect)
(require class-CreateCharacterState)
(require view-faction-nameplate)
(require view-faction-picker)
(require view-armor-model)
(require view-armor-picker)
(require view-augment-model)
(require view-augment-picker)
(require view-weapon-model)
(require view-weapon-picker)
(require view-name-generator)
(require view-character-acceptor)
(require view-character-model)
(require view-character-nameplate)
(require state)
(require client)

;;; ---------------------------------------------------------------------
;;; Java imports
;;; ---------------------------------------------------------------------

(import (class com.jme3.app.state AbstractAppState AppStateManager))
(import (class com.jme3.math Vector2f Vector3f))
(import (class com.jme3.scene Node))
(import (class com.jme3.renderer Camera))
(import (class gnu.mapping Symbol))
(import (class tonegod.gui.controls.text Label))
(import (class tonegod.gui.controls.windows Window))
(import (class tonegod.gui.core Screen))

;;; ---------------------------------------------------------------------
;;; CreateCharacterState
;;; ---------------------------------------------------------------------

(define (%create-character-state-cleanup state::CreateCharacterState)
  (let* ((client::FabricClient (the-client))
         (screen::Screen client:screen)
         (gui-node::Node (client:getGuiNode))
         (camera::Camera (client:getCamera))
         (faction-nameplate::Label state:faction-nameplate)
         (faction-picker::Window state:faction-picker)
         (armor-picker::Window state:armor-picker)
         (weapon-picker::Window state:weapon-picker)
         (augment-picker::Window state:augment-picker)
         (name-generator::Window state:name-generator)
         (character-acceptor::Window state:character-acceptor)
         (character-nameplate::Label state:character-nameplate)
         (model::Node state:character-model)
         (root-node::Node (client:getRootNode)))
    (screen:removeElement faction-nameplate)
    (screen:removeElement faction-picker)
    (screen:removeElement armor-picker)
    (screen:removeElement weapon-picker)
    (screen:removeElement augment-picker)
    (screen:removeElement name-generator)
    (screen:removeElement character-acceptor)
    (screen:removeElement character-nameplate)
    (gui-node:removeControl screen)
    (camera:setLocation (Vector3f 0.0 0.0 0.0))
    (camera:lookAtDirection (Vector3f 0.0 0.0 1.0) (Vector3f 0.0 1.0 0.0))
    (root-node:detachChild model))
  #!void)

(define (%create-character-state-initialize state::CreateCharacterState)
  (let* ((client::FabricClient (the-client))
         (gui-node::Node (client:getGuiNode))
         (screen::Screen client:screen)
         (camera::Camera (client:getCamera))
         (faction-nameplate::Label (make-faction-nameplate screen))
         (faction-picker (make-faction-picker state screen))
         (armor-picker (make-armor-picker state screen))
         (weapon-picker (make-weapon-picker state screen))
         (augment-picker (make-augment-picker state screen))
         (name-generator (make-name-generator state screen))
         (character-acceptor (make-character-acceptor state screen))
         (char::FabricCharacter (make-fabric-character (blank-fabric-name)))
         (picker-rect (compute-faction-picker-rect screen))
         (nameplate-pos (Vector2f (+ 16 (get-left picker-rect)(get-width picker-rect))
                                  (+ -56 (get-top picker-rect)(get-height picker-rect))))
         (character-nameplate::Label (make-character-nameplate screen nameplate-pos))
         (model::Node (blank-character-model))
         (root-node::Node (client:getRootNode)))
    (set! state:faction-nameplate faction-nameplate)
    (set! state:faction-picker faction-picker)
    (set! state:armor-picker armor-picker)
    (set! state:weapon-picker weapon-picker)
    (set! state:augment-picker augment-picker)
    (set! state:name-generator name-generator)
    (set! state:character-acceptor character-acceptor)
    (set! state:character-under-construction char)
    (set! state:character-nameplate character-nameplate)
    (set! state:character-model model)
    (screen:addElement faction-nameplate)
    (screen:addElement faction-picker)
    (screen:addElement armor-picker)
    (screen:addElement weapon-picker)
    (screen:addElement augment-picker)
    (screen:addElement name-generator)
    (screen:addElement character-acceptor)
    (screen:addElement character-nameplate)
    (gui-node:addControl screen)
    (camera:setLocation (Vector3f 0.0 0.0 20.0))
    (camera:lookAtDirection (Vector3f 0.0 0.0 -1.0) (Vector3f 0.0 1.0 0.0))
    (root-node:attachChild model)
    (set! state:state-initialized? #t))
  #!void)

(define (%create-character-state-enabled? state::FabricClientState) #t)
(define (%create-character-state-initialized? state::FabricClientState) state:state-initialized?)
(define (%create-character-state-attached state::FabricClientState manager::AppStateManager) #!void)
(define (%create-character-state-detached state::FabricClientState manager::AppStateManager) #!void)

(define (%create-character-state-handle-analog-event state name value tpf)
  ;;; TODO: implement event handling
  #!void)

(define (%create-character-state-handle-action-event state name key-pressed? tpf)
  ;;; TODO: implement event handling
  #!void)


(define (set-character-armor! state::CreateCharacterState armor-name::Symbol)
  (let ((previous-model state:armor-model)
        (new-model::Node (make-armor-model armor-name))
        (character-model::Node state:character-model)
        (character::FabricCharacter (current-character)))
    (set! state:character-armor armor-name)
    (set! character:armor armor-name)
    (set! state:armor-model new-model)
    (unless (eqv? #!null previous-model)
      (character-model:detachChild previous-model))
    (character-model:attachChild new-model)))

(define (set-character-augment! state::CreateCharacterState augment-name::Symbol)
  (let ((previous-model state:augment-model)
        (new-model::Node (make-augment-model augment-name))
        (character-model::Node state:character-model)
        (character::FabricCharacter (current-character)))
    (set! state:character-augment augment-name)
    (set! character:augment augment-name)
    (set! state:augment-model new-model)
    (unless (eqv? #!null previous-model)
      (character-model:detachChild previous-model))
    (character-model:attachChild new-model)))

(define (set-character-weapon! state::CreateCharacterState weapon-name::Symbol)
  (let ((previous-model state:weapon-model)
        (new-model::Node (make-weapon-model weapon-name))
        (character-model::Node state:character-model)
        (character::FabricCharacter (current-character)))
    (set! state:character-weapon weapon-name)
    (set! character:weapon weapon-name)
    (set! state:weapon-model new-model)
    (unless (eqv? #!null previous-model)
      (character-model:detachChild previous-model))
    (character-model:attachChild new-model)))
