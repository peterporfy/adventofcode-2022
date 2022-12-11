import java.io.IOException;
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
  Integer calculate(Integer old);
}

class NoOperation implements Operation {
  @Override
  public Integer calculate(Integer old) {
    return old;
  }
}

class MultiplyWithNumberOperation implements Operation {
  Integer multiplyWith;

  public MultiplyWithNumberOperation(Integer multiplyWith) {
    this.multiplyWith = multiplyWith;
  }

  @Override
  public Integer calculate(Integer old) {
    return old * multiplyWith;
  }
}

class AddNumberOperation implements Operation {
  Integer addNumber;

  public AddNumberOperation(Integer addNumber) {
    this.addNumber = addNumber;
  }

  @Override
  public Integer calculate(Integer old) {
    return old + addNumber;
  }
}

class MultiplyBySelfOperation implements Operation {

  @Override
  public Integer calculate(Integer old) {
    return old * old;
  }
}

class Monkey {
  Integer id;

  ArrayList<Integer> items;

  Operation operation;

  Integer testDivision;

  Integer trueTarget;

  Integer falseTarget;


  @Override
  public String toString() {
    return "Monkey:" + id + ":" + items;
  }
}

class Parser {
  ArrayList<Token> tokens;

  public Parser(ArrayList<Token> tokens) {
    this.tokens = tokens;
  }

  private Integer parseNextInteger(Iterator<Token> iterator) {
    Integer value = 0;

    while (iterator.hasNext()) {
      Token next = iterator.next();

      if (next.type == TokenType.Number) value = Integer.parseInt(next.value);

      if (next.type == TokenType.NewLine) break;
    }

    return value;
  }

  private ArrayList<Integer> parseNextIntegerList(Iterator<Token> iterator) {
    ArrayList<Integer> values = new ArrayList<Integer>();

    while(iterator.hasNext()) {
      Token next = iterator.next();

      if (next.type == TokenType.Number) values.add(Integer.parseInt(next.value));

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
          if (operator == "*") {
            operation = new MultiplyWithNumberOperation(Integer.parseInt(next.value));
          } else if (operator == "+") {
            operation = new AddNumberOperation(Integer.parseInt(next.value));
          }
        }
      }

      if (next.type == TokenType.NewLine) break;
    }

    return operation;
  }

  private Monkey parseMonkey(Iterator<Token> iterator) {
    Monkey monkey = new Monkey();

    monkey.id = parseNextInteger(iterator);
    monkey.items = parseNextIntegerList(iterator);
    monkey.operation = parseOperation(iterator);
    monkey.testDivision = parseNextInteger(iterator);
    monkey.trueTarget = parseNextInteger(iterator);
    monkey.falseTarget = parseNextInteger(iterator);

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

class App {
  public static void main(String[] args) {
      try {
        String content = Files.readString(Path.of("testdata"));
        Tokenizer tokenizer = new Tokenizer(content);
        ArrayList<Token> tokens = tokenizer.tokenize();
        Parser parser = new Parser(tokens);

        ArrayList<Monkey> monkeys = parser.parse();
        for (Monkey monkey : monkeys) {
          System.out.println(monkey);
        }
        // System.out.println(monkeys.size());
        // for (Token token : tokens) {
        //   System.out.println(token);
        // }

      } catch (IOException e) {
        e.printStackTrace();
      }
  }
}
