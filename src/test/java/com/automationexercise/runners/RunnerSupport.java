package com.automationexercise.runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

/**
 * Configuração comum dos runners.
 * <ul>
 *   <li>Ignora cenários marcados com {@code @ignore} (helpers e pages)</li>
 *   <li>Aceita filtro opcional por tag: {@code -Dkarate.tags=@smoke} (vírgula = OU)</li>
 *   <li>Gera JUnit XML por feature (um testcase por cenário), usado na coleta de métricas</li>
 * </ul>
 */
final class RunnerSupport {

    private RunnerSupport() {
    }

    static Results run(String path, String reportDir, int threads) {
        var builder = Runner.path(path)
                .tags("~@ignore")
                .reportDir(reportDir)
                .outputCucumberJson(false)
                .outputJunitXml(true)
                .backupReportDir(false);

        String tags = System.getProperty("karate.tags");
        if (tags != null && !tags.isBlank()) {
            builder.tags(tags);
        }
        return builder.parallel(threads);
    }
}
