package com.automationexercise.runners;

import com.intuit.karate.Results;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ApiTest {

    @Test
    void runApiTests() {
        Results results = RunnerSupport.run(
                "classpath:features/api",
                "target/karate-reports/api",
                Integer.getInteger("api.threads", 5));
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
