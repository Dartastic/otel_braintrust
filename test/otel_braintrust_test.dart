// Licensed under the Dartastic Pro Software License Agreement.
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:dartastic_opentelemetry/testing.dart';
import 'package:otel_braintrust/otel_braintrust.dart';
import 'package:test/test.dart';

void main() {
  late TestHarness harness;
  late InMemorySpanExporter spans;

  setUpAll(() async {
    harness = await maybeInitializeOtelForTest(
      serviceName: 'otel_braintrust-test',
    );
    spans = harness.spans;
  });

  setUp(() => harness.clear());

  Map<String, Object> attrsOf(Span s) =>
      {for (final a in s.attributes.toList()) a.key: a.value};

  test('experiment.run records counts + scores', () async {
    await tracedBraintrust<String>(
      operation: 'experiment.run',
      invoke: () async => const BraintrustCallResult(
        value: 'ok',
        result: BraintrustResult(
          projectName: 'chatbot',
          experimentName: 'eval-v3',
          datasetName: 'golden',
          datasetSize: 200,
          passedCount: 185,
          failedCount: 15,
        ),
      ),
    );
    final a = attrsOf(spans.findSpanByName('braintrust experiment.run')!);
    expect(a['braintrust.experiment.name'], 'eval-v3');
    expect(a['braintrust.passed.count'], 185);
    expect(a['braintrust.failed.count'], 15);
  });

  test('span.log records model + tokens + cost', () async {
    await tracedBraintrust<String>(
      operation: 'span.log',
      invoke: () async => const BraintrustCallResult(
        value: 'ok',
        result: BraintrustResult(
          spanKind: 'llm',
          modelName: 'gpt-4o',
          modelProvider: 'openai',
          tokensInput: 800,
          tokensOutput: 200,
          costUsdMicros: 6500,
        ),
      ),
    );
    final a = attrsOf(spans.findSpanByName('braintrust span.log')!);
    expect(a['gen_ai.request.model'], 'gpt-4o');
    expect(a['braintrust.cost.usd_micros'], 6500);
  });

  test('error code sets span error', () async {
    await tracedBraintrust<String>(
      operation: 'experiment.run',
      invoke: () async => const BraintrustCallResult(
        value: 'ok',
        result: BraintrustResult(
          errorCode: 'forbidden',
          statusCode: 403,
        ),
      ),
    );
    expect(
      spans.findSpanByName('braintrust experiment.run')!.status,
      SpanStatusCode.Error,
    );
  });

  test('suppression skips spans', () async {
    await runWithoutBraintrustInstrumentationAsync(() async {
      await tracedBraintrust<String>(
        operation: 'projects.list',
        invoke: () async => const BraintrustCallResult(value: 'v'),
      );
    });
    expect(spans.findSpansStartingWith('braintrust '), isEmpty);
  });
}
