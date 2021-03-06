;;;; ***********************************************************************
;;;;
;;;; Name:          client-state-play.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       supporting functions for PlayClientState
;;;; Author:        mikel evins
;;;; Copyright:     2015 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export
 compute-node-nameplate-rect
 did-attach-play-client-state
 did-detach-play-client-state
 prepare-to-attach-play-client-state)

;;; ---------------------------------------------------------------------
;;; required modules
;;; ---------------------------------------------------------------------

(require "util-java.scm")
(require "util-error.scm")
(require "util-lists.scm")
(require "syntax-classes.scm")
(require "view-loginbox.scm")
(require "client-states.scm")
(require "client-main.scm")
(require "data-nodes.scm")
(require "view-celestial-body.scm")
(require "view-skybox.scm")
(require "view-node-nameplate.scm")
(require "view-actionbar.scm")
(require "view-chatbox.scm")
(require "model-rect.scm")

;;; ---------------------------------------------------------------------
;;; Java imports
;;; ---------------------------------------------------------------------

(import-as AppStateManager com.jme3.app.state.AppStateManager)
(import-as BitmapFont com.jme3.font.BitmapFont)
(import-as Geometry com.jme3.scene.Geometry)
(import-as Label tonegod.gui.controls.text.Label)
(import-as Node com.jme3.scene.Node)
(import-as Panel tonegod.gui.controls.windows.Panel)
(import-as Screen tonegod.gui.core.Screen)
(import-as Spatial com.jme3.scene.Spatial)
(import-as Vector2f com.jme3.math.Vector2f)
(import-as Vector3f com.jme3.math.Vector3f)


;;; ---------------------------------------------------------------------
;;; PlayClientState functions
;;; ---------------------------------------------------------------------

(define (compute-node-nameplate-rect screen::Screen)
  (let* ((screen-width (*:getWidth screen))
         (nameplate-width 512)
         (nameplate-left (- screen-width nameplate-width 16))
         (nameplate-top 16)
         (nameplate-height 40))
    (make-rectangle nameplate-left
                    nameplate-top
                    nameplate-width
                    nameplate-height)))

(define (prepare-to-attach-play-client-state state::PlayClientState client::FabricClient)
  (unless (*:getInitialized state)
    (let* ((client::FabricClient (*:getApp state))
           (screen::Screen (*:getScreen client))
           (gui-node::Node (*:getGuiNode client))
           (nodename (*:getNodeName state))
           (fabric-node (assoc nodename +fabric-nodes+))
           (texname::String (get-key (cdr fabric-node) 'body-texture:))
           (body (make-celestial-body texname))
           (sky::Spatial (make-sky-box))
           (nameplate::Label (make-node-nameplate screen nodename))
           (action-bar::Panel (make-action-bar screen))
           (chatbox::Panel (make-chatbox screen))
           (camera (*:getCamera client))
           (Align BitmapFont:Align))
      (*:setNodeNameplate state nameplate)
      (*:setActionBar state action-bar)
      (*:setChatbox state chatbox)
      (*:setCelestialBody state body)
      (*:setFrustumFar camera 80000)
      (*:setLocation camera (Vector3f 0.0 0.0 40000))
      (*:setSky state sky)
      (*:setInitialized state #t))))

(define (did-attach-play-client-state state::PlayClientState mgr::AppStateManager)
  (when (*:getInitialized state)
    (let* ((client::FabricClient (*:getApp state))
           (screen::Screen (*:getScreen client))
           (gui-node::Node (*:getGuiNode client)))
      (*:enqueue client
                 (runnable (lambda ()
                             (let* ((client::FabricClient (*:getApp state))
                                    (root::Node (*:getRootNode client)))
                               (*:addElement screen (*:getNodeNameplate state))
                               (*:addElement screen (*:getActionBar state))
                               (*:addElement screen (*:getChatbox state))
                               (*:attachChild root (*:getSky state))
                               (*:attachChild root (*:getCelestialBody state))
                               (*:addControl gui-node screen))))))))

(define (did-detach-play-client-state state::PlayClientState mgr::AppStateManager)
  (when (*:getInitialized state)
    (let* ((client::FabricClient (*:getApp state))
           (screen::Screen (*:getScreen client))
           (gui-node::Node (*:getGuiNode client)))
      (*:enqueue client
                 (runnable (lambda ()
                             (let* ((client::FabricClient (*:getApp state))
                                    (root::Node (*:getRootNode client))
                                    (sky::Spatial (*:getSky state))
                                    (body::Geometry (*:getCelestialBody state)))
                               (*:removeElement screen (*:getNodeNameplate state))
                               (*:removeElement screen (*:getActionBar state))
                               (*:removeElement screen (*:getChatbox state))
                               (*:setNodeNameplate state #!null)
                               (*:detachChild root sky)
                               (*:detachChild root body)
                               (*:setSky state #!null)
                               (*:setCelestialBody state #!null)
                               (*:removeControl gui-node screen)
                               (*:setInitialized state #f))))))))
