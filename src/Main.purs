module Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Console (log)
import React.Basic.DOM as R
import React.Basic.DOM.Client (createRoot, renderRoot)
import React.Basic.Hooks as React
import React.Basic.Hooks (Component, component, useState, (/\))
import React.Basic.Events (handler_)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Data.String (drop)
import Web.HTML (window)
import Web.HTML.Window (document, location, toEventTarget)
import Web.HTML.Location (hash)
import Web.Event.EventTarget (EventListener, eventListener, addEventListener, removeEventListener)
import Web.Event.Event (Event, EventType(..))

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

    React.useEffect unit do
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

skipToContent :: React.JSX
skipToContent =
  R.a
    { className: "skip-to-content"
    , href: "#home"
    , children: [ R.text "Skip to content" ]
    }

navbar :: String -> (String -> Effect Unit) -> Boolean -> (Boolean -> Effect Unit) -> React.JSX
navbar activeSection setActiveSection mobileMenuOpen setMobileMenuOpen =
  R.nav
    { className: "fixed w-full bg-white border-b border-black z-40"
    , children:
        [ R.div
            { className: "container mx-auto px-4 py-2 flex justify-between items-center"
            , children:
                [ R.div
                    { className: "text-xl font-bold tracking-widest"
                    , children: [ R.text "> GILBERDI" ]
                    }
                , R.div
                    { className: "hidden md:flex space-x-6"
                    , children:
                        [ navItem "HOME" "home" activeSection setActiveSection
                        , navItem "ABOUT" "about" activeSection setActiveSection
                        , navItem "EXPERIENCE" "experience" activeSection setActiveSection
                        , navItem "PROJECTS" "projects" activeSection setActiveSection
                        , navItem "SKILLS" "skills" activeSection setActiveSection
                        , navItem "CONTACT" "contact" activeSection setActiveSection
                        ]
                    }
                , R.button
                    { className: "md:hidden p-2 border border-black"
                    , onClick: handler_ (setMobileMenuOpen (not mobileMenuOpen))
                    , children: [ R.text (if mobileMenuOpen then "✕" else "☰") ]
                    }
                ]
            }
        , R.div
            { className: "mobile-menu md:hidden" <> if mobileMenuOpen then " open" else ""
            , children:
                [ R.div
                    { className: "flex flex-col justify-center w-full h-full"
                    , children:
                        [ R.button
                            { className: "absolute top-4 right-4 p-2 text-2xl"
                            , onClick: handler_ (setMobileMenuOpen false)
                            , children: [ R.text "✕" ]
                            }
                        , R.div
                            { className: "flex flex-col items-center space-y-6 pt-16"
                            , children:
                                [ mobileNavItem "HOME" "home" activeSection setActiveSection setMobileMenuOpen
                                , mobileNavItem "ABOUT" "about" activeSection setActiveSection setMobileMenuOpen
                                , mobileNavItem "EXPERIENCE" "experience" activeSection setActiveSection setMobileMenuOpen
                                , mobileNavItem "PROJECTS" "projects" activeSection setActiveSection setMobileMenuOpen
                                , mobileNavItem "SKILLS" "skills" activeSection setActiveSection setMobileMenuOpen
                                , mobileNavItem "CONTACT" "contact" activeSection setActiveSection setMobileMenuOpen
                                ]
                            }
                        ]
                    }
                ]
            }
        ]
    }



navItem :: String -> String -> String -> (String -> Effect Unit) -> React.JSX
navItem label id activeSection setActiveSection =
  R.a
    { className: "cursor-pointer hover:text-gray-600 transition-colors duration-200 " 
                 <> if activeSection == id then "text-black underline" else "text-gray-800"
    , onClick: handler_ (setActiveSection id)
    , href: "#" <> id
    , children: [ R.text (">" <> label) ]
    }

