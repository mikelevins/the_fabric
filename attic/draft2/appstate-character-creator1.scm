;;;; ***********************************************************************
;;;;
;;;; Name:          appstate-character-creator.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       create a new character
;;;; Author:        mikel evins
;;;; Copyright:     2014 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export
 CharacterCreatorAppState)

;;; ---------------------------------------------------------------------
;;; ABOUT
;;; ---------------------------------------------------------------------

;;; ---------------------------------------------------------------------
;;; required modules
;;; ---------------------------------------------------------------------

(require "util-java.scm")
(require "util-error.scm")
(require "syntax-classes.scm")
(require "init-config-local.scm")
(require "net-connect.scm")
(require "net-messaging.scm")
(require "model-character.scm")
(require "view-login.scm")
(require "view-player-character.scm")
(require "view-faction-nameplate.scm")
(require "view-character-nameplate.scm")
(require "view-faction-palette.scm")
(require "view-armor-palette.scm")
(require "view-weapons-palette.scm")
(require "view-augment-palette.scm")
(require "view-name-palette.scm")
(require "view-skybox.scm")
(require "client-main.scm")

;;; ---------------------------------------------------------------------
;;; Java imports
;;; ---------------------------------------------------------------------

(import-as AbstractAppState com.jme3.app.state.AbstractAppState)
(import-as AppStateManager com.jme3.app.state.AppStateManager)
(import-as ButtonAdapter tonegod.gui.controls.buttons.ButtonAdapter)
(import-as Client com.jme3.network.Client)
(import-as ConnectException java.net.ConnectException)
(import-as DefaultClient com.jme3.network.base.DefaultClient)
(import-as Label tonegod.gui.controls.text.Label)
(import-as Network com.jme3.network.Network)
(import-as Node com.jme3.scene.Node)
(import-as Screen tonegod.gui.core.Screen)
(import-as Serializer com.jme3.network.serializing.Serializer)
(import-as SimpleApplication com.jme3.app.SimpleApplication)
(import-as Spatial com.jme3.scene.Spatial)
(import-as TLabel tonegod.gui.controls.text.Label)
(import-as Vector2f com.jme3.math.Vector2f)
(import-as Vector4f com.jme3.math.Vector4f)
(import-as Window tonegod.gui.controls.windows.Window)

;;; ---------------------------------------------------------------------
;;; the CharacterCreatorAppState class
;;; ---------------------------------------------------------------------

;;; CLASS CharacterCreatorAppState
;;; ---------------------------------------------------------------------
;;; an AppState class that constructs and managers the Login scene in
;;; the Fabric client

(defclass CharacterCreatorAppState (AbstractAppState)
  (slots:
   ;; AppState common
   (app::SimpleApplication init-form: #!null getter: getApp setter: setApp)
   (state-manager::AppStateManager init-form: #!null getter: getStateManager setter: setStateManager)
   (initialized init-form: #f getter: getInitialized setter: setInitialized)
   (enabled init-form: #f getter: getEnabled setter: setEnabled)
   ;; character data
   (character init-form: (make-player-character) getter: getCharacter setter: setCharacter)
   ;; scene elements
   (sky::Spatial init-form: #!null getter: getSky setter: setSky)
   ;; UI
   (character-nameplate::TLabel init-form: #!null getter: getCharacterNameplate setter: setCharacterNameplate)
   (faction-nameplate::TLabel init-form: #!null getter: getFactionNameplate setter: setFactionNameplate)
   (faction-palette::TLabel init-form: #!null getter: getFactionPalette setter: setFactionPalette)
   (armor-palette::Window init-form: #!null getter: getArmorPalette setter: setArmorPalette)
   (weapons-palette::Window init-form: #!null getter: getWeaponsPalette setter: setWeaponsPalette)
   (augments-palette::Window init-form: #!null getter: getAugmentsPalette setter: setAugmentsPalette)
   (name-palette::Window init-form: #!null getter: getNamePalette setter: setNamePalette))
  (methods:
   ((initialize mgr::AppStateManager client::FabricClient)
    (invoke-special AbstractAppState (this) 'initialize mgr client)
    (init-creator-state (this) mgr client))
   ((cleanup)(cleanup-creator-state (this)))
   ((isEnabled) enabled)
   ((isInitialized) initialized)
   ((stateAttached mgr::AppStateManager)(handle-state-attached (this) mgr))))

(define (init-creator-state state::CharacterCreatorAppState mgr::AppStateManager client::FabricClient)
  (*:setApp state client)
  (*:setStateManager state mgr)
  (*:setInitialized state #t))

(define (handle-state-attached state::CharacterCreatorAppState mgr::AppStateManager)
  (let ((client::FabricClient (*:getApplication mgr)))
    (if (not (*:getInitialized state))
        (*:initialize state mgr client))
    (let* ((root-node (*:getRootNode client))
           (screen::Screen (*:getScreen client))
           (gui-node::Node (*:getGuiNode client))
           (sky::Spatial (make-sky-box client))
           (character-nameplate::TLabel (make-character-nameplate screen))
           (faction-nameplate::TLabel (make-faction-nameplate screen))
           (faction-palette::Window (make-faction-palette screen))
           (armor-palette::Window (make-armor-palette screen))
           (weapons-palette::Window (make-weapons-palette screen))
           (augments-palette::Window (make-augments-palette screen))
           (name-palette::Window (make-name-palette state screen)))
      (*:setSky state sky)
      (*:attachChild root-node sky)
      (*:setCharacterNameplate state character-nameplate)
      (*:addElement screen character-nameplate)
      (*:setFactionNameplate state faction-nameplate)
      (*:addElement screen faction-nameplate)
      (*:setFactionPalette state faction-palette)
      (*:addElement screen faction-palette)
      (*:setArmorPalette state armor-palette)
      (*:addElement screen armor-palette)
      (*:setWeaponsPalette state weapons-palette)
      (*:addElement screen weapons-palette)
      (*:setAugmentsPalette state augments-palette)
      (*:addElement screen augments-palette)
      (*:setNamePalette state name-palette)
      (*:addElement screen name-palette)
      (*:addControl gui-node screen))))

(define (cleanup-creator-state state::CharacterCreatorAppState)
  (let* ((client::FabricClient (*:getApp state))
         (root-node (*:getRootNode client))
         (screen::Screen (*:getScreen client))
         (gui-node::Node (*:getGuiNode client)))
    (*:setSky state #!null)
    (*:detachChild root-node sky)
    (*:setCharacterNameplate state #!null)
    (*:setFactionNameplate state #!null)
    (*:setFactionPalette state #!null)
    (*:setArmorPalette state #!null)
    (*:setWeaponsPalette state #!null)
    (*:setAugmentsPalette state #!null)
    (*:setNamePalette state #!null)
    (*:removeControl gui-node screen)))



