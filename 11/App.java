import java.io.IOException;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.regex.Pattern;

enum TokenType {
  Begin,
  Unknown,
  Text,
  Whitespace,
  Number,
  Colon,
  Comma,
  Equality,
  Operator,
  NewLine
}

class Token {
  TokenType type;

  String value;

  public Token(TokenType type, String value) {
    this.type = type;
    this.value = value;
  }

  @Override
  public String toString() {
    return type + " -> '" + value + "'";
  }
}

class TokenTypeMatcher {
  TokenType type;

  Pattern pattern;

  public TokenTypeMatcher(TokenType type, String pattern) {
    this.type = type;
    this.pattern = Pattern.compile(pattern);
  }

  public Boolean match(String character) {
    return pattern.matcher(character).find();
  }
}

class Tokenizer {
  String text;

  public Tokenizer(String text) {
    this.text = text;
  }

  TokenTypeMatcher[] matchers = new TokenTypeMatcher[] {
    new TokenTypeMatcher(TokenType.Text, "[a-zA-Z]"),
    new TokenTypeMatcher(TokenType.Whitespace, "[\s\t]"),
    new TokenTypeMatcher(TokenType.Number, "[0-9]"),
    new TokenTypeMatcher(TokenType.Comma, ","),
    new TokenTypeMatcher(TokenType.Equality, "="),
    new TokenTypeMatcher(TokenType.Colon, ":"),
    new TokenTypeMatcher(TokenType.Operator, "[+*]"),
    new TokenTypeMatcher(TokenType.NewLine, "\n")
  };

  private TokenType getTokenType(String character) {
    for (TokenTypeMatcher matcher : matchers) {
      if (matcher.match(character)) {
        return matcher.type;
      }
    }

    return TokenType.Unknown;
  }

  public ArrayList<Token> tokenize() {
    ArrayList<Token> tokens = new ArrayList<Token>();

    String[] chars = text.split("");

    TokenType currentTokenType = TokenType.Begin;
    String currentToken = "";

    for (String c : chars) {
      TokenType nextType = getTokenType(c);

      if (currentTokenType != nextType && currentTokenType != TokenType.Begin) {
        tokens.add(new Token(currentTokenType, currentToken));
        currentToken = "";
      }

      currentTokenType = nextType;
      currentToken += c;
    }

    tokens.add(new Token(currentTokenType, currentToken));

    return tokens;
  }
}

interface Operation {
  BigInteger calculate(BigInteger old);
}

class NoOperation implements Operation {

  @Override
  public BigInteger calculate(BigInteger old) {
    return old;
  }
}

class MultiplyWithNumberOperation implements Operation {
  BigInteger multiplyWith;

  public MultiplyWithNumberOperation(BigInteger multiplyWith) {
    this.multiplyWith = multiplyWith;
  }

  @Override
  public BigInteger calculate(BigInteger old) {
    return old.multiply(multiplyWith);
  }
}

class AddNumberOperation implements Operation {
  BigInteger addNumber;

  public AddNumberOperation(BigInteger addNumber) {
    this.addNumber = addNumber;
  }

  @Override
  public BigInteger calculate(BigInteger old) {
    return old.add(addNumber);
  }
}

class MultiplyBySelfOperation implements Operation {

  @Override
  public BigInteger calculate(BigInteger old) {
    return old.multiply(old);
  }
}

class Monkey {
  Integer id;

  ArrayList<BigInteger> items;

  Operation operation;

  BigInteger testDivision;

  Integer trueTarget;

  Integer falseTarget;

  Integer itemsInspected = 0;

  @Override
  public String toString() {
    return "Monkey:" + id + ":" + items + " inspections: " + itemsInspected;
  }
}

class Parser {
  ArrayList<Token> tokens;

  public Parser(ArrayList<Token> tokens) {
    this.tokens = tokens;
  }

  private Integer parseNextNumber(Iterator<Token> iterator) {
    Integer value = 0;

    while (iterator.hasNext()) {
      Token next = iterator.next();

      if (next.type == TokenType.Number) value = Integer.parseInt(next.value);

      if (next.type == TokenType.NewLine) break;
    }

    return value;
  }

  private ArrayList<BigInteger> parseNextNumberList(Iterator<Token> iterator) {
    ArrayList<BigInteger> values = new ArrayList<BigInteger>();

    while(iterator.hasNext()) {
      Token next = iterator.next();

      if (next.type == TokenType.Number) values.add(new BigInteger(next.value));

      if (next.type == TokenType.NewLine) break;
    }

    return values;
  }

  private Operation parseOperation(Iterator<Token> iterator) {
    Operation operation = new NoOperation();
    String operator = "";

    while(iterator.hasNext()) {
      Token next = iterator.next();

      if (next.type == TokenType.Operator) operator = next.value;
      if (!operator.isEmpty()) {
        if (next.type == TokenType.Text && next.value.equals("old")) {
          operation = new MultiplyBySelfOperation();
        } else if (next.type == TokenType.Number) {
          if (operator.equals("*")) {
            operation = new MultiplyWithNumberOperation(new BigInteger(next.value));
          } else if (operator.equals("+")) {
            operation = new AddNumberOperation(new BigInteger(next.value));
          }
        }
      }

      if (next.type == TokenType.NewLine) break;
    }

    return operation;
  }

