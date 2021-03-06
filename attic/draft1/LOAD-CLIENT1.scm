;;;; ***********************************************************************
;;;; FILE IDENTIFICATION
;;;;
;;;; Name:          LOAD.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       system loader
;;;; Author:        mikel evins
;;;; Copyright:     2014 by mikel evins
;;;;
;;;; ***********************************************************************

(require 'list-lib)
(require 'srfi-95) ; sorting

(require "version.scm")
(require "util-java.scm")
(require "util-random.scm")
(require "util-general.scm")
(require "util-lists.scm")
(require "syntax-classes.scm")
;; ;;; for local testing
;; ;;;(require "init-config-local.scm")
;; ;;; for testing against the server on explorersguild.com
(require "init-config.scm")
(require "model-id.scm")
(require "model-frame.scm")
(require "model-namegen-domains.scm")
(require "model-namegen.scm")
(require "model-kind.scm")
(require "model-entity.scm")
(require "assets-general.scm")
(require "view-controls.scm")
(require "view-colors.scm")
(require "view-shapes.scm")
(require "view-plasma.scm")
(require "view-name-cube.scm")
(require "view-player.scm")
(require "view-node.scm")
(require "net-messaging.scm")
(require "appstate-login.scm")
(require "appstate-pick.scm")
(require "appstate-play.scm")
(require "app-common.scm")
(require "app-client.scm")

;;; (define $the-client (make-client))
;;; (define $the-client (make-client "Jupiter"))
;;; (*:start $the-client)
