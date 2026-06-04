// Licensed under the Dartastic Pro Software License Agreement.
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';

import 'otel_braintrust_suppression.dart';

class BraintrustResult {
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

class BraintrustCallResult<T> {
  const BraintrustCallResult({required this.value, this.result});
  final T value;
  final BraintrustResult? result;
}

Future<T> tracedBraintrust<T>({
  required String operation,
  required Future<BraintrustCallResult<T>> Function() invoke,
  Tracer? tracer,
}) async {
  if (braintrustInstrumentationSuppressed()) {
    final r = await invoke();
    return r.value;
  }
  final t = tracer ?? OTel.tracerProvider().getTracer('otel_braintrust');
  final span = t.startSpan('braintrust $operation', kind: SpanKind.client);
  try {
    span.addAttributes(
        OTel.attributes([OTel.attributeString('rpc.system', 'braintrust')]));
    span.addAttributes(
        OTel.attributes([OTel.attributeString('rpc.method', operation)]));
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.orgId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('braintrust.org.id', res.orgId!)]));
      }
      if (res.projectId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('braintrust.project.id', res.projectId!)]));
      }
      if (res.projectName != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('braintrust.project.name', res.projectName!)
        ]));
      }
      if (res.experimentId != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('braintrust.experiment.id', res.experimentId!)
        ]));
      }
      if (res.experimentName != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              'braintrust.experiment.name', res.experimentName!)
        ]));
      }
      if (res.datasetId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('braintrust.dataset.id', res.datasetId!)]));
      }
      if (res.datasetName != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('braintrust.dataset.name', res.datasetName!)
        ]));
      }
      if (res.datasetSize != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('braintrust.dataset.size', res.datasetSize!)]));
      }
      if (res.promptId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('braintrust.prompt.id', res.promptId!)]));
      }
      if (res.promptVersion != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeInt('braintrust.prompt.version', res.promptVersion!)
        ]));
      }
      if (res.evaluatorName != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('braintrust.evaluator.name', res.evaluatorName!)
        ]));
      }
      if (res.scorerName != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('braintrust.scorer.name', res.scorerName!)]));
      }
      if (res.scoreValue != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeDouble('braintrust.score.value', res.scoreValue!)]));
      }
      if (res.passedCount != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('braintrust.passed.count', res.passedCount!)]));
      }
      if (res.failedCount != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('braintrust.failed.count', res.failedCount!)]));
      }
      if (res.modelName != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('gen_ai.request.model', res.modelName!)]));
      }
      if (res.modelProvider != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('gen_ai.system', res.modelProvider!)]));
      }
      if (res.tokensInput != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeInt('gen_ai.usage.input_tokens', res.tokensInput!)
        ]));
      }
      if (res.tokensOutput != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeInt('gen_ai.usage.output_tokens', res.tokensOutput!)
        ]));
      }
      if (res.costUsdMicros != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeInt('braintrust.cost.usd_micros', res.costUsdMicros!)
        ]));
      }
      if (res.spanKind != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('braintrust.span.kind', res.spanKind!)]));
      }
      if (res.statusCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('http.response.status_code', res.statusCode!)]));
      }
      if (res.errorCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('braintrust.error.code', res.errorCode!)]));
      }
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400);
      if (fail) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              ErrorResource.errorType.key, res.errorCode ?? 'braintrust.error')
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
