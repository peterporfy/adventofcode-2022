open System.IO
open System.Text.RegularExpressions

let sampleDock = [
  (1, ["N"; "Z"]);
  (2, ["D"; "C"; "M"]);
  (3, ["P"])
]

let (|Regex|_|) pattern input =
  let m = Regex.Match(input, pattern)
  if m.Success then Some(List.tail [ for g in m.Groups -> g.Value ])
  else None

let parse lines =
  let (rawStacks: string list, rawDock, rawCommands) =
    List.fold (fun (stacks, dock, commands) line ->
      match line with
      | Regex "move (\d+) from (\d+) to (\d+)" [times; source; target] -> (stacks, dock, (times |> int, source |> int, target |> int)::commands)
      | Regex "(\d+)" _ -> (stacks, line, commands)
      | Regex "([A-Z])" _ -> (line::stacks, dock, commands)
      | _ -> (stacks, dock, commands)
    ) ([], "", []) lines

  let dock =
    rawDock.Split(" ")
    |> Array.toList
    |> List.map (fun item -> item.Trim())
    |> List.filter (fun item -> item.Length > 0)
    |> List.map (fun item -> item |> int)
    |> List.map (fun stackId ->
      let pos = if stackId = 1 then 1 else 1 + ((stackId - 1) * 4)
      let stacks =
        rawStacks
        |> List.filter (fun stack -> pos < stack.Length && stack.[pos] <> ' ')
        |> List.map (fun stack -> stack.[pos])
        |> List.map string
      (stackId, List.rev stacks)
    )

  (dock, List.rev rawCommands)

let removeTop (stackId, stack) = (List.head stack, (stackId, List.tail stack))
let addTop (stackId, stack) crate = (stackId, crate::stack)

let move dock source target =
  let sourceStack = dock |> List.find (fun (stackId, stack) -> stackId = source)
  let (crate, newSource) = removeTop sourceStack
  dock |> List.map (fun (stackId, stack) ->
    match stackId with
    | id when id = source -> newSource
    | id when id = target -> addTop (id, stack) crate
    | id -> (id, stack)
  )

let rec moveTimes times source target dock =
  if times = 1 then
    move dock source target
  else
    moveTimes (times - 1) source target (move dock source target)

let move9001 num source target dock =
  let (_, sourceStack) = dock |> List.find (fun (stackId, stack) -> stackId = source)
  let (removed, remaining) = List.splitAt num sourceStack
  dock |> List.map (fun (stackId, stack) ->
    match stackId with
    | id when id = source -> (id, remaining)
    | id when id = target -> (id, removed@stack)
    | id -> (id, stack)
  )

let exec fn dock commands =
  List.fold (fun result (times, source, target) -> fn times source target result) dock commands

let topSignature dock = dock |> List.map (snd >> List.head) |> String.concat ""

let lines = File.ReadAllLines("./data") |> Array.toList
let (dock, commands) = parse lines

let result = exec moveTimes dock commands |> topSignature
let result2 = exec move9001 dock commands |> topSignature

printfn $"1: {result} 2: {result2}"
