#include <iostream> 
#include <bitset>
#include <fstream>
#include <cstdlib>
#include <sstream>
using namespace std;

void R(string &rs, string &rt, string &rd);  //done
void I(string &rs, string &rt);               //done
void reg_name_to_num(string &reg);          //done
void split_as_r(string line, string &type, string &rs, string &rt, string &rd);               // should return type rs rt rd
void split_as_i(string line, string &type, string &rs, string &rt, string &im);               // shoud return type rs rt im
void split_as_j(string line, string &type, string &label);                // should return type label
void get_labels(string(&line)[100], string(&label)[100][2]); // create a table of labels and their adreeses and remove them from the original string 
void label2binary(string &label);  // search the table of label and convert the label string to binary string (adreess)
string read(string(&line)[100]);  //done


string read(string(&line)[100])
{
	cout << "please enter file name :";
	string file;
	cin >> file;
	cout << "\n";
	ifstream myfile;
	myfile.open(file);
	int i = 0;
	if (!myfile.is_open()) cout << "error loading file";
	getline(myfile, line[0]);
	while (myfile.good())
	{
		i++;
		getline(myfile, line[i]);;
	}
	myfile.close();
	return file;
}
void reg_name_to_num(string &rs)  //takes register name (ie. $s2) and returns in binary addres (ie 10010)
{
	if (rs == "$0") rs = "00000";
	else if (rs == "$at") rs = "00001";
	else if (rs == "$v0") rs = "00010";
	else if (rs == "$v1") rs = "00011";
	else if (rs == "$a0") rs = "00100";
	else if (rs == "$a1") rs = "00101";
	else if (rs == "$a2") rs = "00110";
	else if (rs == "$a3") rs = "00111";
	else if (rs == "$t0") rs = "01000";
	else if (rs == "$t1") rs = "01001";
	else if (rs == "$t2") rs = "01010";
	else if (rs == "$t3") rs = "01011";
	else if (rs == "$t4") rs = "01100";
	else if (rs == "$t5") rs = "01101";
	else if (rs == "$t6") rs = "01110";
	else if (rs == "$t7") rs = "01111";
	else if (rs == "$s0") rs = "10000";
	else if (rs == "$s1") rs = "10001";
	else if (rs == "$s2") rs = "10010";
	else if (rs == "$s3") rs = "10011";
	else if (rs == "$s4") rs = "10100";
	else if (rs == "$s5") rs = "10101";
	else if (rs == "$s6") rs = "10110";
	else if (rs == "$s7") rs = "10111";
	else if (rs == "$t8") rs = "11000";
	else if (rs == "$t9") rs = "11001";
	else if (rs == "$k0") rs = "11010";
	else if (rs == "$k1") rs = "11011";
}
void I(string &rs, string &rt)

{
	reg_name_to_num(rs);
	reg_name_to_num(rt);
}
void R(string &rs, string &rt, string &rd)
{
	reg_name_to_num(rs);
	reg_name_to_num(rt);
	reg_name_to_num(rd);
}
void get_labels(string(&line)[100], string(&label)[100][2])
{
	int i = 0;
	int z = 0;

	while (line[i] != "")
	{

		istringstream iss(line[i]);
		int j = 0;
		string part[5] = { "", "", "", "", "" };
		do
		{

			iss >> part[j];
			j++;
		} while (iss);
		if (part[0] == "add" || part[0] == "addi" || part[0] == "lw" || part[0] == "sw" || part[0] == "slt" || part[0] == "sll" || part[0] == "and" || part[0] == "andi" || part[0] == "or" || part[0] == "ori" || part[0] == "nor" || part[0] == "beq" || part[0] == "jal" || part[0] == "jr" || part[0] == "j"){}
		else
		{
			label[z][1] = part[0];
			label[z++][0] = to_string(i);
			line[i] = part[1] + " " + part[2] + " " + part[3] + " " + part[4];
		}

		i++;
	}
}
void split_as_r(string line, string &type, string &rs, string &rt, string &rd)
{
	istringstream iss(line);
	int j = 0;
	string part[4] = { "", "", "", "" };
	do
	{
		iss >> part[j];
		j++;
	} while (iss);
	type = part[0];
	rd = part[1];
	rs = part[2];
	rt = part[3];
}
void split_as_i(string line, string &type, string &rs, string &rt, string &im)
{
	istringstream iss(line);
	int j = 0;
	string part[4] = { "", "", "", "" };
	do
	{
		iss >> part[j];
		j++;
	} while (iss);
	type = part[0];
	rt = part[1];
	rs = part[2];
	im = part[3];
}
void split_as_j(string line, string &type, string &label)
{
	istringstream iss(line);
	int j = 0;
	string part[2] = { "", "" };
	do
	{
		iss >> part[j];
		j++;
	} while (iss);
	type = part[0];
	label = part[1];

}
void label2binary(string &label, string labels[100][2])
{
	int i = 0;
	while (labels[i][1] != "")
	{
		if (label == labels[i][1]) label = labels[i][0];
		i++;
	}
}



