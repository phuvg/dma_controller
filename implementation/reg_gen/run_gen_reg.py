#! /usr/bin/python
"""
Viet Nam - Jun 02, 2023
Created by Phu Vuong
"""


###############################################################
##### import
###############################################################
import csv
from datetime import date
from reg import *


###############################################################
##### config
###############################################################
file_output = "../rtl/dma_reg.v"
file_reg_def = "./reg_def.csv"

file_fixed_interface = "./generate_sample/declare_input_output_fixed.txt"
file_field_interface = "./generate_sample/declare_output_field.txt"
file_internal_signal = "./generate_sample/declare_path.txt"
file_internal_read_path = "./generate_sample/declare_path_read.txt"
file_param = "./generate_sample/declare_parameter.txt"

file_note_select_path = "./generate_sample/note_select_path.txt"
file_select_path = "./generate_sample/select_path.txt"
file_note_write_path = "./generate_sample/note_write_path.txt"
file_write_path = "./generate_sample/write_path.txt"
file_read_path = "./generate_sample/read_path.txt"


###############################################################
##### global variables
###############################################################
MODULE = "module dma_reg("
CLOSE_MODULE = ")"
ENDMODULE = "endmodule"

REG_FIRST = 0
REG_ADDR = 1
REG_NAME = 2
REG_DEFAULT_VALUE = 3
REG_PROPERTY = 4
REG_DESCRIPTION = 5

STR_ADDR = "@reg_addr@"
STR_NAME = "@reg_name@"
STR_FIELD = "@reg_field@"
STR_DEFAULT = "@default_value@"

REGTYPE_RW = "r/w"
REGTYPE_RO = "ro"

###############################################################
##### def
###############################################################
def comment_string(sel):
    tmp = ""
    if(sel == 0):
        tmp += "////////////////////////////////////////////////////////////////////////////////\n"
        tmp += "// Filename    : dma_reg.v\n"
        tmp += "// Description :\n"
        tmp += "//\n"
        tmp += "// Author      : Phu Vuong\n"
        tmp += "// History     : " + str(date.today()) + " : last update\n"
        tmp += "//\n"
        tmp += "////////////////////////////////////////////////////////////////////////////////\n"
    elif(sel == 1):
        tmp += "    ////////////////////////////////////////////////////////////////////////////\n"
        tmp += "    //pin - port declaration\n"
        tmp += "    ////////////////////////////////////////////////////////////////////////////\n"
    elif(sel == 2):
        tmp += "    ////////////////////////////////////////////////////////////////////////////\n"
        tmp += "    //wire - reg name declaration\n"
        tmp += "    ////////////////////////////////////////////////////////////////////////////\n"
    elif(sel == 3):
        tmp += "    ////////////////////////////////////////////////////////////////////////////\n"
        tmp += "    //design description\n"
        tmp += "    ////////////////////////////////////////////////////////////////////////////\n"
    elif(sel == 4):
        tmp += "    ////////////////////////////////////////////////////////////////////////////\n"
        tmp += "    //parameter declaration\n"
        tmp += "    ////////////////////////////////////////////////////////////////////////////\n"
    return tmp

def is_addr_row(row):
    if(not row[REG_FIRST] == "#"):
        return False
    if(not row[REG_ADDR].startswith("addr = ")):
        return False
    return True

def is_reg_field(row):
    if(row[REG_FIRST] == "#"):
        return False
    if(len(row[REG_ADDR])==0 and len(row[REG_NAME])==0 and len(row[REG_DEFAULT_VALUE])==0 and len(row[REG_PROPERTY])==0 and len(row[REG_DESCRIPTION])>=0):
        return False
    if(len(row[REG_ADDR])==0 or len(row[REG_NAME])==0 or len(row[REG_DEFAULT_VALUE])==0 or len(row[REG_PROPERTY])==0):
        print(">>>> run_gen_reg >> ERROR >> is_reg_field")
        print(row)
        quit()
    return True

