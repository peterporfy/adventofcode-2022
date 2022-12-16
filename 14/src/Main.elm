module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, table, tr, td, th, thead, tbody)
import Html.Events exposing (onClick)
import Dict exposing (Dict)
import Array

import DataInputs exposing(testdata, data)
import Tuple exposing (first, second)


-- MAIN

main : Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL

type alias Coord = (Int, Int)
type Element = Air | Rock | Sand | Source

type alias Grid = Dict Coord Element

type alias GridBoundaries =
  {minX: Int
  ,maxX: Int
  ,minY: Int
  ,maxY: Int}

type alias Meta =
  {initialBoundaries: GridBoundaries
  ,sandsBeforeVoid: Maybe Int
  ,currentSand: Maybe Coord}

type alias Model = (Grid, Meta)

parseNum : Maybe String -> Int
parseNum maybeStr =
  case maybeStr of
    Nothing -> 0
    Just val ->
      case String.toInt (String.trim val) of
          Nothing -> 0
          Just num -> num

parseCoord : String -> Coord
parseCoord str =
  let
    values = Array.fromList (String.split "," str)
    x = parseNum (Array.get 0 values)
    y = parseNum (Array.get 1 values)
  in
    (x, y)

parsePath : String -> List Coord
parsePath str = String.split "->" str |> List.map parseCoord

interpolatePath : Coord -> List Coord -> List Coord
interpolatePath start rest =
  case List.head rest of
    Nothing -> [start]
    Just end ->
      let
        (sx, sy) = start
        (ex, ey) = end
        dx = max -1 (min 1 (ex - sx))
        dy = max -1 (min 1 (ey - sy))
      in
        if dx == 0 && dy == 0
        then start :: pathToPositions rest
        else start :: (pathToPositions ((sx + dx, sy + dy) :: rest))


pathToPositions : List Coord -> List Coord
pathToPositions path =
  case List.head path of
    Nothing -> []
    Just start ->
      case List.tail path of
        Nothing -> [start]
        Just rest -> interpolatePath start rest


addToGrid : Element -> Coord -> Grid -> Grid
addToGrid elem pos grid = Dict.insert pos elem grid

sandSource : Coord
sandSource = (500, 0)

parseToGrid : String -> Grid
parseToGrid str =
  String.split "\n" str
  |> List.filter (\line -> not (String.isEmpty line))
  |> List.map parsePath
  |> List.foldl (\path result -> result ++ pathToPositions path) []
  |> List.foldl (addToGrid Rock) (Dict.fromList [])
  |> addToGrid Source sandSource


getElement : Coord -> Grid -> Element
getElement pos grid =
  case Dict.get pos grid of
    Nothing -> Air
    Just elem -> elem

isAir : Coord -> Grid -> Bool
isAir pos grid =
  case getElement pos grid of
    Air -> True
    _ -> False

isSand : Coord -> Grid -> Bool
isSand pos grid =
  case getElement pos grid of
      Sand -> True
      _ -> False

findMaxCoord : List Coord -> (Coord -> Int) -> Int
findMaxCoord coords selector =
  case coords |> List.map selector |> List.sort |> List.reverse |> List.head of
    Nothing -> 0
    Just val -> val

findMinCoord : List Coord -> (Coord -> Int) -> Int
findMinCoord coords selector =
  case coords |> List.map selector |> List.sort |> List.head of
    Nothing -> 0
    Just val -> val

calculateGridBoundaries : Grid -> GridBoundaries
calculateGridBoundaries grid =
  let
    coords = Dict.keys grid
  in
    {
      minX = findMinCoord coords first
      ,maxX = findMaxCoord coords first
      ,minY = 0
      ,maxY = findMaxCoord coords second
    }

isWithinInitialBoundaries : Coord -> GridBoundaries -> Bool
isWithinInitialBoundaries pos boundaries =
  let
    (x, y) = pos
  in
    if x >= boundaries.minX && x <= boundaries.maxX && y >= boundaries.minY && y <= boundaries.maxY then True
    else False

isAboveFloorBoundary : Coord -> GridBoundaries -> Bool
isAboveFloorBoundary pos boundaries =
  let
      (_, y) = pos
  in
    if y <= boundaries.maxY + 1 then True
    else False

totalSandsOnScreen : Grid -> Int
totalSandsOnScreen grid =
  Dict.keys grid |> List.filter (\pos -> isSand pos grid) |> List.length

