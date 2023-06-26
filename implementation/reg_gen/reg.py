#! /usr/bin/python
"""
Viet Nam - May 30th, 2023
Created by Phu Vuong
define register
"""

from reg_field import *

class Reg:
    def __init__(self, addr, name):
        self.addr = addr
        self.name = name
        self.list_field = []
        print(">>>> Reg >> create new Register: %s %s" % (self.addr, self.name))

    def add_field(self, width, name, default_value, reg_property):
        new_field = RegField(width, name, default_value, reg_property)
        self.list_field.append(new_field)
        print(">>>> Reg >> add register field to list_field (%s)" % (str(len(self.list_field))))
