#! /usr/bin/python
"""
Viet Nam - Jul 03, 2023
Created by Phu Vuong
"""


###############################################################
##### import
###############################################################
from run_gen_reg import *
import random
"""others are in run_gen_reg.py"""


###############################################################
##### config
###############################################################
file_output = "../tb/tb_dma_reg.v"

path_sample = "./generate_sample/"
path_sample_tb = "./generate_sample/tb/"
file_tb = "./generate_sample/tb/tb_dma_reg.v"
"""others are in run_gen_reg.py"""



###############################################################
##### global variables
###############################################################
"""others are in run_gen_reg.py"""
STR_RANDOM = "@random@"
LIST_RD = [] #--> store written random data

###############################################################
##### def
###############################################################

def is_tb_point_to_other_file(line):
    tmp = line.count("#file_")
    if(tmp > 0):
        return True
    return False

def complete_path(file_pointed):
    if(file_pointed.startswith("tb_")):
        file_pointed = path_sample_tb + file_pointed
    else:
        file_pointed = path_sample + file_pointed
    return file_pointed

def tb_write_param(file_in):
    list_out = []
    #--> open declare_parameter.txt
    with open(file_in, "r") as fin:
        #--> read line by line
        for line in fin:
            list_out.append(add_level_line(line, 1)) #--> append line with tab level
    return list_out

def random_32bit(reg):
    res = ""
    for field in reg.list_field:
        #--> setup nbit (number of bit)
        nbit = 1
        #--> n bit
        if(field.width.startswith("[") and field.width.endswith("]")):
            tmp = field.width.replace("[", "")
            tmp = tmp.replace("]", "")
            nbit = int(tmp.split(":")[0]) - int(tmp.split(":")[1]) + 1
        #--> random
        tmp = "{0:0%sb}" % nbit
        nhex = "0" #--> hex value
        #--> if read only register: default value
        if(field.reg_property == REGTYPE_RO):
            nhex = field.default_value.split("h")[1]
        #--> writable register
        else:
            nhex = str(random.randint(0, ((2**nbit) - 1)))
        res += tmp.format(int(nhex, 10))
    return res

def get_rd(reg, list_rd):
    for rd_dict in list_rd:
        if(rd_dict[STR_ADDR] == reg.addr):
            return rd_dict[STR_RANDOM]
    return "0"

def tb_write_declare_fixed_signal(file_in):
    list_out = []
    #--> open declare_input_output_fixed.txt
    with open(file_in, "r") as fin:
        #--> read line by line
        for line in fin:
            line = line.split("\n")[0] #--> remove \n
            #--> signal line
            if(line.startswith("reg_") and (line.endswith("_i") or line.endswith("_o"))):
                #--> header = reg for input (as default)
                #--> header = wire for output (inside condition)
                header = "reg\t"
                if(line.endswith("_o")):
                    header = "wire"
                #--> handle line
                if(line.count("_addr_") > 0):
                    line = header + gen_tab(1) + "[ADDR_WIDTH-1:0]" + gen_tab(4) + line + ";\n" #--> addr signal
                elif(line.count("_data_") > 0):
                    line = header + gen_tab(1) + "[DATA_WIDTH-1:0]" + gen_tab(4) + line + ";\n" #--> data signal
                else:
                    line = header + gen_tab(9) + line + ";\n" #--> 1 bit signal
                list_out.append(add_level_line(line, 1)) #--> append line with tab level
            #--> clk and rstn
            elif(line.startswith("clk") or line.startswith("rstn")):
                line = "reg\t" + gen_tab(9) + line + ";\n" #--> 1 bit signal
                list_out.append(add_level_line(line, 1)) #--> append line with tab level
            #--> others
            else:
                list_out.append(add_level_line(line + "\n", 1)) #--> append line with tab level
    return list_out

def tb_write_declare_output_field(file_in, list_reg):
    list_out = []
    #--> read list_reg
    for reg in list_reg:
        #--> open declare_output_field.txt
        with open(file_in, "r") as fin:
            #--> read line by line
            for line in fin:
                line = line.split("\n")[0] #--> remove \n
                #--> signal line
                if(line.startswith("@") and line.endswith("_o")):
                    #--> read list_field
                    for field in reg.list_field:
                        #--> if field type is read/write mode
                        if(field.reg_property == REGTYPE_RW):
                            tmp = line.replace(STR_NAME, reg.name) #--> replace name
                            tmp = tmp.replace(STR_FIELD, field.name) #--> replace field
                            #--> if n bit
                            if(field.width.startswith("[") and field.width.endswith("]")):
                                tmp = "wire" + gen_tab(1) + field.width + gen_tab(7) + tmp + ";\n"
                                list_out.append(add_level_line(tmp, 1)) #--> append line with tab level
                            #--> 1 bit
                            else:
                                tmp = "wire" + gen_tab(9) + tmp + ";\n"
                                list_out.append(add_level_line(tmp, 1)) #--> append line with tab level
                #--> others
                else:
                    line = line.replace(STR_ADDR, reg.addr) #--> replace addr
                    list_out.append(add_level_line(line + "\n", 1)) #--> append line with tab level
    return list_out

