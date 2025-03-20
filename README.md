# Fraction
Fraction is a value type that represents the quotient of two numbers (like `1/3`), without loss of precision, and with support for basic arithmetic operations.

The Fraction type supports **addition**, **subtraction**, **multiplication** and **division**, both through dedicated functions, and through overloading the corresponding operators. It also conforms to the **Comparable** protocol to allow comparing fractions and testing them for equality.

    Per example, you can add two fractions in any of the following ways:

        var f1 = Fraction(numerator: 1, denominator: 2)
        let f2 = Fraction(numerator: 3, denominator: 4)

        f1.add(f2) // mutating, f1 now holds the result of the addition
        let result1 = f1.adding(f2) // non-mutating
        let result2 = f1 + f2 // non-mutating
        let f1 += f2 // mutating, f1 now holds the result of the addition

By default arithmetic operations will reduce the result to its **Greatest Common Denominator**. The function based variants allow turning off this behaviour by explicitly forbidding reduction:

        f1.add(f2, reducing: false)

Fraction will trap if any operation results in an overflow or underflow.

## Using **Fractions** in your project

To use this package in a SwiftPM project, you need to set it up as a package dependency:

```swift
// swift-tools-version:5.9
import PackageDescription

let package = Package(
  name: "MyPackage",
  dependencies: [
    .package(
      url: "https://github.com/sintraworks/fraction.git", 
      .upToNextMinor(from: "0.9.0") // or `.upToNextMajor
    )
  ],
  targets: [
    .target(
      name: "MyTarget",
      dependencies: [
        .product(name: "Fractions", package: "fraction")
      ]
    )
  ]
)
```
