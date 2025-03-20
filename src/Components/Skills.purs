module Components.Skills (skillsSection) where

import Prelude
import React.Basic.DOM as R
import React.Basic.Hooks as React

import Components.Common (sectionTitle, addDotPerspective)

type Skill = 
  { name :: String
  , logo :: String
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
                            [ { name: "Express.js", logo: "/images/logos/express.svg" }
                            , { name: "Laravel", logo: "/images/logos/laravel.svg" }
                            , { name: "Flutter", logo: "/images/logos/flutter.svg" }
                            , { name: "React.js", logo: "/images/logos/react.svg" }
                            , { name: "Next.js", logo: "/images/logos/nextjs.svg" }
                            , { name: "Svelte", logo: "/images/logos/svelte.svg" }
                            , { name: "Tailwind CSS", logo: "/images/logos/tailwind.svg" }
                            , { name: "Django", logo: "/images/logos/django.svg" }
                            ]
                        , skillCategory 
                            "Programming Languages" 
                            [ { name: "JavaScript", logo: "/images/logos/javascript.svg" }
                            , { name: "TypeScript", logo: "/images/logos/typescript.svg" }
                            , { name: "Dart", logo: "/images/logos/dart.svg" }
                            , { name: "Python", logo: "/images/logos/python.svg" }
                            , { name: "Go", logo: "/images/logos/go.svg" }
                            , { name: "PHP", logo: "/images/logos/php.svg" }
                            , { name: "Bash", logo: "/images/logos/bash.svg" }
                            ]
                        , skillCategory 
                            "Databases" 
                            [ { name: "PostgreSQL", logo: "/images/logos/postgresql.svg" }
                            , { name: "MySQL", logo: "/images/logos/mysql.svg" }
                            , { name: "SQLite", logo: "/images/logos/sqlite.svg" }
                            , { name: "Cloud Firestore", logo: "/images/logos/firestore.svg" }
                            ]
                        , skillCategory 
                            "Tools" 
                            [ { name: "macOS", logo: "/images/logos/macos.svg" }
                            , { name: "Visual Studio Code", logo: "/images/logos/vscode.svg" }
                            , { name: "Neovim", logo: "/images/logos/neovim.svg" }
                            , { name: "Git", logo: "/images/logos/git.svg" }
                            , { name: "Node.js", logo: "/images/logos/nodejs.svg" }
                            , { name: "Firebase", logo: "/images/logos/firebase.svg" }
                            ]
                        ]
                    }
                ]
            }
        , addDotPerspective
        ]
    }

skillCategory :: String -> Array Skill -> React.JSX
skillCategory category skills =
  R.div
    { className: "bg-white p-4 md:p-6 border border-black card-hover"
    , style: R.css { boxShadow: "8px 8px 0 rgba(131, 148, 150, 0.2)" }
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
                  { className: "text-xs px-3 py-2 border border-black flex items-center justify-center bg-opacity-5 bg-gray-700 hover:bg-opacity-10 transition-all duration-200 transform hover:-translate-y-0.5 min-w-[100px] font-mono"
                  , children: 
                      [ R.img
                          { src: skill.logo
                          , alt: skill.name <> " logo"
                          , className: "w-5 h-5 mr-2 filter drop-shadow"
                          }
                      , R.text skill.name
                      ]
                  }
              ) skills
            }
        ]
    }