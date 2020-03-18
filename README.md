# Fraction
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

Fraction will trap if any operation results in an overflow or underflow.
