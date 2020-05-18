# simple_harris_corner_detector
A implementation of harris corner detector in matlab, and comparison with the matlab built-in

Acknowledgement: The my implementation was inspired by Prof. Hongdong Li, ANU

# The concept
There are two key steps to get the corner function working. First is to compute the
corner response, which can be done by using the existing Ix2, Iy2 and Ixy. Note that once we
have M, the corner response can be easily computed from its determinant and trace.

Once we have the corner respond, then we need to apply non-maximum suppression and
thresholding on it, so that we can find out the important corner points. To apply nonmaximum
suppression, we can use the built-in matlab function ordfilt2.

Four images are processed by the built-in matlab corner function.
Moreover, my result has been compared with the result generated from the built-in function.

![comparison](https://i.imgur.com/3ql699J.png)
![comparison](https://i.imgur.com/1pSw8G8.png)
![comparison](https://i.imgur.com/mc2aYin.png)
![comparison](https://i.imgur.com/4Ca4NH9.png)

From the above comparison, we can find that my own corner function generally has a better
performance as more corners are detected in my result.

Note that the parameters (k, sigma, thresholding, and filter size for non-maximum suppression) could significantly affect the performance.