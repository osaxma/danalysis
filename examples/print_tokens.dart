import 'package:dolumns/dolumns.dart'; // to print table

import 'package:danalysis/danalysis.dart';

import '../samples/samples.dart';

void main() {
  final tokens = tokenize(sample_1);
  final table = [
    ['token type', 'token'],
    ...tokens.map((t) => [t.type.toString(), t.toString()])
  ];
  print(dolumnify(table,
      headerSeparator: '=',
      columnSplitter: ' | ',
      headerIncluded: true));
}
