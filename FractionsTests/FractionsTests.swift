//
//  FractionsTests.swift
//  FractionsTests
//
//  Created by Antonio Nunes on 16/03/2020.
//  Copyright © 2020 SintraWorks.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this source code and associated documentation files (the "SourceCode"), to deal
//  in the SourceCode without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute copies of the SourceCode, and to
//  sell software using the SourceCode, and permit persons to whom the SourceCode is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the SourceCode.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import XCTest
@testable import Fractions

class FractionsTests: XCTestCase {

    // MARK: - Initialization

    // Division by 0 is illegal, so the denominator may not be zero.
    // All other values, regardless of sign, should return a Fraction.
    func testFailableInitializer() {
        let illegalFraction = Fraction(numerator: 0, denominator: 0)
        XCTAssertNil(illegalFraction, "denominator 0 is illegal; the initializer should return nil")

        let illegalFraction2 = Fraction(numerator: Int.min, denominator: 1)
        XCTAssertNil(illegalFraction2, "numerator Int.min is illegal; the initializer should return nil")

        let illegalFraction3 = Fraction(numerator: 0, denominator: Int.min)
        XCTAssertNil(illegalFraction3, "denominator Int.min is illegal; the initializer should return nil")

        let illegalFraction4 = Fraction(numerator: Int.min, denominator: Int.min)
        XCTAssertNil(illegalFraction4, "numerator Int.min and denominator Int.min are illegal; the initializer should return nil")

        let legalFraction1 = Fraction(numerator: 0, denominator: 1)
        XCTAssertNotNil(legalFraction1, "legal parameters (0, 1); the initializer should return a Fraction")

        let legalFraction2 = Fraction(numerator: 0, denominator: -1)
        XCTAssertNotNil(legalFraction2, "legal parameters (0, -1); the initializer should return a Fraction")

        let legalFraction3 = Fraction(numerator: -1, denominator: -1)
        XCTAssertNotNil(legalFraction3, "legal parameters (-1, -1); the initializer should return a Fraction")

        let legalFraction4 = Fraction(numerator: 1, denominator: -1)
        XCTAssertNotNil(legalFraction4, "legal parameters (1, -1); the initializer should return a Fraction")

        let legalFraction5 = Fraction(numerator: -1, denominator: 1)
        XCTAssertNotNil(legalFraction5, "legal parameters (-1, 1); the initializer should return a Fraction")

        let legalFraction6 = Fraction(numerator: 1, denominator: 1)
        XCTAssertNotNil(legalFraction6, "legal parameters (1, 1); the initializer should return a Fraction")
    }

    func testSucceedingInitializerSanity() {
        let f1 = Fraction(numerator: 1, denominator: -1)!
        XCTAssertTrue(f1.numerator == 1, "Numerator incorrectly assigned (expected 1 got \(f1.numerator)")
        XCTAssertTrue(f1.denominator == -1, "Denominator incorrectly assigned (expected -1 got \(f1.denominator)")

        let f2 = Fraction(numerator: -1, denominator: 1)!
        XCTAssertTrue(f2.numerator == -1, "Numerator incorrectly assigned (expected -1 got \(f1.numerator)")
        XCTAssertTrue(f2.denominator == 1, "Denominator incorrectly assigned (expected 1 got \(f1.denominator)")
    }

    // MARK: - Utilities

    func testDescription() {
        let f = Fraction(numerator: 1, denominator: 4)!
        let description = f.description
        XCTAssertTrue(description == "1/4", "Incorrect description for 1/4 (got \(description.description))")

        let f2 = Fraction(numerator: -1, denominator: -4)!
        let description2 = f2.description
        XCTAssertTrue(description2 == "-1/-4", "Incorrect description for 1/4 (got \(description2.description))")
    }

    func testDoubleValue() {
        let f = Fraction(numerator: 1, denominator: 4)!
        let result = f.doubleValue
        XCTAssertTrue(f.doubleValue == 1.0 / 4.0, "doubleValue of \(f.description) is \(1.0/4.0) (got \(result.description))")

        let f2 = Fraction(numerator: 1, denominator: 3)!
        let result2 = f2.doubleValue
        XCTAssertTrue(f2.doubleValue == 1.0 / 3.0, "doubleValue of \(f2.description) is \(1.0/3.0) (got \(result2.description))")

        let f3 = Fraction(numerator: 1, denominator: -3)!
        let result3 = f3.doubleValue
        XCTAssertTrue(f3.doubleValue == 1.0 / -3.0, "doubleValue of \(f3.description) is \(1.0 / -3.0) (got \(result3.description))")

        let f4 = Fraction(numerator: -1, denominator: -3)!
        let result4 = f4.doubleValue
        XCTAssertTrue(f4.doubleValue == -1.0 / -3.0, "doubleValue of \(f4.description) is \(-1.0 / -3.0) (got \(result4.description))")

        let f5 = Fraction(numerator: -1, denominator: 3)!
        let result5 = f5.doubleValue
        XCTAssertTrue(f5.doubleValue == -1.0 / 3.0, "doubleValue of \(f5.description) is \(-1.0 / 3.0) (got \(result5.description))")
    }

