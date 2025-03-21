module Components.App (mkApp) where

import Prelude
import Data.String (drop)
import Data.Maybe (Maybe(..))
import React.Basic.DOM as R
import React.Basic.Hooks as React
import React.Basic.Hooks (Component, component, useState, useEffect, useRef, (/\), readRef, writeRef)
import Web.Event.EventTarget (eventListener, addEventListener, removeEventListener)
import Web.Event.Event (EventType(..))
import Web.HTML (window)
import Web.HTML.Location (hash)
import Web.HTML.Window (location, toEventTarget)
import Foreign (unsafeToForeign)

import Lenis (createLenis, startLenis, lenisScrollTo, destroyLenis)

import Components.Navbar (navbar, skipToContent)
import Components.Header (header)
import Components.About (about)
import Components.Experience (experience)
import Components.Projects (projects)
import Components.Skills (skillsSection)
import Components.Contact (contact)
import Components.Footer (footer)

mkApp :: Component Unit
mkApp = do
  component "App" \_ -> React.do
    activeSection /\ setActiveSection <- useState "home"
    mobileMenuOpen /\ setMobileMenuOpen <- useState false
    lenisRef <- useRef Nothing

    let listener = eventListener \_ -> do
          win <- window
          loc <- location win
          currentHash <- hash loc
          let currentSection = if currentHash == "" then "home" else drop 1 currentHash
          setActiveSection (const currentSection)

    useEffect unit do
      lenis <- createLenis
      initializedLenis <- startLenis lenis
      writeRef lenisRef (Just initializedLenis)
      
      win <- window
      loc <- location win
      initialHash <- hash loc
      let initialSection = if initialHash == "" then "home" else drop 1 initialHash
      setActiveSection (const initialSection)

      actualListener <- listener
      let winEventTarget = toEventTarget win
      addEventListener (EventType "hashchange") actualListener false winEventTarget
      
      pure do
        removeEventListener (EventType "hashchange") actualListener false winEventTarget
        lenisInstance <- readRef lenisRef
        case lenisInstance of
          Just l -> destroyLenis l
          Nothing -> pure unit

    let scrollToSection section = do
          setActiveSection (const section)
          lenisInstance <- readRef lenisRef
          case lenisInstance of
            Just lenis -> void $ lenisScrollTo lenis ("#" <> section) (unsafeToForeign { offset: 0, duration: 1.2 })
            Nothing -> pure unit
            
    pure $ R.div
      { className: "min-h-screen text-base font-mono"
      , children:
          [ navbar activeSection scrollToSection mobileMenuOpen (\newValue -> setMobileMenuOpen (const newValue))
          , skipToContent
          , header
          , about
          , experience
          , projects
          , skillsSection
          , contact
          , footer
          ]
      }