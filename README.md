Hi, 

This is Zhao-dong Meng. I have been struggling with the issue of how to read and write AFM/s-SNOM image with MATLAB. Now I figure it out and offer a solution for you.

You can use the function ReadGsfFile to read your file. 
The data and comment about the file would be easy to access. The function AcqParamInfo is used to acquire the fields of the parameters.
When the data is after post-processing with your code, you can use the SaveGsfFile to save your results.

Enjoy the data :)
