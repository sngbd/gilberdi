module Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Console (log)
import React.Basic.DOM.Client (createRoot, renderRoot)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML (window)
import Web.HTML.Window (document)

import Components.App (mkApp)

main :: Effect Unit
main = do
  container <- getElementById "root" =<< (toNonElementParentNode <$> (document =<< window))
  case container of
    Nothing -> log "Container element not found."
    Just c -> do
      app <- mkApp
      root <- createRoot c
      renderRoot root (app unit)
      log "App mounted"