    func testFloatValue() {
        let f = Fraction(numerator: 1, denominator: 4)!
        let result = f.floatValue
        XCTAssertTrue(f.floatValue == 1.0 / 4.0, "floatValue of \(f.description) is \(1.0/4.0) (got \(result.description))")

        let f2 = Fraction(numerator: 1, denominator: 3)!
        let result2 = f2.floatValue
        XCTAssertTrue(f2.floatValue == 1.0 / 3.0, "floatValue of \(f2.description) is \(1.0/3.0) (got \(result2.description))")

        let f3 = Fraction(numerator: 1, denominator: -3)!
        let result3 = f3.floatValue
        XCTAssertTrue(f3.floatValue == 1.0 / -3.0, "floatValue of \(f3.description) is \(1.0 / -3.0) (got \(result3.description))")

        let f4 = Fraction(numerator: -1, denominator: -3)!
        let result4 = f4.floatValue
        XCTAssertTrue(f4.floatValue == -1.0 / -3.0, "floatValue of \(f4.description) is \(-1.0 / -3.0) (got \(result4.description))")

        let f5 = Fraction(numerator: -1, denominator: 3)!
        let result5 = f5.floatValue
        XCTAssertTrue(f5.floatValue == -1.0 / 3.0, "floatValue of \(f5.description) is \(-1.0 / 3.0) (got \(result5.description))")
    }

    // MARK: - Reduction

    func testReducePositives() {
        var f = Fraction(numerator: 2, denominator: 4)!
        f.reduce()
        XCTAssertTrue(f.numerator == 1 && f.denominator == 2, "Incorrect reduction for 2/4 (got \(f.description), expected 1/2")

        let f3_9 = Fraction(numerator: 3, denominator: 9)!
        let f3_9reduced = f3_9.reduced()
        XCTAssertTrue(f3_9reduced.numerator == 1 && f3_9reduced.denominator == 3, "Incorrect reduction for \(f3_9.description) (got \(f3_9reduced.description), expected 1/3")

        let f9_3 = Fraction(numerator: 9, denominator: 3)!
        let f9_3reduced = f9_3.reduced()
        XCTAssertTrue(f9_3reduced.numerator == 3 && f9_3reduced.denominator == 1, "Incorrect reduction for \(f9_3.description) (got \(f9_3reduced.description), expected 1/3")

        var f2_2 = Fraction(numerator: 2, denominator: 2)!
        f2_2.reduce()
        XCTAssertTrue(f2_2.numerator == 1 && f2_2.denominator == 1, "Incorrect reduction for 2/2 (got \(f2_2.description), expected 1/1")

        var f3_3 = Fraction(numerator: 3, denominator: 3)!
        f3_3.reduce()
        XCTAssertTrue(f3_3.numerator == 1 && f3_3.denominator == 1, "Incorrect reduction for 3/3 (got \(f3_3.description), expected 1/1")

        var fmax = Fraction(numerator: Int.max, denominator: Int.max)!
        fmax.reduce()
        XCTAssertTrue(fmax.numerator == 1 && fmax.denominator == 1, "Incorrect reduction for Int.max/Int.max (got \(fmax.description), expected 1/1")

        var fmax2 = Fraction(numerator: Int.max - 1, denominator: Int.max - 1)!
        fmax2.reduce()
        XCTAssertTrue(fmax2.numerator == 1 && fmax2.denominator == 1, "Incorrect reduction for Int.max-1/Int.max-1 (got \(fmax2.description), expected 1/1")
    }

    func testReduceMixedSigns() {
        var f1 = Fraction(numerator: -3, denominator: 15)!
        f1.reduce()
        XCTAssertTrue(f1.numerator == -1 && f1.denominator == 5, "Incorrect reduction for -3/15 (got \(f1.description), expected -1/5")

        var f2 = Fraction(numerator: 3, denominator: -15)!
        f2.reduce()
        XCTAssertTrue(f2.numerator == 1 && f2.denominator == -5, "Incorrect reduction for 3/-15 (got \(f2.description), expected 1/-5")
    }

    func testReduceNegatives() {
        var f = Fraction(numerator: -2, denominator: -4)!
        f.reduce()
        XCTAssertTrue(f.numerator == -1 && f.denominator == -2, "Incorrect reduction for -2/-4 (got \(f.description), expected -1/-2")

        let f2 = Fraction(numerator: -3, denominator: -9)!
        let f2Reduced = f2.reduced()
        XCTAssertTrue(f2Reduced.numerator == -1 && f2Reduced.denominator == -3, "Incorrect reduction for -3/-9 (got \(f2Reduced.description), expected -1/-3")

        var fmin = Fraction(numerator: Int.min + 1, denominator: Int.min + 1)!
        fmin.reduce()
        XCTAssertTrue(fmin.numerator == -1 && fmin.denominator == -1, "Incorrect reduction for Int.min+1/Int.min+1 (got \(fmin.description), expected -1/-1")
    }

