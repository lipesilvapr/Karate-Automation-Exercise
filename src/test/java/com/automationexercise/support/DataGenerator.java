package com.automationexercise.support;

import java.util.UUID;

/**
 * Geradores de massa de dados dinâmica.
 * Exposto nas features via {@code data} (ver karate-config.js).
 */
public final class DataGenerator {

    private DataGenerator() {
    }

    public static String randomEmail() {
        return "karate_" + shortId() + "@example.com";
    }

    public static String randomName() {
        return "Karate " + shortId();
    }

    private static String shortId() {
        return UUID.randomUUID().toString().replace("-", "").substring(0, 10);
    }
}
