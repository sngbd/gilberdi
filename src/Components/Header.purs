module Components.Header (header) where

import React.Basic.DOM as R
import React.Basic.Hooks as React

header :: React.JSX
header =
  R.header
    { id: "home"
    , className: "pt-24 pb-16 px-4 bg-white relative overflow-hidden"
    , children:
        [ R.div
            { className: "container mx-auto relative z-20"
            , children:
                [ R.div
                    { className: "max-w-2xl mx-auto terminal-window"
                    , children:
                        [ R.div
                            { className: "terminal-header px-4 py-2 bg-white border-b border-black flex items-center"
                            , children:
                                [ R.div { className: "w-3 h-3 bg-black mr-2 rounded-full" }
                                , R.div { className: "w-3 h-3 bg-black mr-2 rounded-full" }
                                , R.div { className: "w-3 h-3 bg-black mr-2 rounded-full" }
                                , R.div
                                    { className: "text-xs text-center flex-grow text-black"
                                    , children: [ R.text "user@portfolio:~" ]
                                    }
                                ]
                            }
                        , R.div
                            { className: "terminal-content p-4 bg-white border border-black"
                            , style: R.css { boxShadow: "8px 8px 0 rgba(0,0,0,0.1)" }
                            , children:
                                [ R.div { className: "mb-4 typewriter", children: [ R.text "> whoami" ] }
                                , R.h1
                                    { className: "text-4xl md:text-4xl font-bold mb-4"
                                    , children: [ R.text "Gilberdi Axel Nathaniel Sinaga" ]
                                    }
                                , R.div { className: "mb-4 typewriter delay-1", children: [ R.text "> cat skills.txt" ] }
                                , R.p { className: "text-xl text-black mb-8", children: [ R.text "Software Engineer" ] }
                                , R.div { className: "mb-4 typewriter delay-2", children: [ R.text "> find ./contact -type f -name \"*.link\"" ] }
                                , R.div
                                    { className: "flex flex-wrap gap-4 social-buttons"
                                    , children:
                                        [ socialButton "GitHub" "https://github.com/sngbd"
                                        , socialButton "LinkedIn" "https://linkedin.com/in/gilberdi"
                                        , socialButton "Email" "mailto:gilberdising012@gmail.com"
                                        ]
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
        , R.div
            { className: "absolute top-0 left-0 w-full h-full dot-background"
            , style: R.css
                { backgroundImage: "radial-gradient(circle, #000 1px, transparent 1px)"
                , backgroundSize: "20px 20px"
                }
            }
        ]
    }

socialButton :: String -> String -> React.JSX
socialButton label href =
  R.a
    { className: "bg-white hover:bg-black hover:text-white text-black px-4 py-2 border border-black transition-colors duration-200"
    , href
    , target: "_blank"
    , rel: "noopener noreferrer"
    , children: [ R.text label ]
    }