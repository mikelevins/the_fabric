;;;; ***********************************************************************
;;;;
;;;; Name:          net-messaging.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       fabric network message handling
;;;; Author:        mikel evins
;;;; Copyright:     2015 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export
 ChatMessage
 RequestCreateAccountMessage
 RequestLoginMessage
 ResponseCreateAccountMessage
 ResponseLoginMessage)

;;; ---------------------------------------------------------------------
;;; ABOUT
;;; ---------------------------------------------------------------------
;;; This file implements the message classes used by the Fabric client
;;; and server to coordinate with each other and to pass data back and
;;; forth. It also implements the code that makes network connections
;;; in order to pass messages.

;;; ---------------------------------------------------------------------
;;; required modules
;;; ---------------------------------------------------------------------

(require "util-java.scm")
(require "util-lists.scm")
(require "syntax-classes.scm")
(require "model-id.scm")
(require "model-auth.scm")

;;; ---------------------------------------------------------------------
;;; Java imports
;;; ---------------------------------------------------------------------

(import-as AbstractMessage com.jme3.network.AbstractMessage)
(import-as Filters com.jme3.network.Filters)
(import-as Network com.jme3.network.Network)
(import-as Serializable com.jme3.network.serializing.Serializable)
(import-as String java.lang.String)

;;; =====================================================================
;;; Message types
;;; =====================================================================
;;; all messages except RequestCreateAccountMessage and
;;; RequestLoginMessage require auth tokens in order to be accepted by
;;; client or server. RequestCreateAccountMessage requests the
;;; creation of a new account; if it's successful then an auth token
;;; is returned for a login session for the newly-created
;;; account. RequestLoginMessage requests an auth token which is
;;; supplied by a successful ResponseLoginMessage.

;;; CLASS RequestCreateAccountMessage
;;; ---------------------------------------------------------------------
;;; client -> server
;;; the class of messages requesting creation of a new player account

(defclass RequestCreateAccountMessage (AbstractMessage)
  (annotations: @Serializable)
  (slots:
   (username type: String init-form: #!null getter: getUsername setter: setUsername)
   (password type: String init-form: #!null getter: getPassword setter: setPassword))
  (methods:
   ((toString) (format #f "Create: ~A" username))))


;;; CLASS ResponseCreateAccountMessage
;;; ---------------------------------------------------------------------
;;; client <- server
;;; the class of messages responding to a request for the creation of a
;;; new player account

(defclass ResponseCreateAccountMessage (AbstractMessage)
  (annotations: @Serializable)
  (slots:
   (username type: String init-form: #!null getter: getUsername setter: setUsername)
   (auth-token init-form: #!null getter: getAuthToken setter: setAuthToken)
   (succeeded? init-form: #!null getter: getSucceeded setter: setSucceeded))
  (methods:
   ((toString) (format #f "Create: ~A" username))))


;;; CLASS RequestLoginMessage
;;; ---------------------------------------------------------------------
;;; client -> server
;;; the class of messages request a login session

(defclass RequestLoginMessage (AbstractMessage)
  (annotations: @Serializable)
  (slots:
   (username type: String init-form: #!null getter: getUsername setter: setUsername)
   (password type: String init-form: #!null getter: getPassword setter: setPassword))
  (methods:
   ((toString) (format #f "Login: ~A" username))))


;;; CLASS ResponseLoginMessage
;;; ---------------------------------------------------------------------
;;; client <- server
;;; the class of messages responding to a request for a login session

(defclass ResponseLoginMessage (AbstractMessage)
  (annotations: @Serializable)
  (slots:
   (succeeded? init-form: #!null getter: getSucceeded setter: setSucceeded)
   (auth-token init-form: #!null getter: getAuthToken setter: setAuthToken)
   (status init-form: #!null getter: getStatus setter: setStatus))
  (methods:
   ((toString) (format #f "Login response: succeeded? ~A" succeeded?))))

;;; ---------------------------------------------------------------------
;;; Chat messages
;;; ---------------------------------------------------------------------
;;; TODO: create chat channels


;;; CLASS ChatMessage
;;; ---------------------------------------------------------------------
;;; client <-> server
;;; the class of chat messages, which carry chat text from clients to
;;; the server, and are broadcast to all subscribed and connected users

(defclass ChatMessage (AbstractMessage)
  (annotations: @Serializable)
  (slots:
   (name type: String init-form: #!null getter: getName setter: setName)
   (contents type: String init-form: #!null getter: getContents setter: setContents))
  (methods:
   ((toString) (format #f "[~A] ~A" name contents))))

;;; ---------------------------------------------------------------------
;;; NOTES: Messages needed
;;; ---------------------------------------------------------------------
;;; - creating and naming characters
;;; - using the transit network
;;; - in-zone movement
;;; - combat actions
;;; - crafting actions
;;; - interaction with in-zone affordances (quests, tools, traps, etc.)
;;; - add objects and characters to a scene (server->client)
;;;
;;; Developer tools
;;; - add and delete network nodes
;;; - delete, add, and modify objects in nodes
;;; - add and delete transit portals
;;; - add NPCs and spawns
;;; - add archives (places that killed player characters can respawn)


