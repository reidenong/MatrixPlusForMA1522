# Matrix+ for MA1522 in MatLab <br /> <img  src="https://img.shields.io/badge/MATLAB-R2023a-orange"  height="17"  />
In essence, **Matrix+** is a wrapper class in MatLab designed to greatly enhance the functionality of vanilla matrices. By incorporating ready to use algorithms and refining existing functions, **Matrix+** is more efficient and intuitive, and helps improve performance under timed conditions such as exams. 
```
Eg) Performing 3 row operations, then finding it's Least
    Square solution for b:

// Normal MatLab 
>> A(2, :) = A(2, :) - 4*A(1, :);      % R2 -> R2 + 4R1
>> A(3, :) = 3 * A(3, :)               % R3 -> 3*R3
>> A([1,2], :) = A([2,1],:)            % R2 <-> R1
>> null([A'*A A'*b])

// Matrix+ Implementation
>> A.rowOp("R2 += 4R1")          % easily chain functions!
    .rowOp("R3 *= 3")
    .rowOp("R2 <-> R1")
    .leastSquare(b)
```
The key design principles of **Matrix+** are to 

(1) Make code easy to read and interpret with function chaining,

(2) Cut down implementation time for functions, 

(3) Provide a instant answer with workings whenever possible.

<br/> 

**Matrix+** was made over the course of AY23/24 S1 for use in the NUS mod MA1522: Linear Algebra for Computing. Use at your own discretion!

**Read the [User Guide](MatrixPlus_UserGuide_v1.pdf) on how to use Matrix+ in irl contexts with past year exam questions*.*

## Installation Guide
The folder containing scripts should be placed in the MATLAB directory.

For Windows users, place the scriptpack at
```
C:\Users\Your_Name\Documents\MATLAB\MatrixPlus_vX\
```

## About Matrix+
I made this for fun after learning OOP/FP in CS2030s, but realised it was actually a pretty powerful tool, especially due to the ability to chain functions, which allows you to maintain easily readible and highly flexible code in an exam scenario. Main issues faced were in adapting to the MatLab syntax for OOP, as well as in exception handling for the various rubbish people could throw into the arguments. Areas to improve in are mostly in exception handling and greater flexibility/integration between the Matrix+ wrapper as well as vanilla MatLab matrices. 

Feel free to email me about any bugs/improvements to be made.
