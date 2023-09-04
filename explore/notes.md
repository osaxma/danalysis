
## Explore AST Resolution Using debugger

The resolution start here:
- ~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/dart/analysis/driver.dart
    - AnalysisDriver.performWork()
    - AnalysisDriver_computeUnitElement

For example, if we break at `BinaryExpressionResolver.resolve`, the call stack would be and from which we can explore further or place breakpoints at different levels of interest to see how things work

```
BinaryExpressionResolver.resolve (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/dart/resolver/binary_expression_resolver.dart:44)
ResolverVisitor.visitBinaryExpression (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/generated/resolver.dart:2015)
BinaryExpressionImpl.resolveExpression (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/dart/ast/ast.dart:1823)
ResolverVisitor.dispatchExpression (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/generated/resolver.dart:820)
TypeAnalyzer.analyzeExpression (~/.pub-cache/hosted/pub.dev/_fe_analyzer_shared-64.0.0/lib/src/type_inference/type_analyzer.dart:571)
ResolverVisitor.visitConstructorFieldInitializer (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/generated/resolver.dart:2254)
ConstructorFieldInitializerImpl.accept (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/dart/ast/ast.dart:4486)
NodeListImpl.accept (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/dart/ast/ast.dart:12998)
AstResolver.resolveConstructorNode.visit (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/summary2/ast_resolver.dart:75)
AstResolver.resolveConstructorNode (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/summary2/ast_resolver.dart:85)
ConstructorInitializerResolver._constructor (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/summary2/constructor_initializer_resolver.dart:61)
ConstructorInitializerResolver.resolve (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/summary2/constructor_initializer_resolver.dart:28)
LibraryBuilder.resolveConstructors (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/summary2/library_builder.dart:500)
Linker._resolveConstructors (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/summary2/link.dart:274)

Linker._buildOutlines (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/summary2/link.dart:144) <~~~~~~ this calls different resolvers above

<asynchronous gap> (Unknown Source:0)
Linker.link (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/summary2/link.dart:96)
<asynchronous gap> (Unknown Source:0)
link (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/summary2/link.dart:39)
<asynchronous gap> (Unknown Source:0)

LibraryContext.load.loadBundle (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/dart/analysis/library_context.dart:184)
<asynchronous gap> (Unknown Source:0)
LibraryContext.load.loadBundle (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/dart/analysis/library_context.dart:144)
<asynchronous gap> (Unknown Source:0)
LibraryContext.load.<anonymous closure> (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/dart/analysis/library_context.dart:251)
<asynchronous gap> (Unknown Source:0)
PerformanceLog.runAsync (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/dart/analysis/performance_logger.dart:50)
<asynchronous gap> (Unknown Source:0)
LibraryContext.load (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/dart/analysis/library_context.dart:249)
<asynchronous gap> (Unknown Source:0)
AnalysisDriver._computeUnitElement.<anonymous closure> (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/dart/analysis/driver.dart:1520)
<asynchronous gap> (Unknown Source:0)
PerformanceLog.runAsync (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/dart/analysis/performance_logger.dart:50)
<asynchronous gap> (Unknown Source:0)
AnalysisDriver.performWork (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/dart/analysis/driver.dart:1137)
<asynchronous gap> (Unknown Source:0)
AnalysisDriverScheduler._run (~/.pub-cache/hosted/pub.dev/analyzer-6.2.0/lib/src/dart/analysis/driver.dart:2262)
<asynchronous gap> (Unknown Source:0)
```