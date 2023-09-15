# Functions (part 2)

The previous code is not computationally efficient. Instead of copying all the elements of the matrix, we can create a new matrix that points to the same memory address as the original matrix, but with the elements outside the diagonal swapped. This is a more efficient approach, but it is also more complex to implement.
