module Blueprint.Tag exposing (Tag, list, toString)

import Api.Endpoint as Endpoint
import Http
import Json.Decode as Decode exposing (Decoder)



-- TYPES


type Tag
    = Tag String



-- TRANSFORM


toString : Tag -> String
toString (Tag slug) =
    slug



-- LIST


list : Cmd (List Tag)
list =
    Decode.field "tags" (Decode.list decoder)
        |> Api.get Endpoint.tags Nothing



-- SERIALIZATION


decoder : Decoder Tag
decoder =
    Decode.map Tag Decode.string
