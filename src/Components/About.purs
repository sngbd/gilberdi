module Components.About (about) where
import React.Basic.DOM as R
import React.Basic.Hooks as React
import Components.Common (sectionTitle, addDotPerspective)

about :: React.JSX
about =
  R.section
    { id: "about"
    , className: "py-16 bg-white px-4 relative"
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
                            , style: R.css { boxShadow: "8px 8px 0 rgba(88,110,117,0.2)" }
                            , children:
                                [ R.div
                                    { className: "mb-2 text-gray-700 solarized-green"
                                    , children: [ R.text "> less profile.txt" ]
                                    }
                                , R.p
                                    { className: "text-black leading-relaxed"
                                    , children: [ 
                                        R.text 
                                        ("""Computer Science student with a passion for software engineering and a focus on building efficient, scalable systems.
                                            Skilled in writing clean, maintainable code and optimizing development workflows.
                                            Enthusiastic about exploring AI, Web3, and functional programming to broaden expertise in innovative technologies."""
                                        )
                                        ]
                                    }
                                ]
                            }
                        , R.div
                            { className: "bg-white p-4 md:p-6 border border-black card-hover"
                            , style: R.css { boxShadow: "8px 8px 0 rgba(88,110,117,0.2)" }
                            , children:
                                [ R.div
                                    { className: "mb-2 text-gray-700 solarized-yellow"
                                    , children: [ R.text "> cat education.csv" ]
                                    }
                                , R.h3
                                    { className: "text-xl font-bold mb-4 text-black solarized-blue"
                                    , children: [ R.text "Education" ]
                                    }
                                , educationItem 
                                    "Universitas Sumatera Utara" 
                                    "Bachelor of Science in Computer Science" 
                                    "June 2021 – Expected August 2025" 
                                    "GPA: 3.97"
                                , educationItem 
                                    "Universiti Teknologi MARA" 
                                    "Student Exchange Program" 
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
            { className: "font-bold text-black solarized-cyan"
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
              , R.span { className: "mt-1 sm:mt-0 solarized-orange", children: [ R.text gpa ] }
              ]
          }
        ]
    }