  private Monkey parseMonkey(Iterator<Token> iterator) {
    Monkey monkey = new Monkey();

    monkey.id = parseNextNumber(iterator);
    monkey.items = parseNextNumberList(iterator);
    monkey.operation = parseOperation(iterator);
    monkey.testDivision = new BigInteger(parseNextNumber(iterator).toString());
    monkey.trueTarget = parseNextNumber(iterator);
    monkey.falseTarget = parseNextNumber(iterator);

    return monkey;
  }

  public ArrayList<Monkey> parse() {
    ArrayList<Monkey> monkeys = new ArrayList<Monkey>();
    Iterator<Token> iterator = tokens.iterator();

    while (iterator.hasNext()) {
      Token next = iterator.next();

      if (next.type == TokenType.Text && next.value.equals("Monkey")) {
        monkeys.add(parseMonkey(iterator));
      }
    }

    return monkeys;
  }
}

interface ReliefCalculator {
  BigInteger calculate(BigInteger value);
}

class Part1ReliefCalculator implements ReliefCalculator {
  @Override
  public BigInteger calculate(BigInteger value) {
    return value.divide(new BigInteger("3"));
  }
}

class Part2ReliefCalculator implements ReliefCalculator {
  @Override
  public BigInteger calculate(BigInteger value) {
    return value; // no relief
  }
}

class Simulation {
  ArrayList<Monkey> monkeys;

  Integer rounds;

  ReliefCalculator relief;

  public Simulation(ArrayList<Monkey> monkeys, Integer rounds, ReliefCalculator relief) {
    this.monkeys = monkeys;
    this.rounds = rounds;
    this.relief = relief;
  }

  public void execute() {
    for (Integer round = 0; round < rounds; round++) {
      System.out.println("Round " + round);
      round();
    }
  }

  public Integer levelOfMonkeyBusiness() {
    Integer top1 = 0;
    Integer top2 = 0;

    for (Monkey monkey : monkeys) {
      if (monkey.itemsInspected > top1) {
        top2 = top1;
        top1 = monkey.itemsInspected;
      } else if (monkey.itemsInspected > top2) {
        top2 = monkey.itemsInspected;
      }
    }

    return top1 * top2;
  }

  private void round() {
    for (Monkey monkey : monkeys) {
      turn(monkey);
    }
  }

  private void turn(Monkey monkey) {
    while (monkey.items.size() > 0) {
      BigInteger item = monkey.items.remove(0);
      BigInteger newItem = relief.calculate(monkey.operation.calculate(item));
      if (isDivisible(newItem, monkey.testDivision)) {
        passItemTo(monkey.trueTarget, newItem);
      } else {
        passItemTo(monkey.falseTarget, newItem);
      }

      monkey.itemsInspected++;
    }
  }

  /**
   * Assuming all divisible by numbers in data are in the range of the following primes
   * - 2
   * - 3
   * - 5
   * - 7
   * - 11
   * - 13
   * - 17
   * - 19
   * - 23
   */
  private Boolean isDivisible(BigInteger a, BigInteger b) {
    // if (b.equals(new BigInteger("2"))) {
    //   System.out.println("2");
    //   return a.getLowestSetBit() != 0;
    // } else if (b.equals(new BigInteger("3"))) {
    //   System.out.println("3");
    //   String val = a.toString();
    //   Integer sum = 0;
    //   for (Character c : val.toCharArray()) {
    //     sum += Integer.parseInt(c.toString());
    //   }

    //   return sum % 3 == 0;
    // } else if (b.equals(new BigInteger("5"))) {
    //   System.out.println("5");
    //   String val = a.toString();
    //   Integer last = Integer.parseInt(val.substring(val.length() - 1));
    //   return last % 5 == 0;
    // }

    BigInteger result = a.remainder(b);
    return result.equals(new BigInteger("0"));
  }

  private void passItemTo(Integer monkeyId, BigInteger item) {
    for (Monkey target : monkeys) {
      if (target.id == monkeyId) {
        target.items.add(item);
        break;
      }
    }
  }
}

class App {
  private static void Part1(Parser parser) {
    ArrayList<Monkey> monkeys = parser.parse();
    Simulation sim = new Simulation(monkeys, 20, new Part1ReliefCalculator());

    sim.execute();

    System.out.println("1: " + sim.levelOfMonkeyBusiness());

    DumpMonkeys(monkeys);
  }

  private static void Part2(Parser parser) {
    ArrayList<Monkey> monkeys = parser.parse();
    Simulation sim = new Simulation(monkeys, 10000, new Part2ReliefCalculator());

    sim.execute();

    System.out.println("2: " + sim.levelOfMonkeyBusiness());

    DumpMonkeys(monkeys);
  }

  private static void DumpMonkeys(ArrayList<Monkey> monkeys) {
    for (Monkey monkey : monkeys) {
      System.out.println(monkey);
    }
  }

  public static void main(String[] args) {
      try {
        String content = Files.readString(Path.of("data"));
        Tokenizer tokenizer = new Tokenizer(content);
        ArrayList<Token> tokens = tokenizer.tokenize();
        Parser parser = new Parser(tokens);

        Part1(parser);
        // Part2(parser);
      } catch (IOException e) {
        e.printStackTrace();
      }
  }
}
