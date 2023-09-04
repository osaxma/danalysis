import 'package:dolumns/dolumns.dart';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/src/dart/scanner/scanner.dart';
import 'package:analyzer/src/string_source.dart';
// this is supposed to be private but for example we import it
import 'package:_fe_analyzer_shared/src/scanner/reader.dart';

import '../samples/samples.dart';

void main() {
  printTokens();
}

// Using Dart Scanner (ie Lexer) to tokenize the sample code
//
// note: apparently if the curly bracket is missing, there'll be an error and somehow the brakcet is added to the tokens
//       but removing a semicolon won't show an error and it won't be added
void printTokens() {
  final featureSet = FeatureSet.latestLanguageVersion();
  // from parseString
  var source = StringSource(sample_1, '');
  var reader = CharSequenceReader(sample_1);
  var errorCollector = RecordingErrorListener();

  // from docs:
  /* 
    The lexical structure of Dart is ambiguous without knowledge of the context
    in which a token is being scanned. For example, without context we cannot
    determine whether source of the form "<<" should be scanned as a single
    left-shift operator or as two left angle brackets. This scanner does not
    have any context, so it always resolves such conflicts by scanning the
    longest possible token.
   */
  var scanner = Scanner(source, reader, errorCollector)
    ..configureFeatures(
      featureSetForOverriding: featureSet,
      featureSet: featureSet,
    );
  var token = scanner.tokenize();
  final table = [
    ['token', 'token type']
  ];
  do {
    table.add([token.toString(), token.type.toString()]);
    token = token.next!;
  } while (!token.isEof);
  table.add([token.toString(), token.type.toString()]);

  print(dolumnify(table));
}