def tb_write_inst_fixed_signal(file_in):
    list_out = []
    #--> open declare_input_output_fixed.txt
    with open(file_in, "r") as fin:
        #--> read line by line
        for line in fin:
            line = line.split("\n")[0] #--> remove \n
            #--> signal line
            if(line.startswith("reg_") and (line.endswith("_i") or line.endswith("_o"))):
                line = "." + line + "(" + line + "),\n"
                list_out.append(add_level_line(line, 2)) #--> append line with tab level
            #--> clk and rstn
            elif(line.startswith("clk") or line.startswith("rstn")):
                line = "." + line + "(" + line + "),\n"
                list_out.append(add_level_line(line, 2)) #--> append line with tab level
            #--> others
            else:
                list_out.append(add_level_line(line + "\n", 2)) #--> append line with tab level
    return list_out

def tb_write_inst_register_field(file_in, list_reg):
    list_out = []
    #--> read list_reg
    for i in range(0, len(list_reg), 1):
        #--> open declare_output_field.txt
        with open(file_in, "r") as fin:
            for line in fin:
                line = line.split("\n")[0] #--> remove \n
                #--> signal line
                if(line.startswith("@") and line.endswith("_o")):
                    #--> read list_field
                    for j in range(0, len(list_reg[i].list_field), 1):
                        #--> if field type is read/write mode
                        if(list_reg[i].list_field[j].reg_property == REGTYPE_RW):
                            tmp = line.replace(STR_NAME, list_reg[i].name) #--> replace name
                            tmp = tmp.replace(STR_FIELD, list_reg[i].list_field[j].name) #--> replace field
                            tmp = "." + tmp + "(" + tmp + ")\n"
                            #--> #--> if not final line: add ","
                            if(not (i==len(list_reg)-1 and j==len(list_reg[i].list_field)-1)):
                                #--> if after this field still has another write field
                                if(not (i==len(list_reg)-1 and is_final_write_field(j, list_reg[i].list_field))):
                                    tmp = tmp.replace(")", "),")
                            list_out.append(add_level_line(tmp, 2)) #--> append line with tab level
                #--> others
                else:
                    line = line.replace(STR_ADDR, list_reg[i].addr) #--> replace addr
                    list_out.append(add_level_line(line + "\n", 2)) #--> append line with tab level
    return list_out

def tb_write_tb_write_register(file_in, list_reg, list_rd):
    list_out = []
    #--> read list_reg
    for reg in list_reg:
        #--> open tb_write_register.txt
        with open(file_in, "r") as fin:
            #--> read line by line
            for line in fin:
                if(line.count(STR_ADDR) > 0):
                    line = line.replace(STR_ADDR, reg.addr.replace("0x", "")) #--> replace addr
                if(line.count(STR_RANDOM)):
                    line = line.replace(STR_RANDOM, get_rd(reg, list_rd)) #--> replace random
                list_out.append(add_level_line(line, 2)) #--> append line with tab level
        #--> add empty line before go to next register
        list_out.append("\n")
    return list_out

def tb_write_tb_read_register(file_in, list_reg, list_rd):
    list_out = []
    #--> read list_reg
    for reg in list_reg:
        #--> get rd
        rd = "0"
        for rd_dict in list_rd:
            if(rd_dict[STR_ADDR] == reg.addr):
                rd = rd_dict[STR_RANDOM]
        #--> open tb_read_register.txt
        with open(file_in, "r") as fin:
            #--> read line by line
            for line in fin:
                if(line.count(STR_ADDR) > 0):
                    line = line.replace(STR_ADDR, reg.addr.replace("0x", "")) #--> replace addr
                if(line.count(STR_NAME) > 0):
                    line = line.replace(STR_NAME, reg.name) #--> replace name
                if(line.count(STR_RANDOM)):
                    line = line.replace(STR_RANDOM, get_rd(reg, list_rd)) #--> replace random
                list_out.append(add_level_line(line, 2)) #--> append line with tab level
        #--> add empty line before go to next register
        list_out.append("\n")
    return list_out

def tb_write_tb_report(file_in, list_reg):
    list_out = []
    #--> read list_reg
    for reg in list_reg:
        #--> open tb_report_register.txt
        with open(file_in, "r") as fin:
            #--> read line by line
            for line in fin:
                if(line.count(STR_ADDR) > 0):
                    line = line.replace(STR_ADDR, reg.addr.replace("0x", "")) #--> replace addr
                if(line.count(STR_NAME) > 0):
                    line = line.replace(STR_NAME, reg.name) #--> replace name
                list_out.append(add_level_line(line, 1)) #--> append line with tab level
        #--> add empty line before go to next register
        list_out.append("\n")
    return list_out

