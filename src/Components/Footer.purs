module Components.Footer (footer) where

import React.Basic.DOM as R
import React.Basic.Hooks as React


footer :: React.JSX
footer =
  R.footer
    { className: "py-8 px-4 bg-white border-t border-black relative"
    , children:
        [ R.div
            { className: "container mx-auto text-center relative z-10"
            , children:
                [ R.p
                    { className: "text-gray-600 text-sm"
                    , children: [ R.text "© 2025 Gilberdi Axel Nathaniel Sinaga. All rights reserved." ]
                    }
                ]
            }
        ]
    }