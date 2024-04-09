%% Assignment 3 - Exercise 2
clear; clc; close all;

%% find all 2 digits twin primes
numbers = 1000:9999;

primes = numbers(isprime(numbers));

twinsIndices = find(diff(primes)==2);

twinsPrimes = [primes(twinsIndices); primes(twinsIndices + 1)]'