mobileNavItem :: String -> String -> String -> (String -> Effect Unit) -> (Boolean -> Effect Unit) -> React.JSX
mobileNavItem label id activeSection setActiveSection setMobileMenuOpen =
  R.a
    { className: "cursor-pointer hover:text-gray-600 transition-colors duration-200 py-4 text-lg " 
                 <> if activeSection == id then "text-black font-bold" else "text-gray-800"
    , onClick: handler_ do
        setActiveSection id
        setMobileMenuOpen false
    , href: "#" <> id
    , children: [ R.text (">" <> label) ]
    }

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
                                    { className: "w-3 h-3 bg-black mr-2 rounded-full"
                                    }
                                , R.div
                                    { className: "w-3 h-3 bg-black mr-2 rounded-full"
                                    }
                                , R.div
                                    { className: "w-3 h-3 bg-black mr-2 rounded-full"
                                    }
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
                                [ R.div
                                    { className: "mb-4 typewriter"
                                    , children: [ R.text "> whoami" ]
                                    }
                                , R.h1
                                    { className: "text-4xl md:text-4xl font-bold mb-4"
                                    , children: [ R.text "Gilberdi Axel Nathaniel Sinaga" ]
                                    }
                                , R.div
                                    { className: "mb-4 typewriter delay-1"
                                    , children: [ R.text "> cat skills.txt" ]
                                    }
                                , R.p
                                    { className: "text-xl text-black mb-8"
                                    , children: [ R.text "Software Engineer" ]
                                    }
                                , R.div
                                    { className: "mb-4 typewriter delay-2"
                                    , children: [ R.text "> find ./contact -type f -name \"*.link\"" ]
                                    }
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

about :: React.JSX
about =
  R.section
    { id: "about"
    , className: "py-16 px-4 bg-white relative"
    , children:
        [ R.div
            { className: "container mx-auto relative z-10"
            , children:
                [ sectionTitle "ABOUT"
                , R.div
                    { className: "grid md:grid-cols-2 gap-8 mt-8"
                    , children:
                        [ R.div
                            { className: "bg-white p-4 md:p-6 border border-black card-hover"
                            , style: R.css { boxShadow: "8px 8px 0 rgba(0,0,0,0.1)" }
                            , children:
                                [ R.div
                                    { className: "mb-2 text-gray-700"
                                    , children: [ R.text "> less profile.txt" ]
                                    }
                                , R.p
                                    { className: "text-black leading-relaxed"
                                    , children: [ 
                                        R.text 
                                        ("""Computer science student with a strong interest in software engineering.
                                            Passionate about building efficient, scalable systems and writing clean, maintainable code.
                                            Enjoys customizing his development environment to streamline workflows, exploring different problem-solving techniques for complex challenges, and staying up to date with emerging technologies.
                                            Currently pursuing a deeper understanding of AI, Web3, and functional programming to expand his perspective on software development.""")
                                        ]
                                    }
                                ]
                            }
                        , R.div
                            { className: "bg-white p-4 md:p-6 border border-black card-hover"
                            , style: R.css { boxShadow: "8px 8px 0 rgba(0,0,0,0.1)" }
                            , children:
                                [ R.div
                                    { className: "mb-2 text-gray-700"
                                    , children: [ R.text "> cat education.csv" ]
                                    }
                                , R.h3
                                    { className: "text-xl font-bold mb-4 text-black"
                                    , children: [ R.text "Education" ]
                                    }
                                , educationItem 
                                    "Universitas Sumatera Utara" 
                                    "Bachelor of Science in Computer Science" 
                                    "June 2021 – 2025" 
                                    "GPA: 3.97"
                                , educationItem 
                                    "Universiti Teknologi MARA" 
                                    "Bachelor of Science in Computer Science" 
                                    "March 2023 – August 2023" 
                                    "GPA: 3.78"
                                ]
                            }
                        ]
                    }
                ]
            }
        , addDotPerspective
        ]
    }

educationItem :: String -> String -> String -> String -> React.JSX
educationItem school degree duration gpa =
  R.div
    { className: "mb-4 last:mb-0"
    , children:
        [ R.h4
            { className: "font-bold text-black"
            , children: [ R.text school ]
            }
        , R.p
            { className: "text-gray-800"
            , children: [ R.text degree ]
            }
        , R.div
          { className: "flex flex-col sm:flex-row sm:justify-between text-sm text-gray-600 mt-1"
          , children:
              [ R.span { children: [ R.text duration ] }
              , R.span { className: "mt-1 sm:mt-0", children: [ R.text gpa ] }
              ]
          }
        ]
    }

experience :: React.JSX
experience =
  R.section
    { id: "experience"
    , className: "py-16 px-4 bg-white relative"
    , children:
        [ R.div
            { className: "container mx-auto relative z-10"
            , children:
                [ sectionTitle "EXPERIENCE"
                , R.div
                    { className: "space-y-8 mt-8"
                    , children:
                        [ experienceItem 
                            "PT Smut Tech Indonesia" 
                            "Software Engineer (Internship)" 
                            "July 2024 - October 2024"
                            [ "ERP-VAS: Created a customer and prospect map view with Leaflet library and GeoJSON data in Laravel on an Enterprise Resource Planning (ERP) application for a company. Built charts for statistics using Metronic."
                            , "SMUT SaaS: Developed frontend for a SaaS application using Next.js and Tailwind CSS."
                            , "KOMINA: Developed a mobile application using Flutter and gRPC for a fisheries cooperative. Involved in the development of some features of the ERP web application in Laravel."
                            ]
                        , experienceItem 
                            "PT Pharos Indonesia" 
                            "Back End Developer (Internship)" 
                            "February 2024 - June 2024"
                            [ "Century Marketplace: Involved in the development of REST API in Go using Cloud Firestore as the database for a pharmaceutical e-commerce application. Implemented a notification feature for the mobile application using Firebase Cloud Messaging (FCM)."
                            ]
                        , experienceItem 
                            "Azura Labs" 
                            "Back End Developer (Internship)" 
                            "August 2022 - December 2022"
                            [ "WoiShop: Built a mock-up e-commerce REST API using Express.js and PostgreSQL in a training."
                            ]
                        ]
                    }
                ]
            }
        , addDotPerspective
        ]
    }

experienceItem :: String -> String -> String -> Array String -> React.JSX
experienceItem company position duration descriptions =
  R.div
    { className: "bg-white p-4 md:p-6 border border-black relative overflow-hidden card-hover"
    , style: R.css { boxShadow: "8px 8px 0 rgba(0,0,0,0.1)" }
    , children:
        [ R.div
            { className: "absolute top-2 right-3 text-xs text-gray-500 font-mono"
            , children: [ R.text "$ history | grep work" ]
            }
        , R.h3
            { className: "text-xl font-bold mb-1 text-black mt-6 md:mt-0"
            , children: [ R.text company ]
            }
        , R.div
            { className: "text-gray-800 mb-2"
            , children: [ R.text position ]
            }
        , R.div
            { className: "text-sm text-gray-600 mb-4"
            , children: [ R.text duration ]
            }
        , R.ul
            { className: "space-y-2 text-black mb-3 md:mb-0"
            , children: map (\desc -> 
                R.li 
                  { className: "relative pl-5 before:content-['$'] before:absolute before:left-0 before:text-gray-500"
                  , children: [ R.text desc ]
                  }
              ) descriptions
            }
        ]
    }

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

skillsSection :: React.JSX
skillsSection =
  R.section
    { id: "skills"
    , className: "py-16 px-4 bg-white relative"
    , children:
        [ R.div
            { className: "container mx-auto relative z-10"
            , children:
                [ sectionTitle "SKILLS"
                , R.div
                    { className: "grid md:grid-cols-2 gap-8 mt-8"
                    , children:
                        [ skillCategory 
                            "Frameworks" 
                            [ "Express.js", "Laravel", "Flutter", "React.js", "Next.js", "Svelte", "Tailwind CSS", "Django" ]
                        , skillCategory 
                            "Programming Languages" 
                            [ "JavaScript", "TypeScript", "Dart", "Python", "Go", "PHP", "Bash" ]
                        , skillCategory 
                            "Databases" 
                            [ "PostgreSQL", "MySQL", "SQLite", "Cloud Firestore" ]
                        , skillCategory 
                            "Tools" 
                            [ "macOS", "Visual Studio Code", "Neovim", "Git", "Node.js", "Firebase" ]
                        ]
                    }
                ]
            }
        , addDotPerspective
        ]
    }

skillCategory :: String -> Array String -> React.JSX
skillCategory category skills =
  R.div
    { className: "bg-white p-4 md:p-6 border border-black card-hover"
    , style: R.css { boxShadow: "8px 8px 0 rgba(0,0,0,0.1)" }
    , children:
        [ R.div
            { className: "mb-2 text-gray-600 text-sm"
            , children: [ R.text ("$ ls -la ~/" <> category <> "/") ]
            }
        , R.h3
            { className: "text-xl font-bold mb-4 text-black"
            , children: [ R.text category ]
            }
        , R.div
            { className: "flex flex-wrap gap-2"
            , children: map (\skill -> 
                R.span 
                  { className: "text-sm bg-white text-black px-3 py-1 border border-black hover:bg-black hover:text-white transition-colors duration-200"
                  , children: [ R.text skill ]
                  }
              ) skills
            }
        ]
    }

contact :: React.JSX
contact =
  R.section
    { id: "contact"
    , className: "py-16 px-4 bg-white relative"
    , children:
        [ R.div
            { className: "container mx-auto relative z-10"
            , children:
                [ sectionTitle "CONTACT"
                , R.div
                    { className: "mt-8 max-w-xl mx-auto bg-white p-4 md:p-8 border border-black card-hover"
                    , style: R.css { boxShadow: "8px 8px 0 rgba(0,0,0,0.1)" }
                    , children:
                        [ R.div
                            { className: "mb-4 text-gray-600 text-sm"
                            , children: [ R.text "$ netstat -t" ]
                            }
                        , R.p
                            { className: "text-black text-center mb-6"
                            , children: [ R.text "Interested in working together? Feel free to contact me through any of these channels:" ]
                            }
                        , R.div
                            { className: "space-y-4"
                            , children:
                                [ contactItem "Email" "gilberdising012@gmail.com"
                                , contactItem "LinkedIn" "linkedin.com/in/gilberdi"
                                , contactItem "Telegram" "@gilberdisinaga"
                                ]
                            }
                        ]
                    }
                ]
            }
        , addDotPerspective
        ]
    }

contactItem :: String -> String -> React.JSX
contactItem label value =
  R.div
    { className: "flex flex-col sm:flex-row sm:items-center sm:justify-between p-3 bg-white border border-black"
    , children:
        [ R.span
            { className: "font-bold text-gray-600 mb-1 sm:mb-0"
            , children: [ R.text label ]
            }
        , R.span
            { className: "text-black monospace break-all"
            , children: [ R.text value ]
            }
        ]
    }

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