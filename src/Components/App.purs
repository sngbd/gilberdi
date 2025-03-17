module Components.App (mkApp) where

import Prelude
import Data.String (drop)
import Effect (Effect)
import React.Basic.DOM as R
import React.Basic.Hooks as React
import React.Basic.Hooks (Component, component, useState, useEffect, (/\))
import Web.Event.EventTarget (EventListener, eventListener, addEventListener, removeEventListener)
import Web.Event.Event (Event, EventType(..))
import Web.HTML (window)
import Web.HTML.Location (hash)
import Web.HTML.Window (location, toEventTarget)

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

    let handler :: Event -> Effect Unit
        handler _ = do
          win' <- window
          loc' <- location win'
          currentHash <- hash loc'
          let currentSection = if currentHash == "" then "home" else drop 1 currentHash
          setActiveSection (const currentSection)

    let listener :: Effect EventListener
        listener = eventListener handler

    useEffect unit do
      win <- window
      loc <- location win
      initialHash <- hash loc
      let initialSection = if initialHash == "" then "home" else drop 1 initialHash
      setActiveSection (const initialSection)

      actualListener <- listener
      let winEventTarget = toEventTarget win
      addEventListener (EventType "hashchange") actualListener false winEventTarget
      pure $ removeEventListener (EventType "hashchange") actualListener false winEventTarget

    pure $ R.div
      { className: "min-h-screen bg-white text-black font-mono"
      , children:
          [ navbar activeSection (\newSection -> setActiveSection (const newSection)) mobileMenuOpen (\newValue -> setMobileMenuOpen (const newValue))
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