def read_reg_def():
    print(">>>> read_reg_def >> run...")
    list_reg = [] #--> list register
    #--> open reg_def.csv
    with open(file_reg_def) as freg:
        #--> csv reader
        reader = csv.reader(freg)
        #--> read row by row
        for row in reader:
            #--> if addr line
            if(is_addr_row(row)):
                new_reg = Reg(row[REG_ADDR].replace("addr = ", ""), row[REG_NAME]) #--> create new register
                list_reg.append(new_reg) #--> add to list_reg
                continue
            #--> if meaning register field
            if(is_reg_field(row)):
                list_reg[len(list_reg)-1].add_field(row[REG_ADDR], row[REG_NAME], row[REG_DEFAULT_VALUE], row[REG_PROPERTY]) #--> add field to register
    print(">>>> read_reg_def >> end")
    return list_reg

def add_level_line(line, n):
    tmp = ""
    for i in range(0, n, 1):
        tmp += "    "
    return tmp + line

def gen_tab(n):
    tmp = ""
    for i in range(0, n, 1):
        tmp += "\t"
    return tmp

def read_fixed_reg_interface():
    print(">>>> read_fixed_reg_interface >> run...")
    list_fixed_reg_interface = [] #--> return list
    #-->open file
    with open(file_fixed_interface, "r") as fin:
        #--> read line by line
        for line in fin:
            if(line.startswith("reg_")):
                new_line = line.split("\n")[0] + "," + "\n"
                list_fixed_reg_interface.append(add_level_line(new_line, 1))
            else:
                list_fixed_reg_interface.append(add_level_line(line, 1))
    print(">>>> read_fixed_reg_interface >> end")
    return list_fixed_reg_interface

def list_output_field(list_reg):
    print(">>>> declare_output_field >> run...")
    list_field_output_interface = []
    #--> read list_reg
    for i in range(0, len(list_reg), 1):
        #--> open file_field_interface
        with open(file_field_interface, "r") as fin:
            cnt = 1 #--> counter
            for line in fin:
                #--> dass
                if(cnt == 1):
                    list_field_output_interface.append(add_level_line(line, 1)) #--> append line with tab
                    cnt += 1 #--> update counter
                    continue
                #--> addr
                if(cnt == 2):
                    line = line.replace(STR_ADDR, list_reg[i].addr) #--> replace reg_addr
                    list_field_output_interface.append(add_level_line(line, 1)) #--> append line with tab
                    cnt += 1 #--> update counter
                    continue
                #-->read list field
                for j in range(0, len(list_reg[i].list_field), 1):
                    #--> if field type is read/write
                    if(list_reg[i].list_field[j].reg_property == REGTYPE_RW):
                        temp = line.replace(STR_NAME, list_reg[i].name) #--> replace reg_name
                        temp = temp.replace(STR_FIELD, list_reg[i].list_field[j].name) #--> replace reg_field
                        if(not (i==len(list_reg)-1 and j==len(list_reg[i].list_field)-1)):
                            temp += ",\n" #--> add commas and enter if not the last signal
                        list_field_output_interface.append(add_level_line(temp, 1)) #--> append line with tab
            #--> add empty line
            list_field_output_interface.append("\n")
    print(">>>> declare_output_field >> end")
    return list_field_output_interface

def declare_parameter():
    print(">>>> declare_parameter >> run...")
    list_parameter = []
    #--> open file_param
    with open(file_param, "r") as fin:
        for line in fin:
            list_parameter.append(add_level_line(line, 1))
    print(">>>> declare_parameter >> end")
    return list_parameter

