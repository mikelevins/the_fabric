;;;; ***********************************************************************
;;;;
;;;; Name:          client-state-create-character.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       supporting functions for CreateCharacterClientState
;;;; Author:        mikel evins
;;;; Copyright:     2015 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export
 compute-armor-picker-rect
 compute-augment-picker-rect
 compute-faction-picker-rect
 compute-name-picker-rect
 compute-weapon-picker-rect
 did-attach-create-character-client-state
 did-detach-create-character-client-state
 prepare-to-attach-create-character-client-state)

;;; ---------------------------------------------------------------------
;;; required modules
;;; ---------------------------------------------------------------------

(require "util-java.scm")
(require "util-error.scm")
(require "util-lists.scm")
(require "syntax-classes.scm")
(require "view-loginbox.scm")
(require "model-character.scm")
(require "model-rect.scm")
(require "client-states.scm")
(require "client-main.scm")
(require "view-skybox.scm")
(require "view-character-nameplate.scm")
(require "view-faction-nameplate.scm")
(require "view-accept-character.scm")
(require "view-pickarmor.scm")
(require "view-pickaugment.scm")
(require "view-pickfaction.scm")
(require "view-pickname.scm")
(require "view-pickweapon.scm")


;;; ---------------------------------------------------------------------
;;; Java imports
;;; ---------------------------------------------------------------------

(import-as AppStateManager com.jme3.app.state.AppStateManager)
(import-as BitmapFont com.jme3.font.BitmapFont)
(import-as Label tonegod.gui.controls.text.Label)
(import-as Node com.jme3.scene.Node)
(import-as Screen tonegod.gui.core.Screen)
(import-as Spatial com.jme3.scene.Spatial)
(import-as Vector2f com.jme3.math.Vector2f)
(import-as Window tonegod.gui.controls.windows.Window)

;;; ---------------------------------------------------------------------
;;; CreateCharacterClientState functions
;;; ---------------------------------------------------------------------

;;; layout computations

(define (compute-faction-picker-rect screen::Screen)
  (make-rectangle 8 8 640 200))

(define (compute-weapon-picker-rect screen::Screen)
  (let* ((faction-picker-rect (compute-faction-picker-rect screen))
         (weapon-picker-left (get-left faction-picker-rect))
         (weapon-picker-top (+ (get-top faction-picker-rect)
                               (get-height faction-picker-rect)
                               8))
         (weapon-picker-width 256)
         (weapon-picker-height 720))
    (make-rectangle weapon-picker-left
                    weapon-picker-top
                    weapon-picker-width
                    weapon-picker-height)))


(define (compute-armor-picker-rect screen::Screen)
  (let* ((weapon-picker-rect (compute-weapon-picker-rect screen))
         (screen-width (*:getWidth screen))
         (armor-picker-width (get-width weapon-picker-rect))
         (armor-picker-height (get-height weapon-picker-rect))
         (armor-picker-left (- screen-width (+ armor-picker-width 8)))
         (armor-picker-top (get-top weapon-picker-rect)))
    (make-rectangle armor-picker-left
                    armor-picker-top
                    armor-picker-width
                    armor-picker-height)))

(define (compute-augment-picker-rect screen::Screen)
  (let* ((faction-picker-rect (compute-faction-picker-rect screen))
         (screen-width (*:getWidth screen))
         (augment-picker-width (get-width faction-picker-rect))
         (augment-picker-height (get-height faction-picker-rect))
         (augment-picker-left (- screen-width augment-picker-width 8))
         (augment-picker-top (get-top faction-picker-rect)))
    (make-rectangle augment-picker-left
                    augment-picker-top
                    augment-picker-width
                    augment-picker-height)))


(define (compute-name-picker-rect screen::Screen)
  (let* ((weapon-picker-rect (compute-weapon-picker-rect screen))
         (screen-width (*:getWidth screen))
         (screen-height (*:getHeight screen))
         (picker-width (- screen-width (+ 24 (get-width weapon-picker-rect))))
         (picker-height 220)
         (picker-top (- screen-height
                        (+ picker-height 8)))
         (picker-left 8))
    (make-rectangle picker-left
                    picker-top
                    picker-width
                    picker-height)))


;;; attach and detach

(define (prepare-to-attach-create-character-client-state state::CreateCharacterClientState client::FabricClient)
  (unless (*:getInitialized state)
    (let* ((screen::Screen (*:getScreen client))
           (gui-node::Node (*:getGuiNode client))
           (Align BitmapFont:Align)
           (faction-nameplate::Label (make-faction-nameplate screen))
           (sky::Spatial (make-sky-box))
           (character-nameplate::Label (make-character-nameplate screen))
           (faction-picker::Window (make-faction-picker state screen))
           (weapon-picker::Window (make-weapon-picker state screen))
           (armor-picker::Window (make-armor-picker state screen))
           (augment-picker::Window (make-augment-picker state screen))
           (name-picker::Window (make-name-picker screen))
           (character-acceptor::Window (make-character-acceptor screen)))
      (*:setFactionPicker state faction-picker)
      (*:setWeaponPicker state weapon-picker)
      (*:setArmorPicker state armor-picker)
      (*:setAugmentPicker state augment-picker)
      (*:setNamePicker state name-picker)
      (*:setCharacterAcceptor state character-acceptor)
      (*:setFactionNameplate state faction-nameplate)
      (*:setCharacterNameplate state character-nameplate)
      (*:setSky state sky)
      (*:setInitialized state #t))))

(define (did-attach-create-character-client-state state::CreateCharacterClientState mgr::AppStateManager)
  (when (*:getInitialized state)
    (let* ((client::FabricClient (*:getApp state))
           (screen::Screen (*:getScreen client))
           (gui-node::Node (*:getGuiNode client)))
      (*:enqueue client
                 (runnable (lambda ()
                             (let ((client::FabricClient (*:getApp state))
                                   (root::Node (*:getRootNode client)))
                               (*:addElement screen (*:getFactionNameplate state))
                               (*:addElement screen (*:getCharacterNameplate state))
                               (*:addElement screen (*:getFactionPicker state))
                               (*:addElement screen (*:getWeaponPicker state))
                               (*:addElement screen (*:getArmorPicker state))
                               (*:addElement screen (*:getAugmentPicker state))
                               (*:addElement screen (*:getNamePicker state))
                               (*:addElement screen (*:getCharacterAcceptor state))
                               (*:attachChild root (*:getSky state))
                               (*:addControl gui-node screen))))))))

(define (did-detach-create-character-client-state state::CreateCharacterClientState mgr::AppStateManager)
  (when (*:getInitialized state)
    (let* ((client::FabricClient (*:getApp state))
           (screen::Screen (*:getScreen client))
           (gui-node::Node (*:getGuiNode client)))
      (*:enqueue client
                 (runnable (lambda ()
                             (let ((client::FabricClient (*:getApp state))
                                   (root::Node (*:getRootNode client))
                                   (sky::Spatial (*:getSky state)))
                               (*:detachChild root sky)
                               (*:setSky state #!null)
                               (*:removeElement screen (*:getFactionNameplate state))
                               (*:removeElement screen (*:getCharacterNameplate state))
                               (*:removeElement screen (*:getFactionPicker state))
                               (*:removeElement screen (*:getWeaponPicker state))
                               (*:removeElement screen (*:getArmorPicker state))
                               (*:removeElement screen (*:getAugmentPicker state))
                               (*:removeElement screen (*:getNamePicker state))
                               (*:removeElement screen (*:getCharacterAcceptor state))
                               (*:removeControl gui-node screen)
                               (*:setInitialized state #f))))))))
