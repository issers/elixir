defmodule Euler do
  @moduledoc """
  Provides utility functions for integer arithmetic.
  """

  @spec factorCount(integer) :: integer
  def factorCount(n) do
    primeFactorMap(n) |> Enum.reduce(1, fn {_, v}, acc -> acc * (v + 1) end)
  end

  @spec factorial(integer) :: integer
  def factorial(n) when n < 0, do: raise("factorial not defined for negative numbers")
  def factorial(n) when n < 2, do: 1

  def factorial(n) do
    2..n |> Enum.reduce(1, fn k, acc -> acc * k end)
  end

  @doc """
  Answers whether a number is prime.

  ## Parameters

    - n: number to test for primeness

  ## Examples

      iex> Euler.isPrime(91)
      false

  """
  @spec isPrime(integer) :: boolean
  def isPrime(n) when n < 2, do: false
  def isPrime(n), do: n == smallestPrimeFactor(n)

  @doc """
  Generate a sorted list of all prime factors of a number.

  ## Parameters

    - n: number to factor

  ## Examples

      iex> Euler.primeFactorList(60)
      [2, 2, 3, 5]

  """
  @spec primeFactorList(integer) :: [integer]
  def primeFactorList(n) when n < 2, do: []

  def primeFactorList(n) do
    f = smallestPrimeFactor(n)
    [f | primeFactorList(div(n, f))]
  end

  @doc """
  Generate a map of prime->count for a number n.

  ## Parameters

    - n: number to factor

  ## Examples

      iex> Euler.primeFactorMap(60)
      %{2 => 2, 3 => 1, 5 => 1}

  """
  # @spec primeFactorMap(integer) :: any
  def primeFactorMap(n) do
    primeFactorList(n) |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
  end

  @doc """
  Find the smallest prime divisor of a number.

  ## Parameters

    - n: number to factor

  ## Examples

      iex> Euler.smallestPrimeFactor(91)
      7

  """
  @spec smallestPrimeFactor(integer) :: integer
  def smallestPrimeFactor(n) when n < 2, do: raise("no prime factors")
  def smallestPrimeFactor(n) when n < 4, do: n
  def smallestPrimeFactor(n) when rem(n, 2) == 0, do: 2
  def smallestPrimeFactor(n), do: smallestFactorAtLeast(n, 3)

  defp smallestFactorAtLeast(n, f) when f * f > n, do: n
  defp smallestFactorAtLeast(n, f) when rem(n, f) == 0, do: f

  defp smallestFactorAtLeast(n, f) do
    smallestFactorAtLeast(n, f + 2)
  end

  @doc """
  Efficiently compute the integer power of an integer.

  ## Parameters

    - a: base (any integer)
    - b: exponent (any nonnegative integer)

  ## Examples

      iex> Euler.power(2, 3)
      8
      iex> Euler.power(99, 101)
      3623720178604972098813098663067922123278149558725344544918977989723238743032175007053245780749266808966549534096463148419710533398337814216985343009467904985311514465603728812874382843771759324099510099

  """
  @spec power(integer, integer) :: integer
  def power(_, b) when b == 0, do: 1
  def power(a, b) when rem(b, 2) == 0, do: power(a * a, div(b, 2))
  def power(a, b), do: a * power(a, b - 1)

  @doc """
  Efficiently calculate a^b mod m. Same as :crypto.mod_pow

  ## Parameters

    - a: base (any integer)
    - b: exponent (any nonnegative integer)
    - m: modulus

  ## Examples

      iex> Euler.power_mod(2, 4, 10)
      6
      iex> Euler.power_mod(12345, 54321, 987654321)
      331496127

  """
  @spec power_mod(integer, integer, integer) :: integer

  # calculate a^b mod m. Same as :crypto.mod_pow
  def power_mod(_, b, _) when b == 0, do: 1
  def power_mod(a, b, m) when b == 1, do: rem(a, m)
  def power_mod(a, b, m) when rem(b, 2) == 0, do: power_mod(rem(a * a, m), div(b, 2), m)
  def power_mod(a, b, m), do: rem(a * power_mod(a, b - 1, m), m)

  # def strip_trailing_zeros(n) when rem(n, 10) == 0, do: n
  # def strip_trailing_zeros(n), do: strip_trailing_zeros(div(n, 10))

  # def factorial_strip_trailing_zeros(0), do: 1
  # def factorial_strip_trailing_zeros(n), do: rem(n * factorial_mod(n - 1, m), m)
  # def factorial_trailing_digits(n, d), do: factorial_trailing_digits(n, 1, power(10, d))
  # defp factorial_trailing_digits(n, acc, mod) when rem(acc, 10) == 0, do: factorial_trailing_digits(n, div(acc, 10), mod)
  # defp factorial_trailing_digits(1, acc, mod), do: rem(acc, mod)
  # defp factorial_trailing_digits(n, acc, mod), do: factorial_trailing_digits(n-1, n * acc, mod)
end

# Euler.power_mod(2, 7, 5)
# 1..100 |> Stream.filter(&(Euler.isPrime(&1))) |> Enum.to_list()
# rem(Euler.power_mod(Euler.factorial_trailing_digits(100000, 5), 10000000, 100000) * Euler.factorial_trailing_digits(10000, 5)  * Euler.factorial_trailing_digits(1000, 5) * Euler.factorial_trailing_digits(100, 5) * Euler.factorial_trailing_digits(10, 5), 100000)
