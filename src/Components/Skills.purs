module Components.Skills (skillsSection) where

import Prelude
import React.Basic.DOM as R
import React.Basic.Hooks as React

import Components.Common (sectionTitle, addDotPerspective)

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