
function load_table(file)
  local lines = {}
  for line in io.lines(file) do
    local row = {}
    for letter in line:gmatch('.') do
      table.insert(row, letter)
    end
    lines[#lines + 1] = row
  end
  return lines
end

function node_id(x, y, char)
  return char .. '_' .. x .. '_' .. y;
end

function char_of(node)
  if node == 'S' then
    return 'a'
  elseif node == 'E' then
    return 'z'
  else
    return node
  end
end

function elevation_of_char(char)
  return string.byte(char)
end

function can_move(from, to)
  local source_score = elevation_of_char(from)
  local target_score = elevation_of_char(to)

  return math.abs(source_score - target_score) <= 1 or target_score < source_score
end

function get_possible_neighbors(x, y)
  return {{ x - 1, y }, { x, y - 1 }, { x + 1, y }, { x, y + 1 } }
end

function try_find_valid_neighbor(source, x, y, grid)
  local row = grid[y]
  if row then
    local target = char_of(row[x])
    if target and can_move(source, target) then
      return node_id(x, y, target)
    end
  end

  return nil
end

function get_node_connections(char, x, y, grid)
  local connections = {}

  for k, possible in pairs(get_possible_neighbors(x, y)) do
    local connection = try_find_valid_neighbor(char, possible[1], possible[2], grid)

    if connection then
      table.insert(connections, connection)
    end
  end

  return connections
end

function build_graph(grid, startselector)
  local graph = {}
  local startnode_ids = {}
  local endnode_id

  for y = 1,#grid do
    local row = grid[y]
    for x = 1,#row do
      local node = grid[y][x]
      local node_char = char_of(node)
      local id = node_id(x, y, node_char)

      if startselector(node) then
        table.insert(startnode_ids, id)
      elseif node == 'E' then
        endnode_id = id
      end

      graph[id] = get_node_connections(node_char, x, y, grid)
    end
  end

  local result = {}
  result.graph = graph
  result.startnode_ids = startnode_ids
  result.endnode_id = endnode_id

  return result
end

function find_path(graph, startnode, endnode)
  local queue = {}
  local tracker = {}
  table.insert(queue, startnode)
  tracker[startnode] = 0

  while (#queue > 0) do
    local node = table.remove(queue, 1)
    local targets = graph[node]

    if targets then
      for i = 1,#targets do
        local connection = targets[i]
        if not tracker[connection] then
          tracker[connection] = tracker[node] + 1
          table.insert(queue, connection)
        end
      end
    end
  end

  return tracker[endnode]
end

function evaluate(grid, startselector)
  local query = build_graph(grid, startselector)
  local result = {}

  for k,startid in pairs(query.startnode_ids) do
    local path = find_path(query.graph, startid, query.endnode_id)
    table.insert(result, path)
  end

  table.sort(result, function (a, b) return a < b end)

  return result[1]
end

function part1_selector(node)
  return node == 'S'
end

function part2_selector(node)
  return node == 'S' or node == 'a'
end

local grid = load_table('data')
print('1: ' .. evaluate(grid, part1_selector))
print('2: ' .. evaluate(grid, part2_selector))
