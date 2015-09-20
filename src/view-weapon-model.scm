;;;; ***********************************************************************
;;;;
;;;; Name:          view-weapon-model.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       3D weapon models 
;;;; Author:        mikel evins
;;;; Copyright:     2015 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export
 make-weapon-model)

;;; ---------------------------------------------------------------------
;;; required modules
;;; ---------------------------------------------------------------------

(require util-java)
(require util-error)
(require util-color)
(require client-class)
(require data-assets)
(require model-rect)
(require model-character)

;;; ---------------------------------------------------------------------
;;; Java imports
;;; ---------------------------------------------------------------------

(import (only (com jme3 math FastMath) PI))

(import (class com.jme3.asset AssetManager))
(import (class com.jme3.effect ParticleEmitter ParticleMesh))
(import (class com.jme3.material Material RenderState))
(import (class com.jme3.math ColorRGBA Quaternion Vector3f))
(import (class com.jme3.renderer.queue RenderQueue))
(import (class com.jme3.scene Geometry Node))
(import (class com.jme3.scene.debug WireBox WireSphere))
(import (class com.jme3.scene.shape Box Dome Sphere))
(import (class com.jme3.util SafeArrayList))
(import (class gnu.mapping Symbol))

;;; ---------------------------------------------------------------------
;;; 
;;; ---------------------------------------------------------------------

;;; (make-weapon-model)
;;; ---------------------------------------------------------------------