    // MARK: - Absolute

    func testAbs() {
        var f1 = Fraction(numerator: 1, denominator: -1)!
        f1.abs()
        XCTAssertTrue(f1.numerator == 1, "Incorrect abs numerator value for (1, -1) (got \(f1.description)")
        XCTAssertTrue(f1.denominator == 1, "Incorrect abs denominator value for (1, -1) (got \(f1.description)")

        var f2 = Fraction(numerator: -1, denominator: 1)!
        f2.abs()
        XCTAssertTrue(f2.numerator == 1, "Incorrect abs numerator value for (-1, 1) (got \(f2.description)")
        XCTAssertTrue(f2.denominator == 1, "Incorrect abs denominator value for (-1, 1) (got \(f2.description)")

        var f3 = Fraction(numerator: -1, denominator: -1)!
        f3.abs()
        XCTAssertTrue(f3.numerator == 1, "Incorrect abs numerator value for (-1, -1) (got \(f3.description)")
        XCTAssertTrue(f3.denominator == 1, "Incorrect abs denominator value for (-1, -1) (got \(f3.description)")

        var f4 = Fraction(numerator: 1, denominator: 1)!
        f4.abs()
        XCTAssertTrue(f4.numerator == 1, "Incorrect abs numerator value for (1, 1) (got \(f4.description)")
        XCTAssertTrue(f4.denominator == 1, "Incorrect abs denominator value for (1, 1) (got \(f4.description)")
    }

        // MARK: - Utilities

    func testComparablePositive() {
        let f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f2_8 = Fraction(numerator: 2, denominator: 8)!

        let f1_2 = Fraction(numerator: 1, denominator: 2)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        let f3_6 = Fraction(numerator: 3, denominator: 6)!
        let f9_18 = Fraction(numerator: 9, denominator: 18)!

        let f1_3 = Fraction(numerator: 1, denominator: 3)!
        let f3_9 = Fraction(numerator: 3, denominator: 9)!

        let f6_18 = Fraction(numerator: 6, denominator: 18)!

        XCTAssertTrue(f1_4 < f2_4, "Incorrect comparison result for \(f1_4.description) < \(f2_4.description)")
        XCTAssertTrue(f1_4 < f1_2, "Incorrect comparison result for \(f1_4.description) < \(f1_2.description)")
        XCTAssertTrue(f2_8 < f2_4, "Incorrect comparison result for \(f2_8.description) < \(f2_4.description)")
        XCTAssertTrue(f2_8 < f1_2, "Incorrect comparison result for \(f2_8.description) < \(f1_2.description)")
        XCTAssertTrue(f1_4 < f9_18, "Incorrect comparison result for \(f1_4.description) < \(f9_18.description)")
        XCTAssertTrue(f1_3 < f3_6, "Incorrect comparison for result \(f1_3.description) < \(f3_6.description)")
        XCTAssertTrue(f1_3 < f9_18, "Incorrect comparison for result \(f1_3.description) < \(f9_18.description)")

        XCTAssertTrue(f1_4 == f2_8, "Incorrect comparison for result \(f1_4.description) < \(f2_8.description)")
        XCTAssertTrue(f2_8 == f1_4, "Incorrect comparison for result \(f2_8.description) < \(f1_4.description)")
        XCTAssertTrue(f2_8 == f1_4, "Incorrect comparison for result \(f2_8.description) < \(f1_4.description)")
        XCTAssertTrue(f2_4 == f1_2, "Incorrect comparison for result \(f2_4.description) < \(f1_2.description)")
        XCTAssertTrue(f1_3 == f3_9, "Incorrect comparison for result \(f1_3.description) < \(f3_9.description)")
        XCTAssertTrue(f1_3 == f6_18, "Incorrect comparison for result \(f1_3.description) < \(f6_18.description)")
        XCTAssertTrue(f3_6 == f9_18, "Incorrect comparison for result \(f3_6.description) < \(f9_18.description)")

        XCTAssertFalse(f2_4 == f1_4, "Incorrect comparison for result \(f2_4.description) != \(f1_4.description)")
    }