def declare_register_interface():
    print(">>>> declare_register_interface >> run...")
    list_declare_reg_interface = []
    #--> open file_fixed_interface
    with open(file_fixed_interface, "r") as fin:
        #-->read line by line
        for line in fin:
            line = line.split("\n")[0]
            #--> if comment line
            if(line.startswith("//")):
                list_declare_reg_interface.append(add_level_line(line, 1) + "\n") #--> append line with tab level
            #--> signal line
            else:
                #--> input
                if(line.endswith("_i")):
                    tmp = line.replace("_i", "") #--> remove _i
                    #--> rd_en / wr_en
                    if(tmp.endswith("_en")):
                        line = "input" + gen_tab(9) + line + ";\n"
                        list_declare_reg_interface.append(add_level_line(line, 1)) #--> append line with tab level
                    #--> addr
                    elif(tmp.endswith("_addr")):
                        line = "input" + gen_tab(1) + "[ADDR_WIDTH-1:0]" + gen_tab(4) + line + ";\n"
                        list_declare_reg_interface.append(add_level_line(line, 1)) #--> append line with tab level
                    #--> data
                    elif(tmp.endswith("_data")):
                        line = "input" + gen_tab(1) + "[DATA_WIDTH-1:0]" + gen_tab(4) + line + ";\n"
                        list_declare_reg_interface.append(add_level_line(line, 1)) #--> append line with tab level
                    #--> error format
                    else:
                        print(">>>> declare_register_interface >> ERROR >> not correct format pin")
                        quit()
                #--> output
                elif(line.endswith("_o")):
                    line = "output" + gen_tab(1) + "[DATA_WIDTH-1:0]" + gen_tab(4) + line + ";\n"
                    list_declare_reg_interface.append(add_level_line(line, 1)) #--> append line with tab level
                #--> error format
                else:
                    print(">>>> declare_register_interface >> ERROR >> not correct format pin/port")
                    quit()
    print(">>>> declare_register_interface >> end")
    return list_declare_reg_interface

def declare_register_field_interface(list_reg):
    print(">>>> declare_register_field_interface >> run...")
    list_declare_reg_field_interface = []
    #--> read reg
    for reg in list_reg:
        #--> open file_field_interface
        with open(file_field_interface, "r") as fin:
            #--> read line by line
            for line in fin:
                line = line.split("\n")[0] #--> remove "\n"
                #--> if comment line
                if(line.startswith("//")):
                    line = line.replace(STR_ADDR, reg.addr) + ";\n" #--> replace reg_addr
                    list_declare_reg_field_interface.append(add_level_line(line, 1)) #--> append line with tab level
                #--> register field
                else:
                    #--> read list_field
                    for field in reg.list_field:
                        #--> if field type is read/write mode
                        if(field.reg_property == REGTYPE_RW):
                            tmp = line.replace(STR_NAME, reg.name) #--> replace reg_name
                            tmp = tmp.replace(STR_FIELD, field.name) #--> replace reg_field
                            #--> if > 1 bit
                            if(field.width.startswith("[") and field.width.endswith("]")):
                                tmp = "output" + gen_tab(1) + field.width + gen_tab(7) + tmp + ";\n"
                                list_declare_reg_field_interface.append(add_level_line(tmp, 1))
                            #--> if 1 bit
                            else:
                                tmp = "output" + gen_tab(9) + tmp + ";\n"
                                list_declare_reg_field_interface.append(add_level_line(tmp, 1))
        #--> before go to next register, add empty line
        list_declare_reg_field_interface.append("\n")
    print(">>>> declare_register_field_interface >> end")
    return list_declare_reg_field_interface

def declare_reg_read_signal():
    print(">>>> declare_reg_read_signal >> run...")
    list_reg_read_signal = []
    #--> open file_internal_read_path
    with open(file_internal_read_path, "r") as fin:
        #--> read line by line
        for line in fin:
            list_reg_read_signal.append(add_level_line(line, 1)) #--> append line with tab level
    print(">>>> declare_reg_read_signal >> end")
    return list_reg_read_signal

def is_all_read_only(list_field):
    for field in list_field:
        if(field.reg_property == "r/w"):
            return False
    return True