def handle_file_pointed_by_tb(list_reg, file_pointed, flag_tb_write_declare_fixed_signal, flag_tb_write_declare_output_field, list_rd):
    list_res = []
    #--> write parameter
    if(file_pointed == "declare_parameter.txt"):
        print(">>>> create_testbench >> handling >> tb_write_param")
        list_res = tb_write_param(complete_path(file_pointed))
    #--> write wire/reg declaration of fixed interface
    if(file_pointed == "declare_input_output_fixed.txt" and flag_tb_write_declare_fixed_signal):
        print(">>>> create_testbench >> handling >> tb_write_declare_fixed_signal")
        flag_tb_write_declare_fixed_signal = False
        list_res = tb_write_declare_fixed_signal(complete_path(file_pointed))
        return list_res, flag_tb_write_declare_fixed_signal, flag_tb_write_declare_output_field
    #--> write wire/reg declaration of register field
    if(file_pointed == "declare_output_field.txt" and flag_tb_write_declare_output_field):
        print(">>>> create_testbench >> handling >> tb_write_declare_output_field")
        flag_tb_write_declare_output_field = False
        list_res = tb_write_declare_output_field(complete_path(file_pointed), list_reg)
        return list_res, flag_tb_write_declare_fixed_signal, flag_tb_write_declare_output_field
    #--> write fixed signal to inst
    if(file_pointed == "declare_input_output_fixed.txt"):
        print(">>>> create_testbench >> handling >> tb_write_inst_fixed_signal")
        list_res = tb_write_inst_fixed_signal(complete_path(file_pointed))
    #--> write register field signal to inst
    if(file_pointed == "declare_output_field.txt"):
        print(">>>> create_testbench >> handling >> tb_write_inst_register_field")
        list_res = tb_write_inst_register_field(complete_path(file_pointed), list_reg)
    #--> write tb write register
    if(file_pointed == "tb_write_register.txt"):
        print(">>>> create_testbench >> handling >> tb_write_tb_write_register")
        list_res = tb_write_tb_write_register(complete_path(file_pointed), list_reg, list_rd)
    #--> write tb read register
    if(file_pointed == "tb_read_register.txt"):
        print(">>>> create_testbench >> handling >> tb_write_tb_read_register")
        list_res = tb_write_tb_read_register(complete_path(file_pointed), list_reg, list_rd)
    #--> write tb report
    if(file_pointed == "tb_report_register.txt"):
        print(">>>> create_testbench >> handling >> tb_write_report")
        list_res = tb_write_tb_report(complete_path(file_pointed), list_reg)
    return list_res, flag_tb_write_declare_fixed_signal, flag_tb_write_declare_output_field

def create_testbench(list_reg):
    print(">>>> create_testbench >> run...")
    list_tb = []
    list_rd = [] #--> store written random data
    #--> create list_rd
    for reg in list_reg:
        rd_dict = {
            STR_ADDR: reg.addr,
            STR_RANDOM: random_32bit(reg)
        }
        list_rd.append(rd_dict)
    #--> open file_tb
    with open(file_tb, "r") as fin:
        flag_tb_write_declare_fixed_signal = True
        flag_tb_write_declare_output_field = True
        #--> read line by line
        for line in fin:
            #--> if tb point to other file: open file
            if(is_tb_point_to_other_file(line)):
                file_pointed = line.strip() #--> remove spaces in beginning
                file_pointed = file_pointed.replace("#file_", "") #--> remove #file_
                list_tmp, flag_tb_write_declare_fixed_signal, flag_tb_write_declare_output_field = handle_file_pointed_by_tb(list_reg, file_pointed, flag_tb_write_declare_fixed_signal, flag_tb_write_declare_output_field, list_rd) #--> handle file
                #--> restore to list_tb
                for tmp in list_tmp:
                    list_tb.append(tmp)
            #--> else: keep line
            else:
                list_tb.append(line)
    print(">>>> create_testbench >> end...")
    return list_tb

def write_testbench(list_tb):
    print(">>>> write_testbench >> run...")
    #--> open file_output
    with open(file_output, "w") as fout:
        for line in list_tb:
            fout.write(line)
    print(">>>> write_testbench >> end") 


###############################################################
##### main
###############################################################
def main():
    #put code here
    print("main of run_gen_testbench.py")
    
    #--> get list register (0)
    list_reg = read_reg_def()
    print(len(list_reg))

    #--> create testbench
    list_tb = create_testbench(list_reg)
    #for line in list_tb:
    #    print(line)
    
    #--> write output
    write_testbench(list_tb)

if __name__ == "__main__":
    main()
