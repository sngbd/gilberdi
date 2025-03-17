module Components.Common (sectionTitle, addDotPerspective) where

import Prelude
import React.Basic.DOM as R
import React.Basic.Hooks as React

sectionTitle :: String -> React.JSX
sectionTitle title =
  R.div
    { className: "relative"
    , children:
        [ R.div
            { className: "mb-2 text-gray-600 text-sm"
            , children: [ R.text ("$ cd /" <> title <> " && ls") ]
            }
        , R.h2
            { className: "text-3xl font-bold inline-block text-black"
            , children: [ R.text title ]
            }
        , R.div
            { className: "mt-2 w-16 h-1 bg-black"
            }
        ]
    }

addDotPerspective :: React.JSX
addDotPerspective = 
  R.div
    { className: "dot-perspective"
    }