    func testComparableNegative() {
        let f1_4 = Fraction(numerator: -1, denominator: -4)!
        let f2_8 = Fraction(numerator: -2, denominator: -8)!

        let f1_2 = Fraction(numerator: -1, denominator: -2)!
        let f2_4 = Fraction(numerator: -2, denominator: -4)!
        let f3_6 = Fraction(numerator: -3, denominator: -6)!
        let f9_18 = Fraction(numerator: -9, denominator: -18)!

        let f1_3 = Fraction(numerator: -1, denominator: -3)!
        let f3_9 = Fraction(numerator: -3, denominator: -9)!

        let f6_18 = Fraction(numerator: -6, denominator: -18)!

        XCTAssertTrue(f1_4 < f2_4, "Incorrect comparison result for \(f1_4.description) < \(f2_4.description)")
        XCTAssertTrue(f1_4 < f1_2, "Incorrect comparison result for \(f1_4.description) < \(f1_2.description)")
        XCTAssertTrue(f2_8 < f2_4, "Incorrect comparison result for \(f2_8.description) < \(f2_4.description)")
        XCTAssertTrue(f2_8 < f1_2, "Incorrect comparison result for \(f2_8.description) < \(f1_2.description)")
        XCTAssertTrue(f1_4 < f9_18, "Incorrect comparison result for \(f1_4.description) < \(f9_18.description)")
        XCTAssertTrue(f1_3 < f3_6, "Incorrect comparison for result \(f1_3.description) < \(f3_6.description)")
        XCTAssertTrue(f1_3 < f9_18, "Incorrect comparison for result \(f1_3.description) < \(f9_18.description)")

        XCTAssertTrue(f1_4 == f2_8, "Incorrect comparison for result \(f1_4.description) == \(f2_8.description)")
        XCTAssertTrue(f2_8 == f1_4, "Incorrect comparison for result \(f2_8.description) == \(f1_4.description)")
        XCTAssertTrue(f2_8 == f1_4, "Incorrect comparison for result \(f2_8.description) == \(f1_4.description)")
        XCTAssertTrue(f2_4 == f1_2, "Incorrect comparison for result \(f2_4.description) == \(f1_2.description)")
        XCTAssertTrue(f1_3 == f3_9, "Incorrect comparison for result \(f1_3.description) == \(f3_9.description)")
        XCTAssertTrue(f1_3 == f6_18, "Incorrect comparison for result \(f1_3.description) == \(f6_18.description)")
        XCTAssertTrue(f3_6 == f9_18, "Incorrect comparison for result \(f3_6.description) == \(f9_18.description)")

        XCTAssertFalse(f2_4 == f1_4, "Incorrect comparison for result \(f2_4.description) != \(f1_4.description)")
    }

    func testComparableMixedSigns() {
        let fm1_4 = Fraction(numerator: -1, denominator: 4)!
        let f1_m4 = Fraction(numerator: 1, denominator: -4)!
        let fm1_m4 = Fraction(numerator: -1, denominator: -4)!
        let f1_4 = Fraction(numerator: 1, denominator: 4)!

        XCTAssertTrue(fm1_4 < f1_4, "Incorrect comparison result for \(fm1_4.description) < \(f1_4.description)")
        XCTAssertTrue(f1_m4 < f1_4, "Incorrect comparison result for \(f1_m4.description) < \(f1_4.description)")
        XCTAssertFalse(fm1_4 > f1_4, "Incorrect comparison result for \(fm1_4.description) < \(f1_4.description)")

        XCTAssertTrue(fm1_4 == f1_m4, "Incorrect comparison result for \(fm1_4.description) == \(f1_m4.description)")
        XCTAssertTrue(f1_4 == fm1_m4, "Incorrect comparison result for \(f1_4.description) == \(fm1_m4.description)")
    }

    // MARK: - Addition

    func testAdditionMutating() {
        var f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        f1_4.add(f2_4)
        XCTAssertTrue(f1_4.numerator == 3 && f1_4.denominator == 4, "Incorrect result adding \(f2_4.description) to 1/4. Expected 3/4, got \(f1_4.description)")

        var fm3_4 = Fraction(numerator: -3, denominator: 4)!
        fm3_4.add(f2_4)
        XCTAssertTrue(fm3_4.numerator == -1 && fm3_4.denominator == 4, "Incorrect result adding \(f2_4) to \(fm3_4.description). Expected -1/4, got \(fm3_4.description)")

        var f1_4bis = Fraction(numerator: 1, denominator: 4)!
        let f3_5 = Fraction(numerator: 3, denominator: 5)!
        f1_4bis.add(f3_5)
        XCTAssertTrue(f1_4bis.numerator == 17 && f1_4bis.denominator == 20, "Incorrect result adding \(fm3_4.description) to 1/4. Expected 17/20, got \(f1_4bis.description)")

        var f1_4third = Fraction(numerator: 1, denominator: 4)!
        f1_4third.add(1)
        XCTAssertTrue(f1_4third.numerator == 5 && f1_4third.denominator == 4, "Incorrect result adding 1 to 1/4. Expected 5/4, got \(f1_4third.description)")

        var f3_4bis = Fraction(numerator: 3, denominator: 4)!
        f3_4bis.add(3)
        XCTAssertTrue(f3_4bis.numerator == 15 && f3_4bis.denominator == 4, "Incorrect result adding 3 to 3/4. Expected 15/4, got \(f3_4bis.description)")
    }

