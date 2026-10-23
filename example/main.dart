// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:otel_braintrust/otel_braintrust.dart';

/// Traces Braintrust calls with OpenTelemetry.
///
/// `otel_braintrust` depends on the OpenTelemetry API only, so the application
/// initializes an SDK once at startup. Wrap each Braintrust call in
/// [tracedBraintrust]; the `invoke` callback makes the real call and reports what
/// came back, which is recorded on the span.
Future<void> main() async {
  await OTel.initialize(serviceName: 'braintrust-example');

  // Traces a Braintrust call.
  final braintrustId = await tracedBraintrust<String>(
    operation: 'create',
    invoke: () async {
      // Make the Braintrust call here, then report what it returned.
      const id = 'braintrust_8f3a2c';
      return const BraintrustCallResult(
          value: id,
          result: BraintrustResult(
              orgId: 'org_8f3a2c',
              projectId: 'project_8f3a2c',
              projectName: 'example',
              experimentId: 'experiment_8f3a2c',
              experimentName: 'example',
              datasetId: 'dataset_8f3a2c',
              datasetName: 'example',
              datasetSize: 512,
              promptId: 'prompt_8f3a2c',
              promptVersion: 1,
              evaluatorName: 'example',
              scorerName: 'example',
              scoreValue: 0.5,
              passedCount: 3,
              failedCount: 3,
              modelName: 'standard',
              modelProvider: 'standard',
              tokensInput: 128,
              tokensOutput: 128,
              costUsdMicros: 1,
              spanKind: 'example',
              statusCode: 201,
              errorCode: 'example',
              errorMessage: 'example'));
    },
  );
  OTelLog.info('tracedBraintrust create returned $braintrustId');

  // Calls that should not be traced, such as health checks, run inside
  // runWithoutBraintrustInstrumentationAsync.
  await runWithoutBraintrustInstrumentationAsync(
    () => tracedBraintrust<String>(
      operation: 'create',
      invoke: () async {
        const id = 'braintrust_8f3a2c';
        return const BraintrustCallResult(
            value: id,
            result: BraintrustResult(
                orgId: 'org_8f3a2c',
                projectId: 'project_8f3a2c',
                projectName: 'example',
                experimentId: 'experiment_8f3a2c',
                experimentName: 'example',
                datasetId: 'dataset_8f3a2c',
                datasetName: 'example',
                datasetSize: 512,
                promptId: 'prompt_8f3a2c',
                promptVersion: 1,
                evaluatorName: 'example',
                scorerName: 'example',
                scoreValue: 0.5,
                passedCount: 3,
                failedCount: 3,
                modelName: 'standard',
                modelProvider: 'standard',
                tokensInput: 128,
                tokensOutput: 128,
                costUsdMicros: 1,
                spanKind: 'example',
                statusCode: 201,
                errorCode: 'example',
                errorMessage: 'example'));
      },
    ),
  );

  await OTel.shutdown();
}
