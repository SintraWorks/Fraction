//
//  Fraction.swift
//  Fractions
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

/**
    Fraction is a value type that represents the quotient of two numbers (like `1/3`), without loss of precision, and with support for basic arithmetic operations.

    The Fraction type supports addition, subtraction, multiplication and division, both through dedicated functions, and through overloading the corresponding operators.
    E.g. you can add two fractions in any of the following ways:

        var f1 = Fraction(numerator: 1, denominator: 2)
        let f2= Fraction(numerator: 3, denominator: 4)

        f1.add(f2) // mutating, f1 now holds the result of the addition
        let result1 = f1.adding(f2) // non-mutating
        let result2 = f1 + f2 // non-mutating

    By default arithmetic operations will reduce the result to its **Greatest Common Denominator**. The function based variants allow turning off this behaviour by explicitly forbidding reduction:

        f1.add(f2, reducing: false)

    - Warning: Fraction will trap if any operation results in an overflow or underflow.
 */
public struct Fraction {
    public enum FractionError: Error {
        case illegalDivision
    }

    /// The fraction's numerator (valid range: Int.min + 1 ... Int.max)
    public var numerator: Int
    /// The fraction's denominator (valid range: Int.min + 1 ... Int.max)
    public var denominator: Int

    /// Initialize a Fraction
    /// - Parameter numerator: The fraction's numerator (valid range: Int.min + 1 ... Int.max)
    /// - Parameter denominator: The fraction's denominator (valid range: Int.min + 1 ... Int.max)
    ///
    /// The lower end of the valid range for the parameters is Int.min + 1, because you cannot flip Int.min to to its positive counterpart –it results in an overflow–
    /// which may happen in the `reduce()` function.
    public init?(numerator: Int, denominator: Int) {
        guard denominator != 0 else { return nil }
        guard numerator > Int.min, denominator > Int.min else { return nil }

        self.numerator = numerator
        self.denominator = denominator
    }

    /// Initialize a Fraction from an integer
    /// - Parameter numerator: The fraction's numerator (valid range: Int.min + 1 ... Int.max)
    ///
    /// The lower end of the valid range for the parameter is Int.min + 1, because you cannot flip Int.min to to its positive counterpart –it results in an overflow–
    /// which may happen in the `reduce()` function.
    public init?(_ numerator: Int) {
        guard numerator > Int.min else { return nil }

        self.numerator = numerator
        self.denominator = 1
    }

    /// Reduce a fraction to its Greatest Common Denominator
    public mutating func reduce() {
        let (absNumerator, numeratorSign) = numerator < 0 ? (-numerator, -1) : (numerator, 1)
        let (absDenominator, denominatorSign) = denominator < 0 ? (-denominator, -1) : (denominator, 1)

        var u = absNumerator
        var v = absDenominator

        // Euclid's solution to finding the Greatest Common Denominator
        while (v != 0) {
            (v, u) = (u % v, v)
        }

        numerator = absNumerator / u * numeratorSign
        denominator = absDenominator / u * denominatorSign
    }

    /// Returns a new fraction representing the reduction of the receiver to its Greatest Common Denominator
    public func reduced() -> Fraction {
        var copy = self
        copy.reduce()
        return copy
    }

    /// Fractions with two negative signs are normalized to two positive signs.
    /// Fractions with negative denominator are normalized to positive denominator and negative numerator.
    public mutating func normalize() {
        if numerator >= 0 && denominator >= 0 { return }
        if (numerator < 0 && denominator < 0) || (denominator < 0) {
            numerator *= -1
            denominator *= -1
        }
    }

    /// Returns a normalized copy of `self`.
    /// Fractions with two negative signs are normalized to two positive signs.
    /// Fractions with negative denominator are normalized to positive denominator and negative numerator.
    public func normalized() -> Fraction {
        var copy = self
        copy.normalize()
        return copy
    }

    /// Converts the represented fraction to a Double value.
    /// - Warning: The resulting floating point value may not represent the fraction with absolute accuracy.
    public var doubleValue: Double {
        Double(numerator) / Double(denominator)
    }

    /// Converts the represented fraction to a Float value.
    /// - Warning: The resulting floating point value may not represent the fraction with absolute accuracy.
    public var floatValue: Float {
        Float(doubleValue)
    }

    /// Add another Fraction to self.
    /// - Parameters:
    ///   - other: The Fraction to add.
    ///   - reducing: A flag indicating whether to reduce the result of the addition to its GCD. Defaults to `true`.
    public mutating func add(_ other: Fraction, reducing: Bool = true) {
        self.normalize()
        let normalizedOther = other.normalized()

        if (denominator == normalizedOther.denominator) {
            numerator += normalizedOther.numerator
        } else {
            numerator = numerator * normalizedOther.denominator + normalizedOther.numerator * denominator
            denominator = denominator * normalizedOther.denominator
        }
        if ( reducing ) {
            self.reduce()
        }
    }