    func testAdditionMutatingWithNegativeSigns() {
        var fm1_4 = Fraction(numerator: -1, denominator: 4)!
        var f1_m4 = Fraction(numerator: 1, denominator: -4)!
        var fm1_m4 = Fraction(numerator: -1, denominator: -4)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        let f2_m4 = Fraction(numerator: 2, denominator: -4)!

        fm1_4.add(f2_4)
        XCTAssertTrue(fm1_4.numerator == 1 && fm1_4.denominator == 4, "Incorrect result adding \(f2_4.description) to -1/4. Expected 1/4, got \(fm1_4.description)")

        f1_m4.add(f2_4)
        XCTAssertTrue(f1_m4.numerator == 1 && f1_m4.denominator == 4, "Incorrect result adding \(f2_4.description) to 1/-4. Expected 1/4, got \(f1_m4.description)")

        fm1_m4.add(f2_4)
        XCTAssertTrue(fm1_m4.numerator == 3 && fm1_m4.denominator == 4, "Incorrect result adding \(f2_4.description) to -1/-4. Expected 3/4, got \(fm1_m4.description)")

        fm1_m4 = Fraction(numerator: -1, denominator: -4)!
        fm1_m4.add(f2_m4)
        XCTAssertTrue(fm1_m4.numerator == -1 && fm1_m4.denominator == 4, "Incorrect result adding \(f2_m4.description) to -1/-4. Expected -1/4, got \(fm1_m4.description)")

    }

    func testAdditionNonMutating() {
        let f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        let result = f1_4.adding(f2_4)
        XCTAssertTrue(result.numerator == 3 && result.denominator == 4, "Incorrect result adding \(f2_4.description) to 1/4. Expected 3/4, got \(result.description)")


        let result1 = f1_4.adding(1)
        XCTAssertTrue(result1.numerator == 5 && result1.denominator == 4, "Incorrect result adding 1 to 1/4. Expected 5/4, got \(result1.description)")

        let f3_4 = Fraction(numerator: 3, denominator: 4)!
        let result2 = f3_4.adding(3)
        XCTAssertTrue(result2.numerator == 15 && result2.denominator == 4, "Incorrect result adding 3 to 3/4. Expected 15/4, got \(result2.description)")

    }

    func testAdditionNonMutatingNonReducing() {
        let f6_8 = Fraction(numerator: 6, denominator: 8)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        let result = f6_8.adding(f2_4, reducing: false)
        XCTAssertTrue(result.numerator == 40 && result.denominator == 32, "Incorrect result adding \(f2_4.description) to \(f6_8.description). Expected 40/32, got \(result.description)")

        // While we're at it, test some related stuff
        let result2 = f6_8.adding(f2_4, reducing: true)
        XCTAssertTrue(result2.numerator == 5 && result2.denominator == 4, "Incorrect result adding \(f2_4.description) to \(f6_8.description). Expected 5/4, got \(result2.description)")

        XCTAssertTrue(result.doubleValue == result2.doubleValue, "Incorrect doubleValue comparison for reducing and non-reducing counterparts")
    }

    func testAdditionNonMutatingExplicitlyReducing() {
        let f6_8 = Fraction(numerator: 6, denominator: 8)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        let result = f6_8.adding(f2_4, reducing: true)
        XCTAssertTrue(result.numerator == 5 && result.denominator == 4, "Incorrect result adding \(f2_4.description) to \(f6_8.description). Expected 5/4, got \(result.description)")

        let f3_4 = Fraction(numerator: 3, denominator: 4)!
        let result2 = f6_8.adding(f3_4, reducing: true)
        XCTAssertTrue(result2.numerator == 3 && result2.denominator == 2, "Incorrect result adding \(f3_4.description) to \(f6_8.description). Expected 3/2, got \(result2.description)")

        let result3 = f3_4.adding(f6_8, reducing: true)
        XCTAssertTrue(result3.numerator == 3 && result3.denominator == 2, "Incorrect result adding \(f6_8.description) to \(f3_4.description). Expected 3/2, got \(result3.description)")
    }

    func testAdditionOperator() {
        let f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        let result = f1_4 + f2_4
        XCTAssertTrue(result.numerator == 3 && result.denominator == 4, "Incorrect result for 1/4 + 2/4. Expected 3/4, got \(result.description)")

        let result2 = 1 + f1_4
        XCTAssertTrue(result2.numerator == 5 && result2.denominator == 4, "Incorrect result for 1 + 1/4. Expected 5/4, got \(result2.description)")

        let result3 = f1_4 + 1
        XCTAssertTrue(result3.numerator == 5 && result3.denominator == 4, "Incorrect result for 1/4 + 1. Expected 5/4, got \(result3.description)")
    }

