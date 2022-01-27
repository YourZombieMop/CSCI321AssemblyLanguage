/* 
 * Description: Write a C/C++ program which simulates a menu-based binary number
 *  calculator. This should be able to convert a binary string to a corresponding
 *  positive integer, convert a positive integer to its binary representation,
 *  and add two binary number strings.
 * Professor: Dr. Anas Hourani
 * Student: Matthew Boyea
 * Start Date: 1/24/2022
 * End Date: 1/26/2022
*/

#include <iostream>
#include <string>
#include <cassert>
#include <cmath>

using namespace std;

// precondition: s is a string that consists of only 0s and 1s
// postcondition: the positive decimal integer that is represented by s
int binary_to_decimal(string s);

// precondition: n is a positive integer
// postcondition: n's binary representation is returned as a string of 0s and 1s
string decimal_to_binary(int n);

// precondition: b1 and b2 are strings that consists of 0s and 1s, i.e.
//               b1 and b2 are binary representations of two positive integers
// postcondition: the sum of b1 and b2 is returned. For instance,
//  if b1 = "11", b2 = "01", then the return value is "100"
string add_binaries(string b1, string b2);

// display the menu. Student shall not modify this function
void menu();

// returns an integer that represents the student's grade of this projects.
// Student shall NOT modify
int grade();

// returns true if the given string s consists of only 0s and 1s; false otherwise
bool is_binary(string b);

// returns true if the student's implementation of binary_to_decimal function
// is correct; false otherwise. Student shall not modify this function
bool test_binary_to_decimal();

//  returns true if the student's implementation of decimal_to_binary function is correct; false otherwise. Student shall not modify this function
bool test_decimal_to_binary();

// which returns true if the student's implementation of add_binaries function
// is correct; false otherwise. Student shall not modify this function
bool test_add_binaries();

int main()
{
    int choice;
    string b1, b2;
    int x, score;
    do
    {
        // display menu
        menu();
        cout << "Enter your choice: ";
        cin >> choice;
        // based on choice to perform tasks
        switch (choice)
        {
        case 1:
            cout << "Enter a binary string: ";
            cin >> b1;
            if (!is_binary(b1))
                cout << "It is not a binary number\n";
            else
                cout << "Its decimal value is: " << binary_to_decimal(b1) << endl;
            break;

        case 2:
            cout << "Enter a positive integer: ";
            cin >> x;
            if (x < 0)
                cout << "It is not a positive integer" << endl;
            else
                cout << "Its binary representation is: " << decimal_to_binary(x) << endl;
            break;

        case 3:
            cout << "Enter two binary numbers, separated by white space: ";
            cin >> b1 >> b2;
            if (!is_binary(b1) || !is_binary(b2))
                cout << "At least one number is not a binary" << endl;
            else
                cout << "The sum is: " << add_binaries(b1, b2) << endl;
            break;

        case 4:
            score = grade();
            cout << "If you turn in your project on blackboard now, you will get " << score << " out of 10" << endl;
            cout << "Your instructor will decide if one-two more points will be added or not based on your program style, such as good commnets (1 points) and good efficiency (1 point)" << endl;
            break;

        case 5:
            cout << "Thanks for using binary calculator program. Good-bye" << endl;
            break;
        default:
            cout << "Wrong choice. Please choose 1-5 from menu" << endl;
            break;
        }

    } while (choice != 5);
    return 0;
}

int binary_to_decimal(string s)
{
    int n = 0;
    // for every bit from left to right
    for (unsigned int i = 0; i < s.length(); i++) {
        // if the bit is != to '0', add 2^(length-1-index) to n
        n += (int)(s[i] != '0') * pow(2, s.length() - 1 - i);
    }
    return n;
}

string decimal_to_binary(int n)
{
    // handle "0" case
    if (n == 0) {
        return "0";
    }
    string s = "";
    int quotient = n;
    // repeatedly divide quotient / 2 and insert the remainder at the
    // front of the binary number until the quotient is equal to 0
    while(quotient != 0) {
        s.insert(0, 1, '0' + quotient % 2);
        quotient /= 2;
    }
    return s;
}

string add_binaries(string b1, string b2)
{
    // NOTE: I could make this function more efficient, but it would
    //  be at the cost of readability. Because this is a class project,
    //  I prioritized readability.
    // set sum to = b1
    string sum = string(b1);
    // for every index of b2
    for (unsigned int i = 0; i < b2.length(); i++) {
        // if index is out of range of sum
        if (i >= sum.length()) {
            // insert the rest of b2 at the front of sum
            sum.insert(0, b2.substr(0, b2.length() - i));
            break;
        }
        // if the next digit of b2 (from right to left) is a '1'
        if (b2[b2.length() - 1 - i] == '1') {
            // "carry the 1" until a '0' is found in sum
            for (unsigned int j = 1; true; j++) {
                if (sum.length() < j + i) {
                    // index is out of bounds
                    // a '0' was not found in sum
                    // place the '1' at the front of sum
                    sum.insert(0, 1, '1');
                    break;
                }
                if (sum[sum.length() - j - i] == '0') {
                    // index was equal to '0'
                    // place the '1' at the '0'
                    sum[sum.length() - j - i] = '1';
                    break;
                }
                // index was equal to '1'
                // carry the '1' and set this index to '0'
                sum[sum.length() - j - i] = '0';
            }
        }
    }
    return sum;
}

void menu()
{
    cout << "******************************\n";
    cout << "*          Menu              *\n";
    cout << "* 1. Binary to Decimal       *\n";
    cout << "* 2. Decimal to Binary       *\n";
    cout << "* 3. Add two Binaries        *\n";
    cout << "* 4. Grade                   *\n";
    cout << "* 5. Quit                    *\n";
    cout << "******************************\n";
}

int grade()
{
    int result = 0;
    // binary_to_decimal function worth 3 points
    if (test_binary_to_decimal())
    {
        cout << "binary_to_decimal function pass the test" << endl;
        result += 3;
    }
    else
        cout << "binary_to_decimal function failed" << endl;

    // decinal_to_binary function worth 2 points
    if (test_decimal_to_binary())
    {
        cout << "decimal_to_binary function pass the test" << endl;
        result += 2;
    }
    else
        cout << "decimal_to_binary function failed" << endl;
    // add_binaries function worth 3 points
    if (test_add_binaries())
    {
        cout << "add_binaries function pass the test" << endl;
        result += 3;
    }
    else
        cout << "add_binaries function pass failed" << endl;
    return result;
}

bool is_binary(string s)
{
    for (unsigned int i = 0; i < s.length(); i++)
        if (s[i] != '0' && s[i] != '1') // one element in s is not '0' or '1'
            return false;               // then it is not a binary nunber representation
    return true;
}

bool test_binary_to_decimal()
{
    if (binary_to_decimal("0") != 0 || binary_to_decimal("1") != 1)
        return false;
    if (binary_to_decimal("010") != 2 || binary_to_decimal("10") != 2)
        return false;
    if (binary_to_decimal("01101") != 13 || binary_to_decimal("1101") != 13)
        return false;
    return true;
}

bool test_decimal_to_binary()
{
    if (decimal_to_binary(0) != "0" || decimal_to_binary(1) != "1")
        return false;
    if (decimal_to_binary(2) != "10" || decimal_to_binary(13) != "1101")
        return false;
    return true;
}

bool test_add_binaries()
{
    if (add_binaries("0", "0") != "0")
        return false;
    if (add_binaries("0", "110101") != "110101")
        return false;
    if (add_binaries("1", "110111") != "111000")
        return false;
    if (add_binaries("101", "111011") != "1000000")
        return false;
    return true;
}