import 'dart:math';

import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:analyzer/dart/analysis/utilities.dart';

import 'box_drawings.dart';

AstNode genAST(String code) {
  final parsed = parseString(content: code);
  return parsed.unit;
}

class PrintASTVisitor extends GeneralizingAstVisitor {
  final _nodes = <AstNode>[];
  final _depths = <int>[];
  List<bool> _liveBranches = [];
  final _buff = StringBuffer();

  void printAST(AstNode rootNode, {int printSourceMaxChar = 0, BoxDrawingStyle style = BoxDrawingStyle.light}) {
    _clear();

    rootNode.accept(this);
    _liveBranches = List.filled(_depths.reduce(max), false);

    _genTextTree(printSourceMaxChar, style);
    print(_buff);
  }

  @override
  visitNode(AstNode node) {
    final depth = _getDepth(node);
    _nodes.add(node);
    _depths.add(depth);
    return super.visitNode(node);
  }

  void _clear() {
    _buff.clear();
    _nodes.clear();
    _depths.clear();
    _liveBranches.clear();
  }

  // a bit hacky but it works ¯\_(ツ)_/¯
  void _genTextTree(int printSourceMaxChar, BoxDrawingStyle style) {
    final length = _nodes.length;
    // controls where a branch appears under a root node (approx equals the number of letters)
    final indent = ' ' * 5;

    for (var i = 0; i < length; i++) {
      final node = _nodes[i];
      final depth = _depths[i];

      if (i != 0) {
        // simply to mark a branch if it should be drawn in the next line
        final subDepths = _depths.sublist(i + 1, length);
        _liveBranches[depth - 1] = false;
        for (var d in subDepths) {
          // if we encounter a higher branch than the current one, it means this branch is done.
          // Otherwise, if we encounter the same branch again, it means the branch will be alive
          if (d < depth) {
            break;
          } else if (d == depth) {
            _liveBranches[depth - 1] = true;
            break;
          }
        }

        // write the higher live branches first
        for (var j = 0; j < depth - 1; j++) {
          // indent for each depth
          _buff.write(indent);
          if (_liveBranches[j]) {
            _buff.write(style.vertical);
          }
        }

        // write the current branch
        if (_liveBranches[depth - 1]) {
          _buff.writeAll([indent, style.verticalAndRight, style.rightTip]);
        } else {
          _buff.writeAll([indent, style.upAndRight, style.rightTip]);
        }
      }

      // write the node name
      _buff.write(_prettyNodeName(node));
      if (printSourceMaxChar > 0) {
        _buff.writeAll([': ', _shortSource(node, printSourceMaxChar)]);
      }
      _buff.writeln();
    }
  }

  String _shortSource(AstNode node, int max) {
    final source = node.toSource();
    final length = source.length;
    if (length <= max) {
      return source;
    }
    final half = max ~/ 2;
    final firstHalf = source.substring(0, half);
    final secondHalf = source.substring(length - half, length);

    return firstHalf + ' ... ' + secondHalf;
  }

  String _prettyNodeName(AstNode node) {
    // remove the word `Impl` and split pascal cases by spaces
    return node.runtimeType
        .toString()
        .replaceAll('Impl', '')
        .replaceAllMapped(RegExp('[A-Z]'), (m) => ' ${m[0]}')
        .trimLeft();
  }

  int _getDepth(AstNode node) {
    int depth = 0;
    while (node.parent != null) {
      depth += 1;
      node = node.parent!;
    }
    return depth;
  }
}