    func testAdditionCompundAssignmentOperator() {
        var f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f3_4 = Fraction(numerator: 3, denominator: 4)!

        f1_4 += f3_4
        XCTAssertTrue(f1_4.numerator == 1 && f1_4.denominator == 1, "Incorrect result adding \(f3_4.description) to 1/4. Expected 1/1, got \(f1_4.description)")

    }

    // MARK: - Subtraction

    func testSubtractionMutating() {
        var f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        f1_4.subtract(f2_4)
        XCTAssertTrue(f1_4.numerator == -1 && f1_4.denominator == 4, "Incorrect result subtracting \(f2_4.description) from 1/4. Expected -1/4, got \(f1_4.description)")

        var fm3_4 = Fraction(numerator: -3, denominator: 4)!
        fm3_4.add(f2_4)
        XCTAssertTrue(fm3_4.numerator == -1 && fm3_4.denominator == 4, "Incorrect result subtracting \(f2_4.description) from \(fm3_4.description). Expected -1/4, got \(fm3_4.description)")

        var f1_4bis = Fraction(numerator: 1, denominator: 4)!
        let f3_5 = Fraction(numerator: 3, denominator: 5)!
        f1_4bis.add(f3_5)
        XCTAssertTrue(f1_4bis.numerator == 17 && f1_4bis.denominator == 20, "Incorrect result subtracting \(fm3_4.description) from 1/4. Expected 17/20, got \(f1_4bis.description)")

        var f1_4third = Fraction(numerator: 1, denominator: 4)!
        f1_4third.subtract(1)
        XCTAssertTrue(f1_4third.numerator == -3 && f1_4third.denominator == 4, "Incorrect result subtracting 1 from 1/4. Expected -3/4, got \(f1_4third.description)")

        var f3_4bis = Fraction(numerator: 3, denominator: 4)!
        f3_4bis.subtract(3)
        XCTAssertTrue(f3_4bis.numerator == -9 && f3_4bis.denominator == 4, "Incorrect result subtracting 3 from 3/4. Expected -9/4, got \(f3_4bis.description)")
    }

    func testSubtractionNonMutating() {
        let f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        let result = f1_4.subtracting(f2_4)
        XCTAssertTrue(result.numerator == -1 && result.denominator == 4, "Incorrect result subtracting \(f2_4.description) from 1/4. Expected -1/4, got \(result.description)")

        let f1_4third = Fraction(numerator: 1, denominator: 4)!
        let result2 = f1_4third.subtracting(1)
        XCTAssertTrue(result2.numerator == -3 && result2.denominator == 4, "Incorrect result subtracting 1 from 1/4. Expected -3/4, got \(result2.description)")

        let f3_4bis = Fraction(numerator: 3, denominator: 4)!
        let result3 = f3_4bis.subtracting(3)
        XCTAssertTrue(result3.numerator == -9 && result3.denominator == 4, "Incorrect result subtracting 3 from 3/4. Expected -9/4, got \(result3.description)")
    }

    func testSubtractionNonMutatingNonReducing() {
        let f6_8 = Fraction(numerator: 6, denominator: 8)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        let result = f6_8.subtracting(f2_4, reducing: false)
        XCTAssertTrue(result.numerator == 8 && result.denominator == 32, "Incorrect result subtracting \(f2_4.description) from 6/8. Expected 8/32, got \(result.description)")
    }

    func testSubtractionOperator() {
        let f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        let result = f1_4 - f2_4
        XCTAssertTrue(result.numerator == -1 && result.denominator == 4, "Incorrect result for 1/4 - 2/4. Expected -1/4, got \(result.description)")

        let result2 = 1 - f2_4
        XCTAssertTrue(result2.numerator == 1 && result2.denominator == 2, "Incorrect result for 1 - 2/4. Expected 1/2, got \(result2.description)")

        let result3 = f2_4 - 1
        XCTAssertTrue(result3.numerator == -1 && result3.denominator == 2, "Incorrect result for 2/4 - 1. Expected 1/2, got \(result3.description)")
    }

    func testSubtractionCompundAssignmentOperator() {
        var f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f3_4 = Fraction(numerator: 3, denominator: 4)!

        f1_4 -= f3_4
        XCTAssertTrue(f1_4.numerator == -1 && f1_4.denominator == 2, "Incorrect result subtracting \(f3_4.description) from 1/4. Expected -1/2, got \(f1_4.description)")

    }

    // MARK: - Multiplication

