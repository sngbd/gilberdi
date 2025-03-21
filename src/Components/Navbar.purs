module Components.Navbar (navbar, skipToContent) where
import Prelude
import Effect (Effect)
import React.Basic.DOM as R
import React.Basic.Hooks as React
import React.Basic.Events (handler_)

navbar :: String -> (String -> Effect Unit) -> Boolean -> (Boolean -> Effect Unit) -> React.JSX
navbar activeSection scrollToSection mobileMenuOpen setMobileMenuOpen =
  R.nav
    { className: "fixed w-full border-b border-black z-40 bg-white"
    , children:
        [ R.div
            { className: "container mx-auto px-4 py-2 flex justify-between items-center"
            , children:
                [ R.div
                    { className: "text-xl font-bold tracking-widest solarized-cyan"
                    , children: [ R.text "> GILBERDI" ]
                    }
                , R.div
                    { className: "hidden md:flex space-x-6"
                    , children:
                        [ navItem "HOME" "home" activeSection scrollToSection
                        , navItem "ABOUT" "about" activeSection scrollToSection
                        , navItem "EXPERIENCE" "experience" activeSection scrollToSection
                        , navItem "PROJECTS" "projects" activeSection scrollToSection
                        , navItem "SKILLS" "skills" activeSection scrollToSection
                        , navItem "CONTACT" "contact" activeSection scrollToSection
                        ]
                    }
                , R.button
                    { className: "md:hidden p-2 border border-black card-hover"
                    , onClick: handler_ (setMobileMenuOpen (not mobileMenuOpen))
                    , children: [ R.text (if mobileMenuOpen then "✕" else "☰") ]
                    }
                ]
            }
        , R.div
            { className: "mobile-menu md:hidden fixed top-0 left-0 w-full h-screen bg-white transform transition-transform duration-300 ease-in-out z-50 " 
                <> if mobileMenuOpen then "translate-y-0" else "-translate-y-full"
            , children:
                [ R.div
                    { className: "flex flex-col justify-center w-full h-full"
                    , children:
                        [ R.button
                            { className: "absolute top-4 right-4 p-2 text-2xl solarized-red hover:text-red-800 transition-colors"
                            , onClick: handler_ (setMobileMenuOpen false)
                            , children: [ R.text "✕" ]
                            }
                        , R.div
                            { className: "flex flex-col items-center space-y-6 pt-16"
                            , children:
                                [ mobileNavItem "HOME" "home" activeSection scrollToSection setMobileMenuOpen
                                , mobileNavItem "ABOUT" "about" activeSection scrollToSection setMobileMenuOpen
                                , mobileNavItem "EXPERIENCE" "experience" activeSection scrollToSection setMobileMenuOpen
                                , mobileNavItem "PROJECTS" "projects" activeSection scrollToSection setMobileMenuOpen
                                , mobileNavItem "SKILLS" "skills" activeSection scrollToSection setMobileMenuOpen
                                , mobileNavItem "CONTACT" "contact" activeSection scrollToSection setMobileMenuOpen
                                ]
                            }
                        ]
                    }
                ]
            }
        ]
    }

navItem :: String -> String -> String -> (String -> Effect Unit) -> React.JSX
navItem label id activeSection scrollToSection =
  R.a
    { className: "cursor-pointer hover:text-gray-600 transition-colors duration-200 " 
                 <> if activeSection == id then "text-black underline solarized-violet" else "text-gray-800"
    , onClick: handler_ (scrollToSection id)
    , href: "#" <> id
    , children: [ R.text (">" <> label) ]
    }

mobileNavItem :: String -> String -> String -> (String -> Effect Unit) -> (Boolean -> Effect Unit) -> React.JSX
mobileNavItem label id activeSection scrollToSection setMobileMenuOpen =
  R.a
    { className: "cursor-pointer hover:text-gray-600 transition-colors duration-200 py-4 text-lg " 
                 <> if activeSection == id then "text-black font-bold solarized-violet" else "text-gray-800"
    , onClick: handler_ do
        scrollToSection id
        setMobileMenuOpen false
    , href: "#" <> id
    , children: [ R.text (">" <> label) ]
    }

skipToContent :: React.JSX
skipToContent =
  R.a
    { className: "skip-to-content"
    , href: "#home"
    , children: [ R.text "Skip to content" ]
    }
