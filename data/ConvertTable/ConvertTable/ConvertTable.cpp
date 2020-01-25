// ConsoleApplication3.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include "pch.h"
#include <iostream>
#include "tabx.h"
#include "taby.h"

int main()
{
	FILE *outFilex = fopen("../../tabx.txt", "w");
	int i,j;
	for (i = 0; i < 720; i++)
	{
		for (j = 0; j < 1280; j++)
		{
			fprintf(outFilex, "%.6f, ", TABx[i*1280+j]);
		}
		fprintf(outFilex, "\n ");
	}
	fclose(outFilex);
	FILE *outFiley = fopen("../../taby.txt", "w");
	for (i = 0; i < 720; i++)
	{
		for (j = 0; j < 1280; j++)
		{
			fprintf(outFiley, "%.6f, ", TABy[i*1280+j]);
		}
		fprintf(outFiley, "\n ");
	}
	fclose(outFiley);
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