    func testMultiplicationMutating() {
        var f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        f1_4.multiply(by: f2_4)
        XCTAssertTrue(f1_4.numerator == 1 && f1_4.denominator == 8, "Incorrect result multiplying 1/4 by \(f2_4.description). Expected 1/8, got \(f1_4.description)")

        var fm1_4 = Fraction(numerator: -1, denominator: 4)!
        fm1_4.multiply(by: f2_4)
        XCTAssertTrue(fm1_4.numerator == -1 && fm1_4.denominator == 8, "Incorrect result multiplying -1/4 by \(f2_4.description). Expected -1/8, got \(fm1_4.description)")

        var f1_m4 = Fraction(numerator: 1, denominator: -4)!
        f1_m4.multiply(by: f2_4)
        XCTAssertTrue(f1_m4.numerator == 1 && f1_m4.denominator == -8, "Incorrect result multiplying 1/-4 by \(f2_4.description). Expected 1/-8, got \(f1_m4.description)")


        var f1_4bis = Fraction(numerator: 1, denominator: 4)!
        f1_4bis.multiply(by: 2)
        XCTAssertTrue(f1_4bis.numerator == 1 && f1_4bis.denominator == 2, "Incorrect result multiplying 1/4 by 2. Expected 1/2, got \(f1_4bis.description)")

        var f3_4 = Fraction(numerator: 3, denominator: 4)!
        f3_4.multiply(by: 3)
        XCTAssertTrue(f3_4.numerator == 9 && f3_4.denominator == 4, "Incorrect result multiplying 3/4 by 3. Expected 9/4, got \(f3_4.description)")
    }

    func testMultiplicationNonMutating() {
        let f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        let result = f1_4.multiplying(by: f2_4)
        XCTAssertTrue(result.numerator == 1 && result.denominator == 8, "Incorrect result multiplying \(f1_4.description) by \(f2_4.description). Expected 1/8, got \(result.description)")

        let f1_4bis = Fraction(numerator: 1, denominator: 4)!
        let result2 = f1_4bis.multiplying(by: 2)
        XCTAssertTrue(result2.numerator == 1 && result2.denominator == 2, "Incorrect result multiplying 2 by 1/4. Expected 1/2, got \(result2.description)")

        let f3_4 = Fraction(numerator: 3, denominator: 4)!
        let result3 = f3_4.multiplying(by: 3)
        XCTAssertTrue(result3.numerator == 9 && result3.denominator == 4, "Incorrect result multiplying 3 by 3/4. Expected 9/4, got \(result3.description)")
    }

    func testMultiplicationMutatingNonReducing() {
        var f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        f1_4.multiply(by: f2_4, reducing: false)
        XCTAssertTrue(f1_4.numerator == 2 && f1_4.denominator == 16, "Incorrect result multiplying 1/4 by \(f2_4.description). Expected 2/16, got \(f1_4).description")
    }

    func testMultiplicationOperator() {
        let f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f2_4 = Fraction(numerator: 2, denominator: 4)!
        let result = f1_4 * f2_4
        XCTAssertTrue(result.numerator == 1 && result.denominator == 8, "Incorrect result multiplying \(f1_4.description) by \(f2_4.description). Expected 1/8, got \(result.description)")

        let result2 = 2 * f2_4
        XCTAssertTrue(result2.numerator == 1 && result2.denominator == 1, "Incorrect result multiplying 2 by \(f2_4.description). Expected 1/1, got \(result2.description)")

        let result3 = f2_4 * 2
        XCTAssertTrue(result3.numerator == 1 && result3.denominator == 1, "Incorrect result multiplying \(result3.description) by 2. Expected 1/1, got \(result3.description)")
    }

    func testMultiplicationCompundAssignmentOperator() {
        var f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f3_4 = Fraction(numerator: 3, denominator: 4)!

        f1_4 *= f3_4
        XCTAssertTrue(f1_4.numerator == 3 && f1_4.denominator == 16, "Incorrect result multiplying 1/4 by \(f3_4.description). Expected 3/16, got \(f1_4.description)")

    }

    // MARK: - Division

    func testDivisionMutating() {
        var f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f3_4 = Fraction(numerator: 3, denominator: 4)!
        XCTAssertNoThrow(try f1_4.divide(by: f3_4))
        XCTAssertThrowsError(try f1_4.divide(by: 0))
        XCTAssertTrue(f1_4.numerator == 1 && f1_4.denominator == 3, "Incorrect result dividing 1/4 by \(f3_4.description). Expected 1/3, got \(f1_4.description)")

        var f1_4bis = Fraction(numerator: 1, denominator: 4)!
        try! f1_4bis.divide(by: 2)
        XCTAssertTrue(f1_4bis.numerator == 1 && f1_4bis.denominator == 8, "Incorrect result dividing 1/4 by 2. Expected 1/8, got \(f1_4bis.description)")

        var f3_4bis = Fraction(numerator: 3, denominator: 4)!
        try! f3_4bis.divide(by: 3)
        XCTAssertTrue(f3_4bis.numerator == 1 && f3_4bis.denominator == 4, "Incorrect result dividing 3 by 3/4. Expected 1/4, got \(f3_4bis.description)")
}

