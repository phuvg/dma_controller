#! /usr/bin/python
"""
Viet Nam - May 30th, 2023
Created by Phu Vuong
define register field
"""

class RegField:
    def __init__(self, width, name, default_value, reg_property):
        self.width = width
        self.name = name
        self.default_value = default_value
        self.reg_property = reg_property
        print(">>>> RegField >> add new field: width = %s - name = %s - default_value = %s - reg_property = %s" % (self.width, self.name, self.default_value, self.reg_property))

