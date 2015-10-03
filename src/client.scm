;;;; ***********************************************************************
;;;;
;;;; Name:          client.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       the Fabric client
;;;; Author:        mikel evins
;;;; Copyright:     2015 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export
 FabricClient
 activate-state
 alert
 make-client
 setup-inputs
 start-client
 stop-client
 the-client)



;;; ---------------------------------------------------------------------
;;; required modules
;;; ---------------------------------------------------------------------

(require util-error)
(require data-assets)
(require data-config)
(require data-users)
(require model-user)
(require state)
(require state-login)
(require state-create-character)
(require state-pick-character)
(require state-play)
(require state-transition)
(require view-alert)

;;; ---------------------------------------------------------------------
;;; Java imports
;;; ---------------------------------------------------------------------

(import (only (com jme3 input MouseInput) AXIS_X AXIS_Y))

(import (class com.jme3.app SimpleApplication))
(import (class com.jme3.app.state AbstractAppState AppStateManager))
(import (class com.jme3.asset AssetManager))
(import (class com.jme3.input InputManager KeyInput MouseInput))
(import (class com.jme3.input.controls ActionListener AnalogListener
          KeyTrigger MouseAxisTrigger MouseButtonTrigger))
(import (class com.jme3.math Vector3f))
(import (class com.jme3.post FilterPostProcessor))
(import (class com.jme3.post.filters BloomFilter))
(import (class com.jme3.renderer ViewPort))
(import (class com.jme3.system AppSettings))
(import (class gnu.mapping Symbol))
(import (class java.lang Thread))
(import (class org.lwjgl.input Mouse))
(import (class tonegod.gui.core Screen))

;;; ---------------------------------------------------------------------
;;; Client parameters
;;; ---------------------------------------------------------------------