void main()
{
	string type, rs, rt, rd, shamt, fn, inst, im, label;
	string line[100];
	string outfile = read(line);  // read input file and return file name
	string labels[100][2];        //intializing a table "2d array" containgin abels and theri adresses
	string bits8 [4];
	get_labels(line, labels);
	ofstream myfile;
	myfile.open(outfile + " machine code.txt");
	ofstream myfile2;
	myfile2.open(outfile + " table of labels and their adresses.txt");
	myfile2 << "labels = adress \n";
	ofstream myfile3;
	myfile3.open(outfile + " assembly code without labels.txt");
	ofstream myfile4;
	myfile4.open(outfile + " machine code(8 bits).txt");

	int i = 0;
	while (line[i] != "")
	{

 		split_as_r(line[i], type, rs, rt, rd);
		if (type == "add" || type == "and" || type == "or" || type == "slt" || type == "nor")
		{
			split_as_r(line[i], type, rs, rt, rd);
			R(rs, rt, rd);                                  //sets  bits [25:11]
			if (type == "add") fn = "100000";              //sets bits [5:0]
			else if (type == "and") fn = "100100";
			else if (type == "nor") fn = "100111";
			else if (type == "or") fn = "100101";
			else if (type == "slt") fn = "101010";
			type = "000000";                                //sets first 6 bits
			inst = type + rs + rt + rd + "00000" + fn;
		}

		else if (type == "jr")
		{
			split_as_r(line[i], type, rs, rt, rd);
			reg_name_to_num(rd);
			inst = "000000" + rd + "000000000000000" + "001000";
		}

		else if (type == "sll")
		{
			split_as_r(line[i], type, rs, rt, rd);
			type = "000000";
			reg_name_to_num(rd);
			reg_name_to_num(rs);
			int x = atoi(rt.c_str());
			bitset <5>  shamt2(x);
			shamt = shamt2.to_string();
			inst = type + "00000" + rs + rd + shamt + "000000";
		}

		else if (type == "addi" || type == "andi" || type == "ori")
		{
			split_as_i(line[i], type, rs, rt, im);
			I(rt, rs);
			int im_int = atoi(im.c_str());                    // convert im from string"int" -> int  
			bitset <16>  im_b(im_int);                         // convert im_int from int ->binary
			string im_bstr = im_b.to_string();                 // convert im_b from binary to string"binary"
			if (type == "addi") type = "001000";
			else if (type == "andi") type = "001100";
			else if (type == "ori") type = "001101";
			inst = type + rs + rt + im_bstr;
		}

		else if (type == "lw" || type == "sw")
		{
			split_as_i(line[i], type, rs, rt, im);
			im = im.substr(1, im.size() - 2);
			I(rt, im);
			int rs_int = atoi(rs.c_str());
			bitset <16>  rs_b(rs_int);
			string rs_bstr = rs_b.to_string();
			if (type == "lw") type = "100011";
			else if (type == "sw") type = "101011";
			inst = type + im + rt + rs_bstr;
		}

		else if (type == "beq")
		{
			split_as_i(line[i], type, rs, rt, im);
			I(rt, rs);
			label2binary (im, labels);
			int im_int = atoi(im.c_str());
			im_int = im_int - (i + 1);
			bitset <16>  im_b(im_int);
			string im_bstr = im_b.to_string();
			inst = "000100" + rs + rt + im_bstr;
		}
		else if (type == "j" || type == "jal")
		{
			split_as_j(line[i], type, label);
			label2binary(label, labels);
			int label_int = atoi(label.c_str());
			bitset <26>  label_b(label_int);
			string label_bstr = label_b.to_string();
			if (type == "j") type = "000010";
			else if (type == "jal") type = "000011";
			inst = type + label_bstr;
		}


		myfile << inst << "\n";
		myfile3 << line[i] << "\n";
		bits8[0] = inst.substr(0, 8);
		bits8[1] = inst.substr(8, 8);
		bits8[2] = inst.substr(16, 8);
		bits8[3] = inst.substr(24, 8);
		myfile4 << bits8[0] << endl << bits8[1] << endl << bits8[2] << endl << bits8[3] << endl;

		i++;
	}
	myfile.close();
	myfile3.close();
	myfile4.close();
	int j = 0;
	while (labels[j][1] != "")
	{
		myfile2 << labels[j][1] << " = " << labels[j][0] << "\n";
		j++;
	}
	myfile2.close();
}