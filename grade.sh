CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'
cd student-submission
if  [[ -f "./ListExamples.java" ]]
then 
    echo "ListExamples.java found"
else 
 echo "File is not found, might be wrong name"
 exit 1
fi 
cd ..
cp Server.java student-submission/
cp GradeServer.java student-submission/
cd student-submission



javac ListExamples.java 
if [[ $? -ne 0 ]] 
then 
    echo " ListExamples Compiles bad"
else 
    echo "ListExamples Compiles good"
    
fi


cd ..
cp -r lib student-submission/
cp TestListExamples.java student-submission/
cd student-submission

javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java
if [[ $? -ne 0 ]] 
then 
    echo " Junit fail"
else 
    echo "Junit did its thing"
    
fi
java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples

java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > failures.txt
grep "Failures: 1" failures.txt > failures1.txt
grep "Failures: 2" failures.txt > failures2.txt
if [  "$(wc -w < failures1.txt)" -ne 0 ]
then 
    echo "Score: 1/2"
elif [ "$(wc -w < failures2.txt)" -ne 0  ]
then 
    echo "Score: 0/2"
else
    echo "Score: 2/2"
fi