(define the-client (make-parameter #!null))

;;; ---------------------------------------------------------------------
;;; FabricClient
;;; ---------------------------------------------------------------------

(define-simple-class FabricClient (SimpleApplication AnalogListener ActionListener)
  ;; slots
  (user::FabricUser init: #!null)
  (username::String init: #!null)
  (password-hash::String init: #!null)
  (password-salt::byte[] init: #!null)
  (character::FabricCharacter init: #!null)
  (app-settings init: #!null)
  (state init: #!null)
  (screen init: #!null)
  (speed init: #!null)
  (direction type: Vector3f init-form: (Vector3f))
  (left-button? init-form: #f)
  (right-button? init-form: #f)
  ;; accessors
  ((getKeyInput) keyInput)
  ((getCameraDirection) (*:getDirection cam))
  ((getViewport) viewPort)
  ;; event handlers
  ((onAnalog name value tpf)(*:handleAnalogEvent (as FabricClientState state) name value tpf))
  ((onAction name key-pressed? tpf)(*:handleActionEvent (as FabricClientState state) name key-pressed? tpf))
  ;; init
  ((simpleInitApp) (init-client (this))))


(define (setup-lighting app::FabricClient)
  (let* ((asset-manager::AssetManager (get-asset-manager))
         (bloom (BloomFilter BloomFilter:GlowMode:Objects))
         (filter-processor::FilterPostProcessor (FilterPostProcessor asset-manager))
         (viewport::ViewPort (*:getViewport app)))
    (*:setDownSamplingFactor bloom 2.0)
    (*:setBloomIntensity bloom 2.0)
    (*:addFilter filter-processor bloom)
    (*:addProcessor viewport filter-processor)))

(define (init-client app::FabricClient)
  (begin (load-client-configuration)
         (*:setEnabled (*:getFlyByCamera app) #f)
         (set! app:screen (Screen app))
         (setup-inputs app)
         (setup-lighting app)
         (activate-state app 'transition)
         #!void))

(define (make-client #!key
                     (client::FabricClient (FabricClient))
                     (settings::AppSettings (AppSettings #t))
                     (screen-width 1920)
                     (screen-height 1200)
                     (title "The Fabric")
                     (settings-image "Interface/icon.jpg")
                     (show-fps #f)
                     (show-settings #t)
                     (show-statistics #f)
                     (pause-on-lost-focus #f)
                     (grab-mouse #f))
  (*:setResolution settings screen-width screen-height)
  (*:setTitle settings title)
  (*:setSettingsDialogImage settings settings-image)
  (*:setSettings client settings)
  (*:setDisplayFps client show-fps)
  (*:setShowSettings client show-settings)
  (*:setDisplayStatView client show-statistics)
  (*:setPauseOnLostFocus client pause-on-lost-focus)
  (Mouse:setGrabbed grab-mouse)
  client)

(define (start-client)
  (the-client (make-client))
  (let* ((user::FabricUser (get-user "fabric"))
         (characters user:characters)
         (character::FabricCharacter (car characters))
         (client::FabricClient (the-client)))
    (set! client:character character)
    (*:start (as FabricClient (the-client)))))

(define (stop-client)
  (*:stop (as FabricClient (the-client))))

;;; ---------------------------------------------------------------------
;;; state changes
;;; ---------------------------------------------------------------------

(define (%enqueue-state-change client::FabricClient change-proc)
  (*:enqueue client (runnable change-proc)))

(define (%activate-supplied-state client::FabricClient new-state::FabricClientState)
  (let* ((mgr::AppStateManager (*:getStateManager client))
         (current-state client:state))
    (%enqueue-state-change client
                           (lambda ()
                             (unless (eqv? #!null current-state)
                               (*:detach mgr current-state)
                               (*:cleanup (as FabricClientState current-state)))
                             (*:attach mgr new-state)
                             (*:initialize new-state mgr client)))))



(define (activate-state client::FabricClient state-name::Symbol . initargs)
  (let ((transition-state (TransitionState)))
    (case state-name
      ((login)(LoginState)(let* ((new-state (LoginState)))
                            (%activate-supplied-state client transition-state)
                            (Thread:sleep 500)
                            (%activate-supplied-state client new-state)))
      ((create-character)(if (eqv? #!null client:user)
                             (begin (format #t "~%Tried to start the character creator without logging in")
                                    (activate-state (the-client) 'login))
                             (let* ((new-state (CreateCharacterState)))
                               (%activate-supplied-state client transition-state)
                               (Thread:sleep 500)
                               (%activate-supplied-state client new-state))))
      ((pick-character)(if (eqv? #!null client:user)
                           (begin (format #t "~%Tried to start the character picker without logging in")
                                  (activate-state (the-client) 'login))
                           (let* ((new-state (PickCharacterState)))
                             (%activate-supplied-state client transition-state)
                             (Thread:sleep 500)
                             (%activate-supplied-state client new-state))))
      ((play)(if (eqv? #!null client:character)
                 (begin (format #t "~%Tried to start the play state without choosing a character")
                        (activate-state (the-client) 'login))
                 (let* ((new-state (apply make-play-state initargs)))
                   (%activate-supplied-state client transition-state)
                   (Thread:sleep 500)
                   (%activate-supplied-state client new-state))))
      ((transition)(%activate-supplied-state client transition-state))
      (else (error "Unknown state name: " state-name)))))


;;; ---------------------------------------------------------------------
;;; input handling
;;; ---------------------------------------------------------------------

(define (setup-inputs client::FabricClient)
  (let* ((key-input::KeyInput (*:getKeyInput client))
         (input-manager::InputManager (*:getInputManager client)))
    (*:addMapping input-manager "KeyA" (KeyTrigger key-input:KEY_A))
    (*:addMapping input-manager "KeyD" (KeyTrigger key-input:KEY_D))
    (*:addMapping input-manager "KeyS" (KeyTrigger key-input:KEY_S))
    (*:addMapping input-manager "KeySPACE" (KeyTrigger key-input:KEY_SPACE))
    (*:addMapping input-manager "KeyW" (KeyTrigger key-input:KEY_W))
    (*:addMapping input-manager "KeyX" (KeyTrigger key-input:KEY_X))
    (*:addMapping input-manager "MouseButtonLeft" (MouseButtonTrigger MouseInput:BUTTON_LEFT))
    (*:addMapping input-manager "MouseButtonRight" (MouseButtonTrigger MouseInput:BUTTON_RIGHT))
    (*:addMapping input-manager "MouseDragDown" (MouseAxisTrigger AXIS_Y #t))
    (*:addMapping input-manager "MouseDragUp" (MouseAxisTrigger AXIS_Y #f))
    (*:addMapping input-manager "MouseDragLeft" (MouseAxisTrigger AXIS_X #t))
    (*:addMapping input-manager "MouseDragRight" (MouseAxisTrigger AXIS_X #f))
    (*:addListener input-manager client
                   ;; motion controls
                   "KeyA" "KeyD" "KeyW" "KeyS" "KeySPACE" "KeyX"
                   "MouseButtonLeft" "MouseButtonRight"
                   "MouseDragRight" "MouseDragLeft" "MouseDragUp" "MouseDragDown")))

;;; ---------------------------------------------------------------------
;;; UI
;;; ---------------------------------------------------------------------

