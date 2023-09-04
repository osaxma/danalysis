# danalysis
nothing fancy here -- just a repo to explore dart analysis _(aka danalysis for the lack of creativity)_. 

My main goal of this repo is to keep track of any code I write related to dart analysis _because I usually forget how I did it._

----

## Print AST 

Check [examples/print_ast.dart](examples/print_ast.dart) to print an AST in a tree structure:

- sample code:
    ```dart
    void main() {
        print('starting the program');
        // explicit type 
        final int a = 10;
        // implicit type
        final b = 20;
        
        final c = a * b * d;

        print('c = $c');
    }
    ```
- `dart run examples/print_ast.dart` output: 
    ```
    Compilation Unit
        └╌Function Declaration
            ╎╌Named Type
            └╌Function Expression
                ╎╌Formal Parameter List
                └╌Block Function Body
                        └╌Block
                            ╎╌Expression Statement
                            ┊     └╌Method Invocation
                            ┊          ╎╌Simple Identifier
                            ┊          └╌Argument List
                            ┊               └╌Simple String Literal
                            ╎╌Variable Declaration Statement
                            ┊     └╌Variable Declaration List
                            ┊          ╎╌Named Type
                            ┊          └╌Variable Declaration
                            ┊               └╌Integer Literal
                            ╎╌Variable Declaration Statement
                            ┊     └╌Variable Declaration List
                            ┊          └╌Variable Declaration
                            ┊               └╌Integer Literal
                            ╎╌Variable Declaration Statement
                            ┊     └╌Variable Declaration List
                            ┊          └╌Variable Declaration
                            ┊               └╌Binary Expression
                            ┊                    ╎╌Binary Expression
                            ┊                    ┊     ╎╌Simple Identifier
                            ┊                    ┊     └╌Simple Identifier
                            ┊                    └╌Simple Identifier
                            └╌Expression Statement
                                └╌Method Invocation
                                    ╎╌Simple Identifier
                                    └╌Argument List
                                            └╌String Interpolation
                                                ╎╌Interpolation String
                                                ╎╌Interpolation Expression
                                                ┊     └╌Simple Identifier
                                                └╌Interpolation String
    ```

## Print Tokens

For the same sample code given in [Print AST](#print-ast) above:

- `dart run examples/print_tokens.dart` will print:
    ```
    token type                      | token                 
    ========================================================
    VOID                            | void                  
    IDENTIFIER                      | main                  
    OPEN_PAREN                      | (                     
    CLOSE_PAREN                     | )                     
    OPEN_CURLY_BRACKET              | {                     
    IDENTIFIER                      | print                 
    OPEN_PAREN                      | (                     
    STRING                          | 'starting the program'
    CLOSE_PAREN                     | )                     
    SEMICOLON                       | ;                     
    FINAL                           | final                 
    IDENTIFIER                      | int                   
    IDENTIFIER                      | a                     
    EQ                              | =                     
    INT                             | 10                    
    SEMICOLON                       | ;                     
    FINAL                           | final                 
    IDENTIFIER                      | b                     
    EQ                              | =                     
    INT                             | 20                    
    SEMICOLON                       | ;                     
    FINAL                           | final                 
    IDENTIFIER                      | c                     
    EQ                              | =                     
    IDENTIFIER                      | a                     
    STAR                            | *                     
    IDENTIFIER                      | b                     
    STAR                            | *                     
    IDENTIFIER                      | d                     
    SEMICOLON                       | ;                     
    IDENTIFIER                      | print                 
    OPEN_PAREN                      | (                     
    STRING                          | 'c =                  
    STRING_INTERPOLATION_IDENTIFIER | $                     
    IDENTIFIER                      | c                     
    STRING                          | '                     
    CLOSE_PAREN                     | )                     
    SEMICOLON                       | ;                     
    CLOSE_CURLY_BRACKET             | }
    ```