(define (make-weapon-model weapon-name::Symbol)
  (case weapon-name
    ((cannon)(make-cannon-weapon))
    ((impulse)(make-impulse-weapon))
    ((malware)(make-malware-weapon))
    ((bots)(make-bots-weapon))
    (else #!null)))


;;; ---------------------------------------------------------------------
;;; cannons
;;; ---------------------------------------------------------------------

(define (make-cannon-weapon)
  (let* ((asset-manager (get-asset-manager))
         (cannon-mat::Material (Material asset-manager "Common/MatDefs/Misc/Unshaded.j3md"))
         (color (ColorRGBA 0.6 0 0 0.7))
         (glow-color (ColorRGBA 0.9 0.4 0.4 0.9))
         (pivot (Node "CharacterWeapon"))
         (pivot0 (Node "ModulePivot0"))
         (pivot1 (Node "ModulePivot1")))
    (*:setColor cannon-mat "Color" color)
    (*:setColor cannon-mat "GlowColor" glow-color)
    (let* ((blendMode RenderState:BlendMode))
      (*:setBlendMode (*:getAdditionalRenderState cannon-mat) blendMode:Alpha))
    (let* ((cannon-module0 (Dome (Vector3f 0 0 0) 2 4 0.25 #f))
           (cannon-module1 (Dome (Vector3f 0 0 0) 2 4 0.25 #f))
           (cannon-module2 (Dome (Vector3f 0 0 0) 2 4 0.25 #f))
           (cannon-module3 (Dome (Vector3f 0 0 0) 2 4 0.25 #f))
           (geom0::Geometry (Geometry "Module0" cannon-module0))
           (geom1::Geometry (Geometry "Module1" cannon-module1))
           (geom2::Geometry (Geometry "Module2" cannon-module2))
           (geom3::Geometry (Geometry "Module3" cannon-module3))
           (bucket RenderQueue:Bucket))
      (*:setMaterial geom0 cannon-mat)
      (*:setMaterial geom1 cannon-mat)
      (*:setMaterial geom2 cannon-mat)
      (*:setMaterial geom3 cannon-mat)
      (*:setQueueBucket geom0 bucket:Transparent)
      (*:setQueueBucket geom1 bucket:Transparent)
      (*:setQueueBucket geom2 bucket:Transparent)
      (*:setQueueBucket geom3 bucket:Transparent)
      (*:setLocalTranslation geom0 0.0 0.0 0.0)
      (*:setLocalTranslation geom1 0.0 0.0 0.0)
      (let ((rotation::Quaternion (Quaternion))
            (pitch-axis::Vector3f (Vector3f 1 0 0)))
        (*:fromAngleAxis rotation PI pitch-axis)
        (*:setLocalRotation geom1 rotation))
      (*:setLocalTranslation geom2 0.0 0.0 0.0)
      (*:setLocalTranslation geom3 0.0 0.0 0.0)
      (let ((rotation (Quaternion))
            (pitch-axis (Vector3f 1 0 0)))
        (*:fromAngleAxis rotation PI pitch-axis)
        (*:setLocalRotation geom3 rotation))
      (*:setLocalTranslation pivot 0.0 0.0 0.0)
      (*:setLocalTranslation pivot0 4.5 0.0 0.0)
      (*:setLocalTranslation pivot1 -4.5 0.0 0.0)
      (*:attachChild pivot0 geom0)
      (*:attachChild pivot0 geom1)
      (*:attachChild pivot1 geom2)
      (*:attachChild pivot1 geom3)
      (*:attachChild pivot pivot0)
      (*:attachChild pivot pivot1)
      pivot)))

;;; ---------------------------------------------------------------------
;;; impulse weapons
;;; ---------------------------------------------------------------------

(define (make-impulse-weapon)
  (let* ((asset-manager (get-asset-manager))
         (impulse-mat::Material (Material asset-manager "Common/MatDefs/Misc/Unshaded.j3md"))
         (color (ColorRGBA 0.8 0.8 1 0.75))
         (glow-color (ColorRGBA 0.8 0.8 1 0.9))
         (pivot (Node "CharacterWeapon"))
         (pivot0 (Node "ModulePivot0"))
         (pivot1 (Node "ModulePivot1")))
    (*:setColor impulse-mat "Color" color)
    (*:setColor impulse-mat "GlowColor" glow-color)
    (let* ((blendMode RenderState:BlendMode))
      (*:setBlendMode (*:getAdditionalRenderState impulse-mat) blendMode:Alpha))
    (let* ((impulse-module0 (Sphere 32 32 0.25))
           (impulse-module1 (Sphere 32 32 0.25))
           (geom0::Geometry (Geometry "Module0" impulse-module0))
           (geom1::Geometry (Geometry "Module1" impulse-module1))
           (bucket RenderQueue:Bucket))
      (*:setMaterial geom0 impulse-mat)
      (*:setMaterial geom1 impulse-mat)
      (*:setQueueBucket geom0 bucket:Transparent)
      (*:setQueueBucket geom1 bucket:Transparent)
      (*:setLocalTranslation geom0 0.0 0.0 0.0)
      (*:setLocalTranslation geom1 0.0 0.0 0.0)
      (*:setLocalTranslation pivot 0.0 0.0 0.0)
      (*:setLocalTranslation pivot0 4.5 0.0 0.0)
      (*:setLocalTranslation pivot1 -4.5 0.0 0.0)
      (*:attachChild pivot0 geom0)
      (*:attachChild pivot1 geom1)
      (*:attachChild pivot pivot0)
      (*:attachChild pivot pivot1)
      pivot)))

;;; ---------------------------------------------------------------------
;;; malware
;;; ---------------------------------------------------------------------

(define (make-malware-weapon)
  (let* ((pivot::Node (Node "CharacterWeapon"))
         (pivot0::Node (Node "ModulePivot0"))
         (pivot1::Node (Node "ModulePivot1"))
         (emitter0::ParticleEmitter (ParticleEmitter "Smoke" ParticleMesh:Type:Triangle 32))
         (emitter1::ParticleEmitter (ParticleEmitter "Smoke" ParticleMesh:Type:Triangle 32))
         (asset-manager::AssetManager (get-asset-manager))
         (mat::Material (Material (get-asset-manager) "Common/MatDefs/Misc/Particle.j3md"))
         (ball-mat::Material (Material asset-manager "Common/MatDefs/Misc/Unshaded.j3md"))
         (start-color::ColorRGBA (ColorRGBA 0.5 0.2 0.8 0.5))
         (end-color::ColorRGBA (ColorRGBA 0.1 0.2 0.3 0.4))
         (ball-color::ColorRGBA (ColorRGBA 0.3 0.0 0.4 0.4))
         (glow-color::ColorRGBA (ColorRGBA 0.3 0.0 0.4 0.8)))
    (*:setColor ball-mat "Color" ball-color)
    (*:setColor ball-mat "GlowColor" glow-color)
    (let* ((blendMode RenderState:BlendMode)
           (ball-module0::Sphere (Sphere 32 32 0.125))
           (ball-module1::Sphere (Sphere 32 32 0.125))
           (geom0::Geometry (Geometry "Module0" ball-module0))
           (geom1::Geometry (Geometry "Module1" ball-module1))
           (bucket RenderQueue:Bucket))
      (*:setBlendMode (*:getAdditionalRenderState ball-mat) blendMode:Alpha)
      (*:setTexture mat "Texture" (*:loadTexture asset-manager "Effects/Smoke/Smoke.png"))
      (*:setMaterial geom0 ball-mat)
      (*:setMaterial geom1 ball-mat)
      (*:setQueueBucket geom0 bucket:Transparent)
      (*:setQueueBucket geom1 bucket:Transparent)
      (*:setMaterial emitter0 mat)
      (*:setMaterial emitter1 mat)
      (*:setImagesX emitter0 15)
      (*:setImagesX emitter1 15)
      (*:setImagesY emitter0 1)
      (*:setImagesY emitter1 1)
      (*:setStartColor emitter0 start-color)
      (*:setStartColor emitter1 start-color)
      (*:setEndColor emitter0 end-color)
      (*:setEndColor emitter1 end-color)
      (*:setInitialVelocity (*:getParticleInfluencer emitter0)(Vector3f 0.4 0.4 0.5))
      (*:setInitialVelocity (*:getParticleInfluencer emitter1)(Vector3f 0.4 0.5 0.4))
      (*:setNumParticles emitter0 64)
      (*:setNumParticles emitter1 64)
      (*:setParticlesPerSec emitter0 64)
      (*:setParticlesPerSec emitter1 64)
      (*:setSelectRandomImage emitter0 #t)
      (*:setSelectRandomImage emitter1 #t)
      (*:setRandomAngle emitter0 #t)
      (*:setRandomAngle emitter1 #t)
      (*:setStartSize emitter0 0.25)
      (*:setStartSize emitter1 0.25)
      (*:setEndSize emitter0 0.1)
      (*:setEndSize emitter1 0.1)
      (*:setGravity emitter0 0 0 0)
      (*:setGravity emitter1 0 0 0)
      (*:setLowLife emitter0 2)
      (*:setLowLife emitter1 2)
      (*:setHighLife emitter0 16)
      (*:setHighLife emitter1 16)
      (*:setVelocityVariation (*:getParticleInfluencer emitter0) 0.5)
      (*:setVelocityVariation (*:getParticleInfluencer emitter1) 0.5)
      (*:setLocalTranslation geom0 0.0 0.0 0.0)
      (*:setLocalTranslation geom1 0.0 0.0 0.0)
      (*:setLocalTranslation pivot 0.0 0.0 0.0)
      (*:setLocalTranslation pivot0 4.5 0.0 0.0)
      (*:setLocalTranslation pivot1 -4.5 0.0 0.0)
      (*:attachChild pivot0 emitter0)
      (*:attachChild pivot1 emitter1)
      (*:attachChild pivot0 geom0)
      (*:attachChild pivot1 geom1)
      (*:attachChild pivot pivot0)
      (*:attachChild pivot pivot1)
      pivot)))

;;; ---------------------------------------------------------------------
;;; bots
;;; ---------------------------------------------------------------------

(define (make-bots-weapon)
  (let* ((asset-manager (get-asset-manager))
         (bots-mat::Material (Material asset-manager "Common/MatDefs/Misc/Unshaded.j3md"))
         (color (ColorRGBA 0.8 1 1 0.75))
         (glow-color (ColorRGBA 0.8 0.8 1 1))
         (pivot (Node "CharacterWeapon"))
         (pivot0 (Node "ModulePivot0"))
         (pivot1 (Node "ModulePivot1")))
    (*:setColor bots-mat "Color" color)
    (*:setColor bots-mat "GlowColor" glow-color)
    (let* ((blendMode RenderState:BlendMode))
      (*:setBlendMode (*:getAdditionalRenderState bots-mat) blendMode:Alpha))
    (let* ((bots-module0 (WireSphere 0.5))
           (bots-module1 (WireSphere 0.5))
           (geom0::Geometry (Geometry "Module0" bots-module0))
           (geom1::Geometry (Geometry "Module1" bots-module1))
           (bucket RenderQueue:Bucket))
      (*:setMaterial geom0 bots-mat)
      (*:setMaterial geom1 bots-mat)
      (*:setQueueBucket geom0 bucket:Transparent)
      (*:setQueueBucket geom1 bucket:Transparent)
      (*:setLocalTranslation geom0 0.0 0.0 0.0)
      (*:setLocalTranslation geom1 0.0 0.0 0.0)
      (*:setLocalTranslation pivot 0.0 0.0 0.0)
      (*:setLocalTranslation pivot0 4.5 0.0 0.0)
      (*:setLocalTranslation pivot1 -4.5 0.0 0.0)
      (*:attachChild pivot0 geom0)
      (*:attachChild pivot1 geom1)
      (*:attachChild pivot pivot0)
      (*:attachChild pivot pivot1)
      pivot)))
