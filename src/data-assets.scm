;;;; ***********************************************************************
;;;;
;;;; Name:          data-assets.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       asset-manager utils
;;;; Author:        mikel evins
;;;; Copyright:     2014 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export
 get-asset-manager)

;;; ---------------------------------------------------------------------
;;; ABOUT
;;; ---------------------------------------------------------------------
;;; This file provides a simple utility for obtaining a reference to
;;; the JMonkeyEngine 3 desktop asset manager, a singleton object that
;;; loads media assets on demand. The client uses the asset manager
;;; to load textures, icons, and other media for us in the game.

;;; ---------------------------------------------------------------------
;;; required imports
;;; ---------------------------------------------------------------------

(import (class com.jme3.system JmeSystem))
(import (class java.lang Thread))

;;; ---------------------------------------------------------------------
;;; the asset manager
;;; ---------------------------------------------------------------------

;;; (get-asset-manager)
;;; ---------------------------------------------------------------------
;;; returns the asset manager

(define (get-asset-manager)
  (JmeSystem:newAssetManager
   (*:getResource (*:getContextClassLoader (Thread:currentThread))
                  "com/jme3/asset/Desktop.cfg")))





