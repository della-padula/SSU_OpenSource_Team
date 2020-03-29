package com.denny.noticeworker

open class TestCalculator {
    companion object {
        open fun plus(a: Int, b: Int): Int {
            return a + b
        }

        open fun minus(a: Int, b: Int): Int {
            return a - b
        }
    }
}