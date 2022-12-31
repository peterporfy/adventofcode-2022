#import <Foundation/Foundation.h>

NSArray * readLines(NSString *filename) {
  NSError *error;
  NSString *fileContents = [NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&error];
  NSArray *lines = [fileContents componentsSeparatedByString: @"\n"];

  return lines;
}

NSMutableArray * parsePoints(NSArray *lines) {
  NSMutableArray *points = [[NSMutableArray alloc] initWithCapacity:[lines count]];

  for (int i = 0; i < [lines count]; i++) {
    NSString *line = lines[i];
    NSArray *values = [line componentsSeparatedByString: @","];
    NSNumber *x = [NSNumber numberWithInteger:[values[0] integerValue]];
    NSNumber *y = [NSNumber numberWithInteger:[values[1] integerValue]];
    NSNumber *z = [NSNumber numberWithInteger:[values[2] integerValue]];
    NSArray *point = @[x, y, z];
    [points addObject:point];
  }

  return points;
}

NSMutableArray * createMatrix(int xmax, int ymax, int zmax) {
  NSMutableArray *matrix = [[NSMutableArray alloc] initWithCapacity:1];

  for (int x = 0; x <= xmax; x++) {
    NSMutableArray *ylist = [[NSMutableArray alloc] initWithCapacity:ymax];
    [matrix addObject:ylist];
    for (int y = 0; y <= ymax; y++) {
      NSMutableArray *zlist = [[NSMutableArray alloc] initWithCapacity:zmax];
      [ylist addObject:zlist];

      for (int z = 0; z <= zmax; z++) {
        matrix[x][y][z] = [NSNumber numberWithInteger:0];
      }
    }
  }

  return matrix;
}

void fillMatrix(NSMutableArray *matrix, NSMutableArray *points) {
  for (int i = 0; i < [points count]; i++) {
    NSMutableArray *point = [points objectAtIndex:i];
    int x = [[point objectAtIndex:0] intValue];
    int y = [[point objectAtIndex:1] intValue];
    int z = [[point objectAtIndex:2] intValue];

    matrix[x][y][z] = [NSNumber numberWithInteger:1];
  }
}

NSArray *directions = @[
  @[ @-1, @0, @0], // left
  @[ @1, @0, @0], // right
  @[ @0, @-1, @0], // up
  @[ @0, @1, @0], // down
  @[ @0, @0, @1], // back
  @[ @0, @0, @-1] // front
];

int hasCube(NSMutableArray *matrix, int x, int y, int z) {
  if (x >= 0 && [matrix count] > x) {
    NSMutableArray *row = matrix[x];
    if (y >= 0 && [row count] > y) {
      NSMutableArray *depth = row[y];
      if (z >= 0 && [depth count] > z) {
        return [depth[z] intValue];
      }
    }
  }

  return 0;
}

void part1(NSMutableArray *matrix, NSMutableArray *points) {
  int surface = 0;

  for (int i = 0; i < [points count]; i++) {
    for (int d = 0; d < [directions count]; d++) {
      int x2 = [points[i][0] intValue] + [directions[d][0] intValue];
      int y2 = [points[i][1] intValue] + [directions[d][1] intValue];
      int z2 = [points[i][2] intValue] + [directions[d][2] intValue];

      if (!hasCube(matrix, x2, y2, z2)) {
        surface++;
      }
    }
  }

  NSLog(@"Part 1 (surface): %d", surface);
}

void part2(NSMutableArray *matrix, int xmax, int ymax, int zmax) {
  NSMutableDictionary *visited = [[NSMutableDictionary alloc] init];
  NSMutableArray *queue = [[NSMutableArray alloc] initWithCapacity:1];
  [queue addObject:@[@0, @0, @0]];

  int externalSurface = 0;

  while ([queue count] > 0) {
    NSArray *point = [queue objectAtIndex:0];
    [queue removeObjectAtIndex:0];
    int x = [point[0] intValue];
    int y = [point[1] intValue];
    int z = [point[2] intValue];

    NSString *key = [NSString stringWithFormat:@"%d_%d_%d", x, y, z];

    if (visited[key] == nil) {
      for (int d = 0; d < [directions count]; d++) {
        int x2 = x + [directions[d][0] intValue];
        int y2 = y + [directions[d][1] intValue];
        int z2 = z + [directions[d][2] intValue];

        // allow moving 1 extra unit every direction to simulate flowing
        if (x2 >= -1 && x2 <= xmax + 1 && y2 >= -1 && y <= ymax + 1 && z >= -1 && z <= zmax + 1) {
          if (hasCube(matrix, x2, y2, z2)) {
            externalSurface++;
          } else {
            NSArray *next = @[[NSNumber numberWithInt:x2], [NSNumber numberWithInt:y2], [NSNumber numberWithInt:z2]];
            [queue addObject:next];
          }
        }
      }
      [visited setObject:@1 forKey:key];
    }
  }

  NSLog(@"Part 2 (external surface): %d", externalSurface);
}

int main(int argc, const char * argv[]) {
  NSArray *lines = readLines(@"data");

  NSMutableArray *points = parsePoints(lines);

  int xmax = 0;
  int ymax = 0;
  int zmax = 0;

  for (int i = 0; i < [points count]; i++) {
    xmax = MAX(xmax, [points[i][0] intValue]);
    ymax = MAX(ymax, [points[i][1] intValue]);
    zmax = MAX(zmax, [points[i][2] intValue]);
  }

  NSMutableArray *matrix = createMatrix(xmax, ymax, zmax);
  fillMatrix(matrix, points);

  part1(matrix, points);
  part2(matrix, xmax, ymax, zmax);

  return 0;
}
