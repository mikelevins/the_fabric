;;;; ***********************************************************************
;;;;
;;;; Name:          message-activate-create-character.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       a message that commands the client to activate the
;;;;                character-creation state
;;;; Author:        mikel evins
;;;; Copyright:     2015 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export
 ActivateCreateCharacterMessage)

(require message)
(require model-user)

(import (class com.jme3.network AbstractMessage))
(import (class com.jme3.network.serializing Serializable))
(import (class java.lang String))

(define-simple-class ActivateCreateCharacterMessage (FabricMessage) (@Serializable)
  (name type: String init: "ActivateCreateCharacterMessage")
  (user type: FabricUser init: #!null)
  ((*init*) #!void))