def declare_internal_signal(list_reg):
    print(">>>> declare_internal_signal >> run...")
    list_declare_internal_signal = []
    #--> read reg
    for reg in list_reg:
        #--> open file_internal_signal
        with open(file_internal_signal, "r") as fin:
            #--> read line by line
            for line in fin:
                line = line.split("\n")[0] #--> remove "\n"
                #--> if comment line
                if(line.startswith("//")):
                    line = line.replace(STR_ADDR, reg.addr) + ";\n" #--> replace reg_addr
                    list_declare_internal_signal.append(add_level_line(line, 1)) #--> append line with tab level
                #--> if select signal line
                elif(line.endswith("_sel")):
                    line = line.replace(STR_NAME, reg.name) + ";\n" #--> replace reg_name
                    line = "wire" + gen_tab(9) + line;
                    list_declare_internal_signal.append(add_level_line(line, 1)) #--> append line with tab level
                #--> if read enable line
                elif(line.endswith("_rd_en")):
                    line = line.replace(STR_NAME, reg.name) + ";\n" #--> replace reg_name
                    line = "wire" + gen_tab(9) + line;
                    list_declare_internal_signal.append(add_level_line(line, 1)) #--> append line with tab level
                #--> if write enable line
                elif(line.endswith("_wr_en")):
                    #--> if not all field is read only
                    if(not is_all_read_only(reg.list_field)):
                        line = line.replace(STR_NAME, reg.name) + ";\n" #--> replace reg_name
                        line = "wire" + gen_tab(9) + line;
                        list_declare_internal_signal.append(add_level_line(line, 1)) #--> append line with tab level
                #--> each field declare
                else:
                    #--> read list_field
                    for field in reg.list_field:
                        #--> if field type == "r/w"
                        if(field.reg_property == REGTYPE_RW):
                            tmp = line.replace(STR_NAME, reg.name) #--> replace reg_name
                            tmp = tmp.replace(STR_FIELD, field.name) #--> replace reg_field
                            header = "reg\t"
                            #--> if next signal = wire, current signal = reg (default)
                            if(tmp.startswith("nxt_")):
                                header = "wire"
                            #--> if > 1 bit
                            if(field.width.startswith("[") and field.width.endswith("]")):
                                tmp = header + gen_tab(1) + field.width + gen_tab(7) + tmp + ";\n"
                                list_declare_internal_signal.append(add_level_line(tmp, 1))
                            #--> if 1 bit
                            else:
                                tmp = header + gen_tab(9) + tmp + ";\n"
                                list_declare_internal_signal.append(add_level_line(tmp, 1))
        #--> before go to next register, add empty line
        list_declare_internal_signal.append("\n")
    print(">>>> declare_internal_signal >> end")
    return list_declare_internal_signal

def descript_selection_path(list_reg):
    print(">>>> descript_selection_path >> run...")
    list_selection_path = []
    #--> read reg
    for reg in list_reg:
        #--> open file_note_select_path
        with open(file_note_select_path, "r") as fin:
            #--> read line by line
            for line in fin:
                line = line.split("\n")[0] #--> remove "\n"
                line = line.replace(STR_ADDR, reg.addr) + "\n" #--> replace reg_addr
                list_selection_path.append(add_level_line(line, 1)) #--> append line with tab level
        #--> open file_select_path
        with open(file_select_path, "r") as fin:
            cnt = 0
            #--> read line by line
            for line in fin:
                cnt += 1 #--> update counter
                #--> if select signal line
                if(cnt == 1):
                    tmp = line.replace(STR_ADDR, reg.addr[2:]) #--> replace reg_addr removed 0x
                    tmp = tmp.replace(STR_NAME, reg.name) #--> replace reg_name
                    list_selection_path.append(add_level_line(tmp, 1)) #--> append line with tab level
                #--> if read enable line
                elif(cnt == 2):
                    line = line.replace(STR_NAME, reg.name) #--> replace reg_name
                    list_selection_path.append(add_level_line(line, 1)) #--> append line with tab level
                #--> if write enable line
                elif(cnt == 3):
                    #--> if not all field is read only
                    if(not is_all_read_only(reg.list_field)):
                        line = line.replace(STR_NAME, reg.name) + "\n" #--> replace reg_name
                        list_selection_path.append(add_level_line(line, 1)) #--> append line with tab level
        #--> before go to next register, add empty line
        list_selection_path.append("\n")
    print(">>>> descript_selection_path >> end")
    return list_selection_path

