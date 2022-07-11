// CPP program to demonstrate memset
#include <iostream>
#include <cstring>
#include <stdio.h>

// Driver Code
int main()
{
	char str[] = "geeksforgeeks";
	memset(str, 't', 4);
	std::cout << str;
	return 0;
}
