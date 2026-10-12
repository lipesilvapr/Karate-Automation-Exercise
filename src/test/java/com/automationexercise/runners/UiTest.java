package com.automationexercise.runners;

import com.intuit.karate.Results;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class UiTest {

    @Test
    void runUiTests() {
        Results results = RunnerSupport.run(
                "classpath:features/ui",
                "target/karate-reports/ui",
                Integer.getInteger("ui.threads", 2));
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
