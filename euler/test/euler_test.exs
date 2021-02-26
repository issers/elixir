defmodule EulerTest do
  use ExUnit.Case
  doctest Euler

  test "isPrime" do
    assert Euler.isPrime(91) == false
    assert Euler.isPrime(210) == false
    assert Euler.isPrime(211) == true
  end

  test "smallestPrimeFactor" do
#    assert_raise Euler.smallestPrimeFactor(1)
    assert Euler.smallestPrimeFactor(91) == 7
    assert Euler.smallestPrimeFactor(210) == 2
    assert Euler.smallestPrimeFactor(211) == 211
  end

  test "primeFactorList" do
    assert Euler.primeFactorList(91) == [7, 13]
    assert Euler.primeFactorList(210) == [2, 3, 5, 7]
    assert Euler.primeFactorList(211) == [211]
  end

  test "primeFactorMap" do
    assert Euler.primeFactorMap(91) == %{7 => 1, 13 => 1}
    assert Euler.primeFactorMap(72) == %{2 => 3, 3 => 2}
    assert Euler.primeFactorMap(211) == %{211 => 1}
  end

  test "power" do
    assert Euler.power(-2, 3) == -8
    assert Euler.power(3, 2) == 9
  end

  test "power_mod" do
    assert Euler.power_mod(2, 10, 100) == 24
    assert Euler.power_mod(123456789, 987654321, 2311) == 179
  end
end
