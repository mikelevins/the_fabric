;;;; ***********************************************************************
;;;; Name:          LOAD-WORKSHOP.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       system loader for the Workshop
;;;; Author:        mikel evins
;;;; Copyright:     2014 by mikel evins
;;;;
;;;; ***********************************************************************

(require "parameters-version.scm")
(require "setting-lighting.scm")
(require "setting-hubs.scm")
(require "setting-celestial-objects.scm")
(require "utilities-math.scm")
(require "utilities-java.scm")
(require "data-pmaps.scm")
(require "interface-frame.scm")
(require "assets-general.scm")
(require "application-common.scm")
(require "application-workshop.scm")

;;; (define $ws (make-workshop))
;;; (*:start $ws)