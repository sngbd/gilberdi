module Components.Projects (projects) where

import Prelude
import React.Basic.DOM as R
import React.Basic.Hooks as React

import Components.Common (sectionTitle, addDotPerspective)

projects :: React.JSX
projects =
  R.section
    { id: "projects"
    , className: "py-16 px-4 bg-white relative"
    , children:
        [ R.div
            { className: "container mx-auto relative z-10"
            , children:
                [ sectionTitle "PROJECTS"
                , R.div
                    { className: "grid md:grid-cols-2 gap-8 mt-8"
                    , children:
                        [ projectItem 
                            "Gilberdi's Portfolio" 
                            "This website."
                            [ "PureScript", "Tailwind CSS" ]
                            "https://github.com/sngbd/gilberdi"
                        , projectItem 
                            "Decodream" 
                            "IC-blockchain-based platform that transforms dreams into digital art using AI technology."
                            [ "React.js", "Motoko", "Sass" ]
                            "https://github.com/sngbd/decodream"
                        , projectItem 
                            "Mona Coffee" 
                            "Android application for a coffee shop with focus on variety of service types."
                            [ "Flutter", "Firebase" ]
                            "https://github.com/sngbd/mona-coffee"
                        , projectItem 
                            "Last Boxd" 
                            "Generate a collage based on Letterboxd user's latest diary."
                            [ "Go", "Svelte" ]
                            "https://github.com/sngbd/last-boxd"
                        ]
                    }
                ]
            }
        , addDotPerspective
        ]
    }

projectItem :: String -> String -> Array String -> String -> React.JSX
projectItem title description technologies githubUrl =
  R.a
    { href: githubUrl
    , target: "_blank"
    , rel: "noopener noreferrer"
    , className: "block bg-white p-4 md:p-6 border border-black transition-transform duration-200 hover:-translate-y-1 hover:shadow-lg card-hover"
    , style: R.css { boxShadow: "8px 8px 0 rgba(0,0,0,0.1)" }
    , children:
        [ R.div
            { className: "mb-2 text-gray-600 text-sm"
            , children: [ R.text "$ ./projects/run" ]
            }
        , R.h3
            { className: "text-xl font-bold mb-2"
            , children: [ R.text title ]
            }
        , R.p
            { className: "mb-4"
            , children: [ R.text description ]
            }
        , R.div
            { className: "flex flex-wrap gap-2"
            , children: map (\tech -> 
                R.span 
                  { className: "text-xs bg-white text-black px-2 py-1 border border-black transition-colors duration-200"
                  , children: [ R.text tech ]
                  }
              ) technologies
            }
        , R.div
            { className: "mt-4 text-sm text-gray-600 flex items-center"
            , children: 
                [ R.text "View on GitHub "
                , R.span 
                    { className: "ml-1"
                    , children: [ R.text "→" ]
                    }
                ]
            }
        ]
    }
