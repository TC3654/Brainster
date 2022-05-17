# Homework Week 3, Deadline 2021-05-26 (Saturday)
# 
# Homework 1 (5 points)
# Write a function called weighted_average that as input takes two lists of the same length named X and weights
# and it return the weighted arithmetic mean https://en.wikipedia.org/wiki/Weighted_arithmetic_mean
# Use for loop to iterate over the elements of the lists.
# Inputs: x = [5,5,10,10] weights = [1,2,3,2]
# weighted_average(x, weights)
# 8.125

def weighted_average(x, weights):

    sum1 = 0
    sum2 = sum(weights)
    
    if len(x) != len(weights):
        return "Error! Lists need to be same length."

    for i in range(len(x)):
        sum1 += (x[i]*weights[i])
        
    return sum1/sum2


x = [5,5,10,10]
weights = [1,2,3,2]

w_avg = weighted_average(x, weights)

print(w_avg)

#
# Homework 2 (3 points)
#
# We want to find if a number is present in an already sorted list
# 
# 
# Name the function linear_search and simply iterate a for loop over the elements and return True if
# you the element is present and false if not.
#
#
#
# Inputs:
# x = [4,6,15,2,7,8,9]
# x.sort()
#
# Calls and outputs
#
# linear_search(x, 3)
# False
# linear_search(x, 4)
# True

def linear_search(sorted_list, num):
    
    for i in sorted_list:
        if i > num:
            break
        elif i == num:
            return True
        
    return False


y = [4,6,15,2,7,8,9]
y.sort()

lin_s = linear_search(y, 4)

print(lin_s)