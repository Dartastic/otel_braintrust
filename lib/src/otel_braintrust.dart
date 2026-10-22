// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry_api/dartastic_opentelemetry_api.dart';

import 'otel_braintrust_suppression.dart';

class BraintrustResult {
  /// Creates a result.
  const BraintrustResult({
    this.orgId,
    this.projectId,
    this.projectName,
    this.experimentId,
    this.experimentName,
    this.datasetId,
    this.datasetName,
    this.datasetSize,
    this.promptId,
    this.promptVersion,
    this.evaluatorName,
    this.scorerName,
    this.scoreValue,
    this.passedCount,
    this.failedCount,
    this.modelName,
    this.modelProvider,
    this.tokensInput,
    this.tokensOutput,
    this.costUsdMicros,
    this.spanKind,
    this.statusCode,
    this.errorCode,
    this.errorMessage,
  });

  final String? orgId;
  final String? projectId;
  final String? projectName;
  final String? experimentId;
  final String? experimentName;
  final String? datasetId;
  final String? datasetName;
  final int? datasetSize;
  final String? promptId;
  final int? promptVersion;
  final String? evaluatorName;
  final String? scorerName;
  final double? scoreValue;
  final int? passedCount;
  final int? failedCount;
  final String? modelName;
  final String? modelProvider;
  final int? tokensInput;
  final int? tokensOutput;
  final int? costUsdMicros;
  final String? spanKind;
  final int? statusCode;
  final String? errorCode;
  final String? errorMessage;
}

/// What a traced call returned: the value for the caller plus fields
/// recorded on the span.
class BraintrustCallResult<T> {
  /// Creates a call result.
  const BraintrustCallResult({required this.value, this.result});

  /// The value returned to the caller.
  final T value;
  final BraintrustResult? result;
}

Future<T> tracedBraintrust<T>({
  required String operation,
  required Future<BraintrustCallResult<T>> Function() invoke,
  APITracer? tracer,
}) async {
  if (braintrustInstrumentationSuppressed()) {
    final r = await invoke();
    return r.value;
  }
  final t = tracer ?? OTelAPI.tracerProvider().getTracer('otel_braintrust');
  final span = t.startSpan('braintrust $operation', kind: SpanKind.client);
  try {
    span.addAttributes(OTelAPI.attributes(
        [OTelAPI.attributeString('rpc.system', 'braintrust')]));
    span.addAttributes(
        OTelAPI.attributes([OTelAPI.attributeString('rpc.method', operation)]));
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.orgId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('braintrust.org.id', res.orgId!)]));
      }
      if (res.projectId != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('braintrust.project.id', res.projectId!)
        ]));
      }
      if (res.projectName != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('braintrust.project.name', res.projectName!)
        ]));
      }
      if (res.experimentId != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('braintrust.experiment.id', res.experimentId!)
        ]));
      }
      if (res.experimentName != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'braintrust.experiment.name', res.experimentName!)
        ]));
      }
      if (res.datasetId != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('braintrust.dataset.id', res.datasetId!)
        ]));
      }
      if (res.datasetName != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('braintrust.dataset.name', res.datasetName!)
        ]));
      }
      if (res.datasetSize != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('braintrust.dataset.size', res.datasetSize!)
        ]));
      }
      if (res.promptId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('braintrust.prompt.id', res.promptId!)]));
      }
      if (res.promptVersion != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('braintrust.prompt.version', res.promptVersion!)
        ]));
      }
      if (res.evaluatorName != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'braintrust.evaluator.name', res.evaluatorName!)
        ]));
      }
      if (res.scorerName != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('braintrust.scorer.name', res.scorerName!)
        ]));
      }
      if (res.scoreValue != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeDouble('braintrust.score.value', res.scoreValue!)
        ]));
      }
      if (res.passedCount != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('braintrust.passed.count', res.passedCount!)
        ]));
      }
      if (res.failedCount != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('braintrust.failed.count', res.failedCount!)
        ]));
      }
      if (res.modelName != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('gen_ai.request.model', res.modelName!)]));
      }
      if (res.modelProvider != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('gen_ai.system', res.modelProvider!)]));
      }
      if (res.tokensInput != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('gen_ai.usage.input_tokens', res.tokensInput!)
        ]));
      }
      if (res.tokensOutput != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('gen_ai.usage.output_tokens', res.tokensOutput!)
        ]));
      }
      if (res.costUsdMicros != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('braintrust.cost.usd_micros', res.costUsdMicros!)
        ]));
      }
      if (res.spanKind != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('braintrust.span.kind', res.spanKind!)]));
      }
      if (res.statusCode != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('http.response.status_code', res.statusCode!)
        ]));
      }
      if (res.errorCode != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('braintrust.error.code', res.errorCode!)
        ]));
      }
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400);
      if (fail) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(ErrorAttributes.errorType.key,
              res.errorCode ?? 'braintrust.error')
        ]));
        span.setStatus(SpanStatusCode.Error, res.errorMessage);
      }
    }
    return r.value;
  } catch (e, st) {
    span.recordException(e, stackTrace: st);
    span.setStatus(SpanStatusCode.Error, e.toString());
    rethrow;
  } finally {
    span.end();
  }
}