def descript_write_path(list_reg):
    print(">>>> descript_write_path >> run...")
    list_write_path = []
    #--> read reg
    for reg in list_reg:
        bypass_add_empty = False
        #--> open file_note_write_path
        with open(file_note_write_path, "r") as fin:
            #--> if not all field is read only
            if(not is_all_read_only(reg.list_field)):
                bypass_add_empty = True
                for line in fin:
                    line = line.split("\n")[0] #--> remove "\n"
                    line = line.replace(STR_ADDR, reg.addr) + "\n" #--> replace reg_addr
                    list_write_path.append(add_level_line(line, 1)) #--> append line with tab level
        #--> open file_write_path
        with open(file_write_path, "r") as fin:
            #--> if not all field is read only
            if(not is_all_read_only(reg.list_field)):
                #--> read line by line
                for line in fin:
                    #--> if replace line: replace
                    if(line.count(STR_NAME) > 0):
                        #--> read list field
                        for field in reg.list_field:
                            #--> if field type = read/write mode
                            if(field.reg_property == REGTYPE_RW):
                                tmp = line.replace(STR_NAME, reg.name) #--> replace reg_name
                                tmp = tmp.replace(STR_FIELD, field.name) #--> replace reg_field
                                tmp = tmp.replace(STR_DEFAULT, field.default_value) #--> replace default_value
                                list_write_path.append(add_level_line(tmp, 1))
                    #--> else: keep line
                    else:
                        list_write_path.append(add_level_line(line, 1)) #--> append line with tab level
        #--> before go to next register, add empty line
        if(bypass_add_empty):
            list_write_path.append("\n")
    print(">>>> descript_write_path >> end")
    return list_write_path

def descript_read_path(list_reg):
    print(">>>> descript_read_path >> run...")
    list_read_path = []
    #--> open file_read_path
    with open(file_read_path, "r") as fin:
        #--> read line by line
        for line in fin:
            #--> if replace line
            if(line.count(STR_ADDR) > 0):
                #--> read list_reg
                for reg in list_reg:
                    tmp = line.replace(STR_ADDR, reg.addr) #--> replace reg_addr
                    #--> read list_field
                    for i in range(0, len(reg.list_field), 1):
                        #--> if not last field
                        if(i < len(reg.list_field)-1):
                            #--> if read only field
                            if(reg.list_field[i].reg_property == REGTYPE_RO):
                                tmp = tmp.replace(STR_NAME + "_" + STR_FIELD, (reg.list_field[i].default_value + ", " + STR_NAME + "_" + STR_FIELD), 1) #--> replace default value
                            else:
                                tmp = tmp.replace(STR_NAME, reg.name) #--> replace reg_name
                                tmp = tmp.replace(STR_FIELD, (reg.list_field[i].name + ", " + STR_NAME + "_" + STR_FIELD), 1) #--> replace reg_field
                        #--> if last field
                        else:
                            #--> if read only field
                            if(reg.list_field[i].reg_property == REGTYPE_RO):
                                tmp = tmp.replace(STR_NAME + "_" + STR_FIELD, reg.list_field[i].default_value, 1) #--> replace default value
                                list_read_path.append(add_level_line(tmp, 1))
                            else:
                                tmp = tmp.replace(STR_NAME, reg.name) #--> replace reg_name
                                tmp = tmp.replace(STR_FIELD, reg.list_field[i].name, 1) #--> replace reg_field
                                list_read_path.append(add_level_line(tmp, 1))
            else:
                list_read_path.append(add_level_line(line, 1)) #--> append line with tab level
    print(">>>> descript_read_path >> end")
    return list_read_path

