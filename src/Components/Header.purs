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
                                [ R.div 
                                    { className: "dot-container mr-4"
                                    , children:
                                        [ R.div { className: "dot solarized-red animate-dots-pulse" }
                                        , R.div { className: "dot solarized-yellow animate-dots-pulse" }
                                        , R.div { className: "dot solarized-green animate-dots-pulse" }
                                        ]
                                    }
                                , R.div
                                    { className: "text-xs text-center flex-grow text-black"
                                    , children: [ R.text "user@portfolio:~" ]
                                    }
                                ]
                            }
                        , R.div
                            { className: "terminal-content p-4 bg-white border border-black"
                            , style: R.css { boxShadow: "8px 8px 0 rgba(88,110,117,0.2)" }
                            , children:
                                [ R.div { className: "mb-4 typewriter solarized-green", children: [ R.text "> whoami" ] }
                                , R.h1
                                    { className: "text-4xl md:text-4xl font-bold mb-4 solarized-magenta"
                                    , children: [ R.text "Gilberdi Axel Nathaniel Sinaga" ]
                                    }
                                , R.div { className: "mb-4 typewriter delay-1 solarized-yellow", children: [ R.text "> cat titles.txt" ] }
                                , R.p { className: "text-xl text-black mb-8 solarized-cyan", children: [ R.text "Software Engineer | Computer Science Student" ] }
                                , R.div { className: "mb-4 typewriter delay-2 solarized-blue", children: [ R.text "> find ./contact -type f -name \"*.link\"" ] }
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
            { className: "dot-background absolute bottom-0 left-0 w-full"
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