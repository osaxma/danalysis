// apparently 

const sample_3 = '''
1 * 2;
''';

const sample_1 = r'''
void main() {
  print('starting the program');
  // explicit type 
  final int a = 10;
  // implicit type
  final b = 20;
  
  final c = a * b * d;

  print('c = $c');
}
''';


const sample_2 = r'''
void main() {
 final List<(int, int)> x = <(int, int)>[];
}
''';



const sample_x = r'''

// for reference:  ┗ ┣ ┃ ━ ╹

import 'dart:math';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/src/dart/ast/ast.dart';

import 'package:analyzer/dart/analysis/utilities.dart';

import 'samples.dart';

void main() {
  final ast = genAST();
  final astPrinter = PrintAST();
  astPrinter.printAST(ast);
}

AstNode genAST() {
  final parsed = parseString(content: sample_1);
  return parsed.unit;
}

class PrintAST extends
// BreadthFirstVisitor
    GeneralizingAstVisitor {
  final nodes = <AstNode>[];
  final depths = <int>[];
  List<bool> flags = [];

  int level = 0;
  int prevDepth = 0;
  final buff = StringBuffer();

  void printAST(AstNode node) {
    buff.clear();
    nodes.clear();
    depths.clear();
    flags.clear();

    node.accept(this);
    flags = List.filled(depths.reduce(max), false);

    _writeBuff();
    print(buff);
  }

  // a bit hacky but kinda works
  void _writeBuff() {
    final length = nodes.length;

    for (var i = 0; i < length; i++) {
      final node = nodes[i];
      final depth = depths[i];

      if (i != 0) {
        final subDepths = depths.sublist(i + 1, length);
        bool isSameDepthAhead = false;
        flags[depth - 1] = false;
        for (var d in subDepths) {
          if (d < depth) {
            break;
          } else if (d == depth) {
            isSameDepthAhead = true;
            flags[depth - 1] = true;
            break;
          }
        }

        // to have consistent 
        final indent = 5;

        
        for (var j = 0; j < depth - 1; j++) {
          buff.write(' ' * indent); 
          if (flags[j]) {
            buff.write('┃');
          } else {
            buff.write(' ');
          }
        }

        if (isSameDepthAhead) {
          buff.write((' ' * indent) + '┃━');
        } else {
          buff.write((' ' * indent) + '┗━');
        }

        buff.write('━');
      }

      buff.write(node.runtimeType);
      buff.write(': ');
      buff.write(node.toSource());

      buff.writeln();
    }
  }

  @override
  visitNode(AstNode node) {
    final depth = getDepth(node);
    nodes.add(node);
    depths.add(depth);
    return super.visitNode(node);
  }

  int getDepth(AstNode node) {
    int depth = 0;
    while (node.parent != null) {
      depth += 1;
      node = node.parent!;
    }
    return depth;
  }
}


''';