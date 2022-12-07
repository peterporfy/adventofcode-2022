using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

abstract class Node
{
  public List<Node> Children { get; set; } = new List<Node>();

  public int Size { get; set; }

  public string Name { get; set; } = "";

  public int TotalSize()
  {
    var total = Size;
    foreach (var c in Children)
    {
      total += c.TotalSize();
    }
    return total;
  }

  public void Visit(Action<Node> visitor)
  {
    visitor(this);
    foreach (var c in Children)
    {
      c.Visit(visitor);
    }
  }
}

class Directory : Node
{
  public Directory(string name)
  {
    Name = name;
    Size = 0;
  }

  public Directory Subdir(string name)
  {
    return Children.OfType<Directory>().First(c => c.Name == name);
  }
}

class File : Node {

  public File(int size, string name)
  {
    Size = size;
    Name = name;
  }
}

enum LineType
{
  CommandChangeDir,
  CommandList,
  OutputDir,
  OutputFile
}

struct Line
{
  public LineType Type { get; set; }

  public string Value { get; set; }
}

class Filesystem {
  public static Directory BuildFrom(List<Line> lines)
  {
    var history = new Stack<Directory>();
    var root = new Directory("/");
    Directory currentDir = root;

    foreach (var line in lines)
    {
      if (line.Type == LineType.CommandChangeDir)
      {
        if (line.Value == "..")
        {
          currentDir = history.Pop();
        }
        else if (line.Value != "/")
        {
          history.Push(currentDir);
          currentDir = currentDir.Subdir(line.Value);
        }
      }
      else if (line.Type == LineType.OutputDir)
      {
        var subdir = new Directory(line.Value);
        currentDir.Children.Add(subdir);
      }
      else if (line.Type == LineType.OutputFile)
      {
        var splitted = line.Value.Split(" ");
        var size = int.Parse(splitted[0]);
        var name = splitted[1];
        currentDir.Children.Add(new File(size, name));
      }
    }

    return root;
  }
}

class Parser
{
  public static List<Line> Parse(string path)
  {
    var list = new List<Line>();

    foreach (string line in System.IO.File.ReadLines(path))
    {
      list.Add(_parseLine(line));
    }

    return list;
  }

  private static Line _parseLine(string line)
  {
    if (line.StartsWith("$ cd")) {
      return new Line { Type = LineType.CommandChangeDir, Value = line.Split("$ cd ")[1] };
    } else if (line == "$ ls") {
      return new Line { Type = LineType.CommandList, Value = string.Empty };
    } else if (line.StartsWith("dir")) {
      return new Line { Type = LineType.OutputDir, Value = line.Split("dir ")[1] };
    } else {
      return new Line { Type = LineType.OutputFile, Value = line };
    }
  }
}

public static class Program
{
  public static void Main(string[] args) {
    var root = Filesystem.BuildFrom(Parser.Parse("data"));

    var total = 0;
    root.Visit(n => {
      if (n is Directory)
      {
        var size = n.TotalSize();
        if (size <= 100000)
        {
          total += size;
        }
      }
    });
    Console.WriteLine("1: " + total);

    var toFreeUp = 30000000 - (70000000 - root.TotalSize());
    var smallest = int.MaxValue;
    root.Visit(n => {
      if (n is Directory)
      {
        var size = n.TotalSize();
        if (size >= toFreeUp && size < smallest)
        {
          smallest = size;
        }
      }
    });
    Console.WriteLine("2: " + smallest);
  }
}
