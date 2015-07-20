;;;; ***********************************************************************
;;;;
;;;; Name:          state-transit.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       fabric AppStates
;;;; Author:        mikel evins
;;;; Copyright:     2015 by mikel evins
;;;;
;;;; ***********************************************************************
(format #t "~%loading state-transit.scm")

(module-export
 TransitState
 make-transit-state)

;;; ---------------------------------------------------------------------
;;; required modules
;;; ---------------------------------------------------------------------

(require "util-error.scm")
(require "util-java.scm")
(require "util-lists.scm")
(require "data-nodes.scm")
(require "client-state.scm")

;;; ---------------------------------------------------------------------
;;; Java imports
;;; ---------------------------------------------------------------------

(import-as Application com.jme3.app.Application)
(import-as AppStateManager com.jme3.app.state.AppStateManager)

;;; ---------------------------------------------------------------------
;;; the client transit AppState class
;;; ---------------------------------------------------------------------

;;; CLASS TransitState
;;; ---------------------------------------------------------------------

(define-simple-class TransitState (FabricClientState)
  ;; slots
  (initialized? init: #f)
  ((getInitialized) initialized?)
  ((setInitialized new-state)(set! initialized? new-state))
  (from-name init: #f)
  ((getFromName) from-name)
  ((setFromName new-name)(set! from-name new-name))
  (to-name init: #f)
  ((getToName) to-name)
  ((setToName new-name)(set! to-name new-name))
  ;; methods
  ((cleanup) (%transit-state-cleanup (this)))
  ((isEnabled) (%transit-state-enabled? (this)))
  ((stateAttached state-manager::AppStateManager)
   (%transit-state-attached (this) state-manager))
  ((stateDetached state-manager::AppStateManager)
   (%transit-state-detached (this) state-manager))
  ;; init
  ((initialize) (%transit-state-initialize (this)))
  ((isInitialized) (%transit-state-initialized? (this))))

(define (%transit-state-cleanup state::TransitState)
  (format #t "~%%transit-state-cleanup called"))

(define (%transit-state-initialize state::TransitState)
  (format #t "~%%transit-state-initialize called"))

(define (%transit-state-enabled? state::TransitState) #t)

(define (%transit-state-initialized? state::TransitState) #t)

(define (%transit-state-attached state::TransitState manager::AppStateManager)
  (format #t "~%%transit-state-attached called"))

(define (%transit-state-detached state::TransitState manager::AppStateManager)
  (format #t "~%%transit-state-detached called"))

(define (make-transit-state client::Application #!key (from "The Sun")(to "Earth"))
  (let ((state (TransitState)))
    (*:setClient state client)
    (*:setFromName state from)
    (*:setToName state to)
    state))
