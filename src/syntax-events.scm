;;; ***********************************************************************
;;;;
;;;; Name:          syntax-events.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       syntax definitions for event-handling
;;;; Author:        mikel evins
;;;; Copyright:     2014 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export on-analog on-action route-keys)

(define-syntax on-analog
  (syntax-rules (->)
    ((on-analog (evt-name)
                (s -> expr) ...)
     (cond
      ((invoke evt-name 'equals s) expr) ...
      (#t #f)))))

(define-syntax on-action
  (syntax-rules (->)
    ((on-action (evt-name)
                (s -> expr) ...)
     (cond
      ((invoke evt-name 'equals s) expr) ...
      (#t #f)))))

(define-syntax route-keys
  (syntax-rules (->)
    ((route-keys (input-manager-object)
                 (trigger-object -> event-name)
                 ...)
     (begin
       (*:addMapping input-manager-object event-name trigger-object)
       ...))))

