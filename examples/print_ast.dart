import 'package:danalysis/danalysis.dart';

import '../samples/samples.dart';

void main() {
  final ast = generateASTfromString(sample_1);
  PrintASTVisitor().printAST(
    ast,
    style: BoxDrawingStyle.dashedLight, // try BoxDrawingStyle.double
    printSourceMaxChar: 0, // try 50 to see source code next node name
  );
}
