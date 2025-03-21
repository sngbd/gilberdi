module Lenis where

import Prelude

import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn3, runEffectFn1, runEffectFn3)
import Foreign (Foreign)

type LenisInstance = Foreign

foreign import createLenisImpl :: Effect LenisInstance
foreign import startLenisImpl :: EffectFn1 LenisInstance LenisInstance
foreign import lenisScrollToImpl :: EffectFn3 LenisInstance String Foreign LenisInstance
foreign import destroyLenisImpl :: EffectFn1 LenisInstance (Effect Unit)

createLenis :: Effect LenisInstance
createLenis = createLenisImpl

startLenis :: LenisInstance -> Effect LenisInstance
startLenis lenis = runEffectFn1 startLenisImpl lenis

lenisScrollTo :: LenisInstance -> String -> Foreign -> Effect LenisInstance
lenisScrollTo lenis target options = runEffectFn3 lenisScrollToImpl lenis target options

destroyLenis :: LenisInstance -> Effect Unit
destroyLenis lenis = do
  effect <- runEffectFn1 destroyLenisImpl lenis
  effect