module Components.Experience (experience) where
import Prelude
import React.Basic.DOM as R
import React.Basic.Hooks as React
import Components.Common (sectionTitle, addDotPerspective)

experience :: React.JSX
experience =
  R.section
    { id: "experience"
    , className: "py-16 bg-white px-4 relative"
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
    , style: R.css { boxShadow: "8px 8px 0 rgba(88,110,117,0.2)" }
    , children:
        [ R.div
            { className: "absolute top-2 right-3 text-xs text-gray-500 font-mono solarized-green"
            , children: [ R.text "$ history | grep work" ]
            }
        , R.h3
            { className: "text-xl font-bold mb-1 text-black mt-6 md:mt-0 solarized-blue"
            , children: [ R.text company ]
            }
        , R.div
            { className: "text-gray-800 mb-2 solarized-cyan"
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
                  { className: "relative pl-5 before:content-['$'] before:absolute before:left-0 before:text-gray-500 before:solarized-violet"
                  , children: [ R.text desc ]
                  }
              ) descriptions
            }
        ]
    }
