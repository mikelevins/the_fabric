;;;; ***********************************************************************
;;;;
;;;; Name:          view-name-menu.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       name menus for the character creator
;;;; Author:        mikel evins
;;;; Copyright:     2015 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export
 NameMenu)

(require "appstate-character-creator.scm")
(require "syntax-classes.scm")

;;; ---------------------------------------------------------------------
;;; Java imports
;;; ---------------------------------------------------------------------

(import-as Screen tonegod.gui.core.Screen)
(import-as SelectBox tonegod.gui.controls.lists.SelectBox)
(import-as Vector2f com.jme3.math.Vector2f)

;;; CLASS NameMenu
;;; ---------------------------------------------------------------------
;;; a SelectBox subclass used to present name options for player
;;; characters

(defclass NameMenu (SelectBox)
  (slots:
   (app-state::CharacterCreatorAppState init-form: #!null getter: getAppState setter: setAppState))
  (methods:
   ((*init* state::CharacterCreatorAppState screen::Screen uid::String position::Vector2f size::Vector2f)
    (invoke-special SelectBox (this) '*init* screen uid position size)
    (set! app-state state))
   ((onChange index::int value::Object)
    (notify-name-selection-changed app-state index value))))

