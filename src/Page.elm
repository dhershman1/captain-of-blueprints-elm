module Page exposing (..)

import Browser exposing (Document)
import Html exposing (Html, a, button, div, footer, i, img, li, nav, p, span, text, ul)
import Html.Attributes exposing (class, classList, href, style)
import Html.Events exposing (onClick)
import Username exposing (Username)


{-| Determines which navbar link (if any) will be rendered as active.

Note that we don't enumerate every page here, because the navbar doesn't
have links for every page. Anything that's not part of the navbar falls
under Other.

-}
type Page
    = Other
    | Home
    | Login
    | Register
    | Settings
    | Profile Username
    | NewBlueprint
    | Blueprint


{-| Take a page's Html and frames it with a header and footer.

The caller provides the current user, so we can display in either
"signed in" (rendering username) or "signed out" mode.

isLoading is for determining whether we should show a loading spinner
in the header. (This comes up during slow page transitions.)

-}
view : Maybe Viewer -> Page -> { title : String, content : Html msg } -> Document msg
view maybeViewer page { title, content } =
    { title = title ++ " - Conduit"
    , body = viewHeader page maybeViewer :: content :: [ viewFooter ]
    }


isActive : Page -> Route -> Bool
isActive page route =
    case ( page, route ) of
        ( Home, Route.Home ) ->
            True

        ( Libraries, Route.Libraries ) ->
            True

        ( Articles, Route.Articles ) ->
            True

        _ ->
            False


navbarLink : Page -> Route -> List (Html msg) -> Html msg
navbarLink page route linkContent =
    li [ class "navbar__item" ]
        [ a [ classList [ ( "navbar__link", True ), ( "navbar__link--active", isActive page route ) ], Route.href route ] linkContent ]


viewHeader : Page -> Html msg
viewHeader page =
    nav [ class "navbar" ]
        [ div [ class "navbar__container" ]
            [ a [ class "navbar__brand", Route.href Route.Home ]
                [ text "Dusty Codes" ]
            , ul [ class "navbar__nav" ] <|
                navbarLink page Route.Home [ text "Home" ]
                    :: viewMenu page
            ]
        ]


viewMenu : Page -> List (Html msg)
viewMenu page =
    let
        linkTo =
            navbarLink page
    in
    [ linkTo Route.Libraries [ text "Libraries/Plugins" ]
    , linkTo Route.Articles [ text "Articles" ]
    ]


viewFooter : Html msg
viewFooter =
    footer []
        [ p [] [ text "Copyright 2019 Dustin Hershman" ] ]
