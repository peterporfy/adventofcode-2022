import re
import math
from collections import deque

class Valve:
  def __init__(self, id, rate, tunnels):
    self.id = id
    self.rate = rate
    self.tunnels = tunnels
    self.isOpen = False

  def open(self):
    valve = Valve(self.id, self.rate, self.tunnels)
    valve.isOpen = True
    return valve

  def __str__(self):
    return f'{self.id}({self.rate}), {self.isOpen}, {self.tunnels}'

def openValve(state, id):
  newState = state.copy()
  newState[id] = state[id].open()
  return newState

def parse(filename):
  valves = {}
  with open(filename, 'r') as file:
    lines = file.read().split('\n')
    for line in lines:
      match = re.search('Valve ([A-Z]{2}) has flow rate=([\d]+); tunnels? leads? to valves? (.*)', line)
      id = match.group(1)
      rate = int(match.group(2))
      tunnels = [s.strip() for s in match.group(3).split(',')]
      valve = Valve(id, rate, tunnels)
      valves[valve.id] = valve

    return valves

def shortest(graph, start, end):
  queue = deque([])
  tracker = {}

  queue.append(start)
  tracker[start] = 0

  while (len(queue) > 0):
    node = queue.popleft()
    targets = graph[node].tunnels

    for target in targets:
      if target in tracker:
        continue

      tracker[target] = tracker[node] + 1
      queue.append(target)

  return tracker[end]

def createPathTable(graph):
  pathTable = {}
  valves = graph.keys()
  for a in valves:
    for b in valves:
      if a != b:
        pathTable[f'{a}->{b}'] = shortest(graph, a, b)

  return pathTable

def evaluate(moveCosts, state, standing, minutes, score, restricted = set()):
  if minutes < 1:
    return score

  targets = [v for v in state.values() if not v.isOpen and v.rate > 0 and v.id != standing and not v.id in restricted]
  possibleScores = [score]

  for target in targets:
    path = f'{standing}->{target.id}'
    costToOpen = moveCosts[path] + 1
    minutesAfterOpen = minutes - costToOpen

    if minutesAfterOpen > 0:
      valveScore = score + (target.rate * minutesAfterOpen)
      opened = openValve(state, target.id)
      futureScore = evaluate(moveCosts, opened, target.id, minutesAfterOpen, valveScore, restricted)
      possibleScores.append(futureScore)

  return max(possibleScores)

def permutations(data, current = [], result = []):
  if not current and not data:
    return result

  if not data:
    result.append(current)
  else:
    permutations(data[1:], current + [data[0]], result)
    permutations(data[1:], current, result)

  return result

def evaluatePart1(pathTable, graph):
  return evaluate(pathTable, graph, 'AA', 30, 0)

def evaluatePart2(pathTable, graph):
  start = 'AA'
  valves = [v for v in graph.keys() if v != start and graph[v].rate > 0]
  halves = [p for p in permutations(valves) if len(p) > math.floor(len(valves) / 2)]

  score = 0

  for me in halves:
    elephant = [v for v in valves if v not in me]

    result1 = evaluate(pathTable, graph, start, 26, 0, set(elephant))
    result2 = evaluate(pathTable, graph, start, 26, 0, set(me))

    if (result1 + result2) > score:
      score = result1 + result2

  return score

graph = parse('data')
pathTable = createPathTable(graph)

result1 = evaluatePart1(pathTable, graph)
print(f'1: {result1}')

result2 = evaluatePart2(pathTable, graph)
print(f'2: {result2}')
