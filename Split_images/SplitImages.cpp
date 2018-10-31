#include<iostream>
#include<fstream>
#include<string>
#include<sstream>
using namespace std;
int main()
{
string configfile;
string im_dir;
string im_out;

string target_dir;
fstream fs;


cout << "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
cout << "%%%%%%%%%%%%%%%%%%%%%%PIV_donkey:Splitimages%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
cout << "%Copyright: Weam Elsahhar & Raf Theunissen - Uiniversity of Bristol			%\n";
cout << "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
cout << "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";

cout << "% Reading configuration file:";
cin >> configfile;
fs.open(configfile);

if (!fs.is_open()){
	cout << "Unable to open file";
	exit(1);// Terminate with error
}

getline(fs,im_dir);		// Get source directory from first line in the text file
cout << "Unsplitted images directory is:" << im_dir;
 
getline(fs,im_out);		// Get target directory from second line in the text file
cout << "\nTarget splitted images directory is:" << im_out;

fs.close();

}
