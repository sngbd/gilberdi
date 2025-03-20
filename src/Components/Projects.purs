module Components.Projects (projects) where

import Prelude
import Data.Maybe (Maybe(..))
import React.Basic.DOM as R
import React.Basic.Hooks as React

import Components.Common (sectionTitle, addDotPerspective)

type Technology = 
  { name :: String
  , logo :: String
  }

getTechLogo :: String -> String
getTechLogo tech = case tech of
  "PureScript" -> "/images/logos/purescript.svg"
  "Tailwind CSS" -> "/images/logos/tailwind.svg"
  "React.js" -> "/images/logos/react.svg"
  "Motoko" -> "/images/logos/icp.svg"
  "Sass" -> "/images/logos/sass.svg"
  "Flutter" -> "/images/logos/flutter.svg"
  "Firebase" -> "/images/logos/firebase.svg"
  "Go" -> "/images/logos/go.svg"
  "Svelte" -> "/images/logos/svelte.svg"
  _ -> "/images/logos/code.svg"

techsWithLogos :: Array String -> Array Technology
techsWithLogos = map (\name -> { name, logo: getTechLogo name })

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
                            (techsWithLogos [ "PureScript", "Tailwind CSS" ])
                            "https://github.com/sngbd/gilberdi"
                            (Just "https://gilberdi.vercel.app")
                            "/images/projects/gilberdi-portfolio.png"
                        , projectItem 
                            "Decodream" 
                            "IC-blockchain-based platform that analyzes and transforms dreams into digital art using AI technology."
                            (techsWithLogos [ "React.js", "Motoko", "Sass" ])
                            "https://github.com/sngbd/decodream"
                            Nothing
                            "/images/projects/decodream.png"
                        , projectItem 
                            "Mona Coffee" 
                            "Android application for a coffee shop with focus on variety of service types."
                            (techsWithLogos [ "Flutter", "Firebase" ])
                            "https://github.com/sngbd/mona-coffee"
                            Nothing
                            "/images/projects/mona-coffee.png"
                        , projectItem 
                            "Last Boxd" 
                            "Generate a collage based on Letterboxd user's latest diary."
                            (techsWithLogos [ "Go", "Svelte" ])
                            "https://github.com/sngbd/last-boxd"
                            (Just "https://last-boxd.vercel.app")
                            "/images/projects/last-boxd.png"
                        ]
                    }
                ]
            }
        , addDotPerspective
        ]
    }

projectItem :: String -> String -> Array Technology -> String -> Maybe String -> String -> React.JSX
projectItem title description technologies githubUrl websiteUrl imageSrc =
  R.div
    { className: "block bg-white p-4 md:p-6 border border-black card-hover"
    , style: R.css { boxShadow: "8px 8px 0 rgba(38, 139, 210, 0.2)" }
    , children:
        [ R.div
            { className: "mb-2 text-gray-600 text-sm"
            , children: [ R.text "$ ./projects/run" ]
            }
        , R.div
            { className: "project-image"
            , children: 
                [ R.img
                    { src: imageSrc
                    , alt: title <> " project screenshot"
                    , className: "transition-transform duration-300 hover:scale-105"
                    }
                ]
            }
        , R.h3
            { className: "text-black text-xl font-bold mb-2"
            , children: [ R.text title ]
            }
        , R.p
            { className: "text-black mb-4"
            , children: [ R.text description ]
            }
        , R.div
            { className: "flex flex-wrap gap-3 mb-4"
            , children: map (\tech -> 
                R.span 
                  { className: "text-xs px-3 py-2 border border-black flex items-center justify-center bg-opacity-5 bg-gray-700 hover:bg-opacity-10 transition-all duration-200 transform hover:-translate-y-0.5 min-w-[100px] font-mono"
                  , children: 
                      [ R.img
                          { src: tech.logo
                          , alt: tech.name <> " logo"
                          , className: "w-5 h-5 mr-2 filter drop-shadow"
                          }
                      , R.text tech.name
                      ]
                  }
              ) technologies
            }
        , R.div
            { className: "mt-4 flex gap-4 items-center"
            , children: 
                [ R.a
                    { href: githubUrl
                    , target: "_blank"
                    , rel: "noopener noreferrer"
                    , className: "text-sm text-gray-600 flex items-center hover:text-solarized-blue hover:underline transition-all duration-300 link-glow-blue"
                    , children: 
                        [ R.text "View on GitHub "
                        , R.span 
                            { className: "ml-1"
                            , children: [ R.text "→" ]
                            }
                        ]
                    }
                , case websiteUrl of
                    Just url ->
                      R.a
                        { href: url
                        , target: "_blank"
                        , rel: "noopener noreferrer"
                        , className: "text-sm text-gray-600 flex items-center hover:text-solarized-green hover:underline transition-all duration-300 link-glow-green"
                        , children: 
                            [ R.text "Visit Website "
                            , R.span 
                                { className: "ml-1"
                                , children: [ R.text "↗" ]
                                }
                            ]
                        }
                    Nothing ->
                      R.text ""
                ]
            }
        ]
    }