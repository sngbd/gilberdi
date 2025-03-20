module Components.Contact (contact) where
import React.Basic.DOM as R
import React.Basic.Hooks as React
import Components.Common (sectionTitle, addDotPerspective)

contact :: React.JSX
contact =
  R.section
    { id: "contact"
    , className: "py-16 bg-white px-4 relative"
    , children:
        [ R.div
            { className: "container mx-auto relative z-10"
            , children:
                [ sectionTitle "CONTACT"
                , R.div
                    { className: "mt-8 max-w-xl mx-auto bg-white p-4 md:p-8 border border-black card-hover"
                    , style: R.css { boxShadow: "8px 8px 0 rgba(88,110,117,0.2)" }
                    , children:
                        [ R.div
                            { className: "mb-4 text-gray-600 text-sm solarized-yellow"
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
            { className: "font-bold text-gray-600 mb-1 sm:mb-0 solarized-blue"
            , children: [ R.text label ]
            }
        , R.span
            { className: "text-black monospace break-all solarized-cyan"
            , children: [ R.text value ]
            }
        ]
    }
