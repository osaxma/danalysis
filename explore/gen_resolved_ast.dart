import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/file_system/overlay_file_system.dart'; //


final content = '''

void main() {
  print(1*1);
}
''';

void main() async {
  final filepath = '/it_does_not_matter';
  final collection = AnalysisContextCollection(
    includedPaths: [filepath],
    resourceProvider: OverlayResourceProvider(
      PhysicalResourceProvider(),
    )..setOverlay(filepath, content: content, modificationStamp: 0),
  );

  final session = collection.contextFor(filepath).currentSession;
  // session.analysisContext.analysisOptions;

  final libElement = await session.getLibraryByUri('file://$filepath').then(
        (value) => ((value as LibraryElementResult).element),
      );
    
  print(libElement.entryPoint) ;
}
