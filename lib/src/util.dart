import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:analyzer/dart/analysis/utilities.dart';

AstNode generateASTfromString(String code) {
  final parsed = parseString(content: code);
  return parsed.unit;
}
