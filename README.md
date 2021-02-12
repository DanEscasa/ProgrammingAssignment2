---
title: "README.md"
author: "Daniel Escasa"
date: "12/28/2020"
output:
  html_document: default
  pdf_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Generating test matrices

Once I'd written the functions, I needed matrices to test them. Two options were available to me, and I hope to others who need random matrices, not just for these functions, but for other purposes.

## Using R's built-in functions
runif(), among others, will do the job:

<pre><code>testMat <- makeCacheMatrix(matrix(runif(25), nrow = 5))</code></pre>

Then:
<pre><code>> testMat <- makeCacheMatrix(matrix(runif(25), nrow = 5))
> testMat$get()
          [,1]      [,2]       [,3]      [,4]       [,5]
[1,] 0.7982333 0.8639513 0.43536390 0.3126092 0.67693206
[2,] 0.9204914 0.8018789 0.76017292 0.5399978 0.01473741
[3,] 0.9407040 0.5021631 0.06728394 0.8329966 0.57415934
[4,] 0.5096730 0.2362911 0.01591961 0.8290891 0.32937966
[5,] 0.5218791 0.6903905 0.07827841 0.7289832 0.74343937
> testMat$getInv()
NULL
> cacheSolve(testMat)
           [,1]      [,2]         [,3]      [,4]       [,5]
[1,]   9.523074  3.148233  0.015439203 -3.912639 -4.3736385
[2,]  15.468256  1.600941 -0.053565525 -5.182758 -5.6220191
[3,]   4.244279  2.082347 -0.002539439 -2.997713 -0.9885146
[4,] -13.961930 -3.092905  1.106684768  5.585732  5.3200525
[5,]  -3.617144 -1.215361 -1.013620288  2.397186  1.8425553
> cacheSolve(testMat)
getting cached data
           [,1]      [,2]         [,3]      [,4]       [,5]
[1,]   9.523074  3.148233  0.015439203 -3.912639 -4.3736385
[2,]  15.468256  1.600941 -0.053565525 -5.182758 -5.6220191
[3,]   4.244279  2.082347 -0.002539439 -2.997713 -0.9885146
[4,] -13.961930 -3.092905  1.106684768  5.585732  5.3200525
[5,]  -3.617144 -1.215361 -1.013620288  2.397186  1.8425553
> testMat$getInv()
           [,1]      [,2]         [,3]      [,4]       [,5]
[1,]   9.523074  3.148233  0.015439203 -3.912639 -4.3736385
[2,]  15.468256  1.600941 -0.053565525 -5.182758 -5.6220191
[3,]   4.244279  2.082347 -0.002539439 -2.997713 -0.9885146
[4,] -13.961930 -3.092905  1.106684768  5.585732  5.3200525
[5,]  -3.617144 -1.215361 -1.013620288  2.397186  1.8425553</code></pre>
and, for good measure:<code><pre>> testMat$get() %*% testMat\$getInv()
              [,1]          [,2]          [,3]          [,4]          [,5]
[1,]  1.000000e+00  3.330669e-16 -1.110223e-16 -4.440892e-16 -2.220446e-16
[2,] -2.664535e-15  1.000000e+00  1.110223e-16  1.332268e-15  8.881784e-16
[3,] -1.346145e-15 -1.457168e-16  1.000000e+00  4.510281e-17  5.412337e-16
[4,] -3.996803e-15 -2.220446e-16  0.000000e+00  1.000000e+00  4.440892e-16
[5,] -1.332268e-15  0.000000e+00 -2.220446e-16  4.440892e-16  1.000000e+00</code></pre>
Note that this doesn't look like the identity matrix. If you look more closely, however, the entries in the diagonal <strong>are</strong> ones, and the others are close enough to zero. In fact, if I had <code>round</code>'ed the matrix, the entries along the diagonal would be exactly one, and the others would be exactly zero.

I was lucky to get a non-singular matrix the first time. If <code>cacheSolve</code> returns <code>NaN</code>, you'll have to try again.

Also, you can of course pass <code>min = </code> and <code>max = </code> parameters to <code>runif</code>.

## An online random matrix generator
I found a handy site for [random generation of matrices](https://onlinemathtools.com/generate-random-matrix). 

For convenience, set the element and column separators to the comma (“,”), an option you can find below the <code>Generate Matrix</code> button. That'll make it easy to paste the generated matrix into your R console.

Here's one I got from them, plugged into the makeCacheMatrix function. Note the “byrow = true” parameter to the matrix creation function. I suppose you could omit it, giving you the transpose. Also, it doesn't always generate a non-singular matrix, so you'll have to keep at it until you get one. I used to have a program, written some 40 years ago, to generate non-singular matrices. Given enough time, I could write one again.

<pre><code>> testMat <- makeCacheMatrix(matrix(c(5, 4, 9, 6, 8, 1, 0, 8, 8, 3, 3, 2, 2, 9, 6, 8, 8, 8, 4, 7, 4, 8, 6, 9, 8), nrow = 5, byrow = TRUE))
> testMat$get()
     [,1] [,2] [,3] [,4] [,5]
[1,]    5    4    9    6    8
[2,]    1    0    8    8    3
[3,]    3    2    2    9    6
[4,]    8    8    8    4    7
[5,]    4    8    6    9    8
> testMat$get()
     [,1] [,2] [,3] [,4] [,5]
[1,]    5    4    9    6    8
[2,]    1    0    8    8    3
[3,]    3    2    2    9    6
[4,]    8    8    8    4    7
[5,]    4    8    6    9    8
> testMat$getInv()
NULL
> cacheSolve(testMat)
            [,1]         [,2]        [,3]        [,4]         [,5]
[1,] -0.14461980  0.032424677  0.18479197  0.25796270 -0.231850789
[2,] -0.12453372  0.000143472 -0.11865136  0.02769010  0.189239598
[3,]  0.05308465  0.093256815 -0.12338594 -0.00143472  0.005738881
[4,] -0.16241033  0.103873745  0.09641320  0.04763271  0.009469154
[5,]  0.33974175 -0.203156385  0.01032999 -0.20918221  0.036728838
> testMat$getInv()
            [,1]         [,2]        [,3]        [,4]         [,5]
[1,] -0.14461980  0.032424677  0.18479197  0.25796270 -0.231850789
[2,] -0.12453372  0.000143472 -0.11865136  0.02769010  0.189239598
[3,]  0.05308465  0.093256815 -0.12338594 -0.00143472  0.005738881
[4,] -0.16241033  0.103873745  0.09641320  0.04763271  0.009469154
[5,]  0.33974175 -0.203156385  0.01032999 -0.20918221  0.036728838
> cacheSolve(testMat)
getting cached data
            [,1]         [,2]        [,3]        [,4]         [,5]
[1,] -0.14461980  0.032424677  0.18479197  0.25796270 -0.231850789
[2,] -0.12453372  0.000143472 -0.11865136  0.02769010  0.189239598
[3,]  0.05308465  0.093256815 -0.12338594 -0.00143472  0.005738881
[4,] -0.16241033  0.103873745  0.09641320  0.04763271  0.009469154
[5,]  0.33974175 -0.203156385  0.01032999 -0.20918221  0.036728838
</code></pre>
Verifying that this is indeed testMat's inverse is a trivial exercise for the reader.
