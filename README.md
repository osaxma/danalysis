# danalysis
nothing fancy here -- just a repo to explore dart analysis _(aka danalysis for the lack of creativity)_. 

My main goal of this repo is to keep track of any code I write related to dart analysis _because I usually forget how I did it._

----

## Print AST 

Check [examples/print_ast.dart](examples/print_ast.dart) to print an AST in a tree structure:

- input:
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