    /// Add an integer to self.
    /// - Parameters:
    ///   - integer: The integer to add.
    ///   - reducing: A flag indicating whether to reduce the result of the addition to its GCD. Defaults to `true`.
    public mutating func add(_ integer: Int, reducing: Bool = true) {
        self.normalize()

        numerator += integer * denominator

        if ( reducing ) {
            self.reduce()
        }
    }

    /// Add another Fraction to a copy of `self` and return the result.
    /// - Parameters:
    ///   - other: The Fraction to add.
    ///   - reducing: A flag indicating whether to reduce the result of the addition to its GCD. Defaults to `true`.
    public func adding(_ other: Fraction, reducing: Bool = true) -> Fraction {
        var copy = self
        copy.add(other, reducing: reducing)
        return copy
    }

    /// Add an integer to a copy of `self` and return the result.
    /// - Parameters:
    ///   - integer: The integer to add.
    ///   - reducing: A flag indicating whether to reduce the result of the addition to its GCD. Defaults to `true`.
    public func adding(_ integer: Int, reducing: Bool = true) -> Fraction {
        var copy = self
        copy.add(integer, reducing: reducing)
        return copy
    }

    /// Subtract another Fraction from self.
    /// - Parameters:
    ///   - other: The Fraction to subtract.
    ///   - reducing: A flag indicating whether to reduce the result of the subtraction to its GCD. Defaults to `true`.
    public mutating func subtract(_ other: Fraction, reducing: Bool = true) {
        if (denominator == other.denominator) {
            numerator -= other.numerator
        } else {
            numerator = numerator * other.denominator - other.numerator * denominator
            denominator = denominator * other.denominator
        }

        if ( reducing ) {
            self.reduce()
        }
    }

    /// Subtract an integer from self.
    /// - Parameters:
    ///   - integer: The integer to subtract.
    ///   - reducing: A flag indicating whether to reduce the result of the subtraction to its GCD. Defaults to `true`.
    public mutating func subtract(_ integer: Int, reducing: Bool = true) {
            numerator -= integer * denominator

        if ( reducing ) {
            self.reduce()
        }
    }

    /// Subtract another Fraction from a copy of `self` and return the result.
    /// - Parameters:
    ///   - other: The Fraction to subtract.
    ///   - reducing: A flag indicating whether to reduce the result of the subtraction to its GCD. Defaults to `true`.
    public func subtracting(_ other: Fraction, reducing: Bool = true) -> Fraction {
        var copy = self
        copy.subtract(other, reducing: reducing)
        return copy
    }

    /// Subtract an integer from a copy of `self` and return the result.
    /// - Parameters:
    ///   - integer: The integer to subtract.
    ///   - reducing: A flag indicating whether to reduce the result of the subtraction to its GCD. Defaults to `true`.
    public func subtracting(_ integer: Int, reducing: Bool = true) -> Fraction {
        var copy = self
        copy.subtract(integer, reducing: reducing)
        return copy
    }

    /// Multiply self by another Fraction.
    /// - Parameters:
    ///   - other: The Fraction to multiply by.
    ///   - reducing: A flag indicating whether to reduce the result of the multiplication to its GCD. Defaults to `true`.
    public mutating func multiply(by other: Fraction, reducing: Bool = true) {
        numerator = numerator * other.numerator
        denominator = denominator * other.denominator
        if ( reducing ) {
            self.reduce()
        }
    }

    /// Multiply self by an integer.
    /// - Parameters:
    ///   - integer: The integer to multiply by.
    ///   - reducing: A flag indicating whether to reduce the result of the multiplication to its GCD. Defaults to `true`.
    public mutating func multiply(by integer: Int, reducing: Bool = true) {
        numerator = numerator * integer
        if ( reducing ) {
            self.reduce()
        }
    }

    /// Multiply a copy of `self` by another Fraction and return the result.
    /// - Parameters:
    ///   - other: The Fraction to multiply by.
    ///   - reducing: A flag indicating whether to reduce the result of the multiplication to its GCD. Defaults to `true`.
    public func multiplying(by other: Fraction, reducing: Bool = true) -> Fraction {
        var copy = self
        copy.multiply(by: other, reducing:  reducing)
        return copy
    }

    /// Multiply a copy of `self` by an integer and return the result.
    /// - Parameters:
    ///   - integer: The integer to multiply by.
    ///   - reducing: A flag indicating whether to reduce the result of the multiplication to its GCD. Defaults to `true`.
    public func multiplying(by integer: Int, reducing: Bool = true) -> Fraction {
        var copy = self
        copy.multiply(by: integer, reducing:  reducing)
        return copy
    }

    /// Divide self by another Fraction.
    /// - Parameters:
    ///   - other: The Fraction to divide by.
    ///   - reducing: A flag indicating whether to reduce the result of the division to its GCD. Defaults to `true`.
    public mutating func divide(by other: Fraction, reducing: Bool = true) throws {
        guard other.numerator != 0 else { throw FractionError.illegalDivision }

        numerator = numerator * other.denominator
        denominator = denominator * other.numerator
        if ( reducing ) {
            self.reduce()
        }
    }