init : Model
init =
  let
    grid = parseToGrid data
  in
    (grid,
    {initialBoundaries = calculateGridBoundaries grid
    ,sandsBeforeVoid = Nothing
    ,currentSand = Nothing})

-- UPDATE

type Msg = Tick | Complete

findNextSandPosition : Coord -> Grid -> Maybe Coord
findNextSandPosition sand grid =
  let
    (x, y) = sand
    down = (x, y + 1)
    left = (x - 1, y + 1)
    right = (x + 1, y + 1)
  in
    if isAir down grid then Just(down)
    else if isAir left grid then Just(left)
    else if isAir right grid then Just(right)
    else Nothing

type TickResult = NewSand | SandMoved | SandStill | NoSpace

markSandAfterVoid : (Grid, Meta) -> (Grid, Meta)
markSandAfterVoid (grid, meta) =
  case meta.sandsBeforeVoid of
    Just _ -> (grid, meta)
    Nothing -> (grid, { meta | sandsBeforeVoid = Just ((totalSandsOnScreen grid) - 1) })

tryAddNewSand : (Grid, Meta) -> ((Grid, Meta), TickResult)
tryAddNewSand (grid, meta) =
  let
    newPos = findNextSandPosition sandSource grid
  in
    case newPos of
      Nothing -> ((addToGrid Sand sandSource grid, { meta | currentSand = Nothing}), NoSpace)
      Just pos -> ((addToGrid Sand pos grid, { meta | currentSand = Just pos}), NewSand)

simulateSandMove : Coord -> (Grid, Meta) -> ((Grid, Meta), TickResult)
simulateSandMove currentPos (grid, meta) =
    let
      newPos = findNextSandPosition currentPos grid
      moveTo pos = addToGrid Sand pos (addToGrid Air currentPos grid)
    in
      case newPos of
        Nothing -> ((grid, { meta | currentSand = Nothing }), SandStill)
        Just pos ->
          if isWithinInitialBoundaries pos meta.initialBoundaries
            then ((moveTo pos, { meta | currentSand = Just pos }), SandMoved)
          else if isAboveFloorBoundary pos meta.initialBoundaries
            then (markSandAfterVoid ((moveTo pos), { meta | currentSand = Just pos }), SandMoved)
          else
            ((grid, { meta | currentSand = Nothing }), SandStill)

tick : (Grid, Meta) -> ((Grid, Meta), TickResult)
tick (grid, meta) =
  case meta.currentSand of
    Nothing -> tryAddNewSand (grid, meta)
    Just prevPos -> simulateSandMove prevPos (grid, meta)

completeSimulation : (Grid, Meta) -> (Grid, Meta)
completeSimulation (grid, meta) =
  let
      ((newGrid, newMeta), result) = tick (grid, meta)
  in
    case result of
      NoSpace -> (newGrid, newMeta)
      _ -> completeSimulation (newGrid, newMeta)


update : Msg -> Model -> Model
update msg (grid, meta) =
  case msg of
    Tick -> first (tick (grid, meta))
    Complete -> completeSimulation (grid, meta)

-- VIEW

getElementSymbol : Element -> String
getElementSymbol elem =
  case elem of
    Air -> "."
    Rock -> "#"
    Sand -> "o"
    Source -> "+"

drawgrid : Grid -> Html Msg
drawgrid grid =
  let
    boundaries = calculateGridBoundaries grid
    columns = List.range boundaries.minX boundaries.maxX
    rows = List.range boundaries.minY boundaries.maxY
  in
    div [] [
      table [] [
        thead [] ((th [] [text ""]) :: (List.map (\_ -> th [] [text ""]) columns))
        ,tbody [] (List.map (\row ->
          tr []
            ((th [] [text (String.fromInt row)])
            ::
            (List.map (\column ->
              td [] [text (getElementSymbol (getElement (column, row) grid))])
            columns))
        ) rows)
      ]
    ]

view : Model -> Html Msg
view model =
  let
    (grid, meta) = model
    totalSands = totalSandsOnScreen grid
    sandsBeforeVoid = case meta.sandsBeforeVoid of
      Nothing -> 0
      Just sands -> sands
  in
    div []
      [ button [ onClick Tick ] [ text "Tick" ]
      , button [ onClick Complete ] [ text "Complete" ]
      , text ("Total sands: " ++ (String.fromInt totalSands))
      , text " | "
      , text ("Sands before falling to void: " ++ (String.fromInt sandsBeforeVoid))
      , drawgrid grid
      ]