def create_dma_reg( list_reg,\
                    list_fixed_reg_interface,\
                    list_field_output_interface,\
                    list_declare_reg_interface,\
                    list_declare_reg_field_interface,\
                    list_declare_internal_signal,\
                    list_selection_path,\
                    list_write_path,\
                    list_parameter,\
                    list_reg_read_signal,\
                    list_read_path):
    print(">>>> create_dma_reg >> run...")
    list_line = [] #--> coding line
    
    #--> comment header
    list_line.append(comment_string(0))
    
    #--> module
    list_line.append(MODULE + "\n")
    
    #--> fixed register interface (1)
    for line in list_fixed_reg_interface:
        list_line.append(line)
    
    #--> add empty line
    list_line.append("\n")
    
    #--> register field output (2)
    for line in list_field_output_interface:
        list_line.append(line)
    
    #--> close parentheses
    list_line.append(");\n")

    #--> comment parameter
    list_line.append(comment_string(4))
    
    #--> declare parameter (8)
    for line in list_parameter:
        list_line.append(line)
    
    #--> add empty line
    list_line.append("\n")

    #--> comment pin/port
    list_line.append(comment_string(1))

    #--> declare pin/port register interface (3)
    for line in list_declare_reg_interface:
        list_line.append(line)

    #--> declare register field interface (4)
    for line in list_declare_reg_field_interface:
        list_line.append(line)

    #--> comment wire/reg
    list_line.append(comment_string(2))

    #--> declare internal signal (5)
    for line in list_declare_internal_signal:
        list_line.append(line)

    #--> delare internal read signal (9)
    for line in list_reg_read_signal:
        list_line.append(line)


    #--> comment design description
    list_line.append(comment_string(3))

    #--> descript selection path (6)
    for line in list_selection_path:
        list_line.append(line)

    #--> descript write path (7)
    for line in list_write_path:
        list_line.append(line)

    #--> descript read path (10)
    for line in list_read_path:
        list_line.append(line)
    
    #--> endmodule
    list_line.append(ENDMODULE)
    
    #--> return
    print(">>>> create_dma_reg >> end")
    return list_line

def write_dma_reg(list_line):
    #--> open file_output
    with open(file_output, "w") as fout:
        for line in list_line:
            fout.write(line)



###############################################################
##### main
###############################################################
def main():
    #put code here
    print("main")
    
    #--> get list register (0)
    list_reg = read_reg_def()
    #print(len(list_reg))
    
    #--> get list_fixed_reg_interface (1)
    list_fixed_reg_interface = read_fixed_reg_interface()
    #print(list_fixed_reg_interface)
    
    #--> get list_field_output_interface (2)
    list_field_output_interface = list_output_field(list_reg)
    
    #--> get list_declare_reg_interface (3)
    list_declare_reg_interface = declare_register_interface()

    #--> get list_declare_reg_field_interface (4)
    list_declare_reg_field_interface = declare_register_field_interface(list_reg)

    #--> get list_declare_internal_signal (5)
    list_declare_internal_signal = declare_internal_signal(list_reg)

    #--> get list_selection_path (6)
    list_selection_path = descript_selection_path(list_reg)

    #--> get list_write_path (7)
    list_write_path = descript_write_path(list_reg)

    #--> get list_parameter (8)
    list_parameter = declare_parameter();

    #--> get list_reg_read_signal (9)
    list_reg_read_signal = declare_reg_read_signal();

    #--> get list_read_path (10)
    list_read_path = descript_read_path(list_reg)
    
    #--> get line
    list_line = create_dma_reg( list_reg,                               #(0)
                                list_fixed_reg_interface,               #(1)
                                list_field_output_interface,            #(2)
                                list_declare_reg_interface,             #(3)
                                list_declare_reg_field_interface,       #(4)
                                list_declare_internal_signal,           #(5)
                                list_selection_path,                    #(6)
                                list_write_path,                        #(7)
                                list_parameter,                         #(8)
                                list_reg_read_signal,                   #(9)
                                list_read_path                          #(10)
    )
    #for line in list_line:
    #    print(line)
    
    #--> write output
    write_dma_reg(list_line)

if __name__ == "__main__":
    main()