    func testDivisionNonMutating() {
        let f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f3_4 = Fraction(numerator: 3, denominator: 4)!
        XCTAssertNoThrow(try f1_4.dividing(by: f3_4))
        let result = try! f1_4.dividing(by: f3_4)
        XCTAssertTrue(result.numerator == 1 && result.denominator == 3, "Incorrect result dividing \(f1_4.description) by \(f3_4.description). Expected 1/3, got \(result.description)")

        let f0_4 = Fraction(numerator: 0, denominator: 4)!
        XCTAssertNoThrow(try f0_4.dividing(by: f3_4))
        XCTAssertThrowsError(try f3_4.dividing(by: f0_4))
        XCTAssertThrowsError(try f3_4.dividing(by: 0))

        let f1_4bis = Fraction(numerator: 1, denominator: 4)!
        let result2 = try! f1_4bis.dividing(by: 2)
        XCTAssertTrue(result2.numerator == 1 && result2.denominator == 8, "Incorrect result dividing 2 by 1/4. Expected 1/8, got \(result2.description)")

        let f3_4bis = Fraction(numerator: 3, denominator: 4)!
        let result3 = try! f3_4bis.dividing(by: 3)
        XCTAssertTrue(result3.numerator == 1 && result3.denominator == 4, "Incorrect result dividing 3 by 3/4. Expected 1/4, got \(result3.description)")
    }

    func testDivisionNonMutatingNonReducing() {
        let f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f3_4 = Fraction(numerator: 3, denominator: 4)!
        XCTAssertNoThrow(try f1_4.dividing(by: f3_4, reducing: false))
        let result = try! f1_4.dividing(by: f3_4, reducing: false)
        XCTAssertTrue(result.numerator == 4 && result.denominator == 12, "Incorrect result dividing \(f1_4.description) by \(f3_4.description). Expected 4/12, got \(result.description)")
    }

    func testDivisionOperator() {
        let f1_4 = Fraction(numerator: 1, denominator: 4)!
        let f3_4 = Fraction(numerator: 3, denominator: 4)!
        XCTAssertNoThrow(try f1_4 / f3_4)
        let result = try! f1_4 / f3_4
        XCTAssertTrue(result.numerator == 1 && result.denominator == 3, "Incorrect result dividing \(f1_4.description) by \(f3_4.description). Expected 1/3, got \(result.description)")

        let f0_4 = Fraction(numerator: 0, denominator: 4)!
        XCTAssertNoThrow(try f0_4 / f3_4)
        XCTAssertThrowsError(try f3_4 / f0_4)

        let result2 = try! 2 / f3_4
        XCTAssertTrue(result2.numerator == 8 && result2.denominator == 3, "Incorrect result dividing 2 by \(f3_4.description). Expected 8/3, got \(result2.description)")

        let result3 = try! f3_4 / 2
        XCTAssertTrue(result3.numerator == 3 && result3.denominator == 8, "Incorrect result dividing \(f3_4.description) by 2. Expected 3/8, got \(result3.description)")

        XCTAssertNoThrow(try 0 / f3_4)
        XCTAssertThrowsError(try f3_4 / 0)
    }

    func testDivisionCompundAssignmentOperator() {
        var f1_4 = Fraction(numerator: 1, denominator: 4)!
        var f1_4NoThrow = f1_4
        let f3_4 = Fraction(numerator: 3, denominator: 4)!

        XCTAssertNoThrow(try f1_4NoThrow /= f3_4)

        try! f1_4 /= f3_4
        XCTAssertTrue(f1_4.numerator == 1 && f1_4.denominator == 3, "Incorrect result dividing 1/4 by \(f3_4.description). Expected 1/3, got \(f1_4.description)")

    }

    func testStaticZero() {
        let zero = Fraction.zero
        XCTAssertTrue(zero.numerator == 0 && zero.denominator == 1)
    }

    func testStaticOne() {
        let one = Fraction.one
        XCTAssertTrue(one.numerator == 1 && one.denominator == 1)
    }
}

// And a bonus practical test:
// In western music notation adding a dot after a note/rest augments it by half its value. Each additional dot half again the previously halved value.
extension FractionsTests {
    public func dotFactorF(_ dotFactor: Int) -> Fraction? {
        if dotFactor == 0 { return nil }
        let dotFactorSquared = 2 << (dotFactor - 1)
        let q = Fraction(numerator: 1, denominator: dotFactorSquared)!
        return 1 + q * (dotFactorSquared - 1)
    }

    public func dotFactor(_ dotFactor: Int) -> Double {
        if dotFactor == 0 { return 0 }
        let dotFactorSquared = pow(2.0, Double(dotFactor))
        return 1 + (1 / dotFactorSquared) * (dotFactorSquared - 1)
    }

    func testDotFactor() {
        for dots in 1 ... 8 { print(dotFactor(dots))
            XCTAssertEqual(dotFactorF(dots)!.doubleValue, dotFactor(dots))
        }
    }
}