    /// Divide self by an integer.
    /// - Parameters:
    ///   - integer: The integer to divide by.
    ///   - reducing: A flag indicating whether to reduce the result of the division to its GCD. Defaults to `true`.
    public mutating func divide(by integer: Int, reducing: Bool = true) throws {
        guard integer != 0 else { throw FractionError.illegalDivision }

        let other = Fraction(numerator: integer, denominator: 1)!
        numerator = numerator * other.denominator
        denominator = denominator * other.numerator
        if ( reducing ) {
            self.reduce()
        }
    }

    /// Divide a copy of `self` by another Fraction and return the result.
    /// - Parameters:
    ///   - other: The Fraction to divide by.
    ///   - reducing: A flag indicating whether to reduce the result of the division to its GCD. Defaults to `true`.
    public func dividing(by other: Fraction, reducing: Bool = true) throws -> Fraction {
        var copy = self
        try copy.divide(by: other, reducing: reducing)
        return copy
    }

    /// Divide a copy of `self` by an integer and return the result.
    /// - Parameters:
    ///   - integer: The integer to divide by.
    ///   - reducing: A flag indicating whether to reduce the result of the division to its GCD. Defaults to `true`.
    public func dividing(by integer: Int, reducing: Bool = true) throws -> Fraction {
        guard integer != 0 else { throw FractionError.illegalDivision }

        var copy = self
        try copy.divide(by: integer, reducing: reducing)
        return copy
    }

    /// Flip `nominator` and `denominator` to their positive counterpart if negative.
    public mutating func abs() {
        if numerator < 0 {
            numerator *= -1
        }
        if denominator < 0 {
            denominator *= -1
        }
    }
}

extension Fraction {
    public static func + (lhs: Fraction, rhs: Fraction) -> Fraction {
        lhs.adding(rhs)
    }

    public static func + (lhs: Int, rhs: Fraction) -> Fraction {
        rhs.adding(lhs)
    }

    public static func + (lhs: Fraction, rhs: Int) -> Fraction {
        lhs.adding(rhs)
    }

    public static func += (left: inout Fraction, right: Fraction) {
        left = left + right
    }

    public static func - (lhs: Fraction, rhs: Fraction) -> Fraction {
        lhs.subtracting(rhs)
    }

    public static func - (lhs: Int, rhs: Fraction) -> Fraction {
        Fraction(numerator: lhs, denominator: 1)!.subtracting(rhs)
    }

    public static func - (lhs: Fraction, rhs: Int) -> Fraction {
        lhs.subtracting(rhs)
    }

    public static func -= (left: inout Fraction, right: Fraction) {
        left = left - right
    }

    public static func * (lhs: Fraction, rhs: Fraction) -> Fraction {
        lhs.multiplying(by: rhs)
    }

    public static func * (lhs: Int, rhs: Fraction) -> Fraction {
        rhs.multiplying(by: lhs)
    }

    public static func * (lhs: Fraction, rhs: Int) -> Fraction {
        lhs.multiplying(by: rhs)
    }

    public static func *= (left: inout Fraction, right: Fraction) {
        left = left * right
    }

    public static func / (lhs: Fraction, rhs: Fraction) throws -> Fraction {
        try lhs.dividing(by: rhs)
    }

    public static func / (lhs: Int, rhs: Fraction) throws -> Fraction {
        try Fraction(numerator: lhs, denominator: 1)!.dividing(by: rhs)
    }

    public static func / (lhs: Fraction, rhs: Int) throws -> Fraction {
        try lhs.dividing(by: rhs)
    }

    public static func /= (left: inout Fraction, right: Fraction) throws {
        left = try left / right
    }
}

extension Fraction: Comparable {
    public static func == (lhs: Fraction, rhs: Fraction) -> Bool {
        let lhsRed = lhs.reduced().normalized()
        let rhsRed = rhs.reduced().normalized()

        return lhsRed.numerator == rhsRed.numerator && lhsRed.denominator == rhsRed.denominator
    }

    public static func < (lhs: Fraction, rhs: Fraction) -> Bool {
        let lhsRed = lhs.reduced().normalized()
        let rhsRed = rhs.reduced().normalized()

        let lhsNominatorProduct = lhsRed.numerator * rhsRed.denominator
        let rhsNominatorProduct = rhsRed.numerator * lhsRed.denominator

        return lhsNominatorProduct < rhsNominatorProduct
    }
}

extension Fraction {
    public var description: String {
        "\(numerator)/\(denominator)"
    }
}

// MARK: - Helpers -
extension Fraction {
    public static var zero: Fraction {
        Fraction(numerator: 0, denominator: 1)!
    }

    public static var one: Fraction {
        Fraction(numerator: 1, denominator: 1)!
    }
}
