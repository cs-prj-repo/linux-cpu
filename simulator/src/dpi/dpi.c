#include <common.h>
#include <cstdint>
#include <cstdio>
#include <defs.h>
#include "verilated_dpi.h" // For VerilatedDpiOpenVar and other DPI related definitions


extern "C" void dpi_ebreak(int pc){
//	printf("下一个要执行的指令是ebreak\n");
	SIMTRAP(pc, 0);
}

extern "C" uint64_t dpi_mem_read(uint64_t addr, uint64_t len){
	if(addr == 0) return 0;
	else{
		unsigned int data = pmem_read(addr, len);
		return data;
	}
}

extern "C" void dpi_mem_write(int addr, int data, int len){
	if(addr == CONFIG_SERIAL_MMIO){
		char ch = data;
		printf("%c", ch);
		fflush(stdout);
	}else{
		pmem_write(addr, len, data);
	}
}


extern uint32_t  *reg_ptr;
extern "C" void dpi_read_regfile(const svOpenArrayHandle r) {
  reg_ptr = (uint32_t *)(((VerilatedDpiOpenVar*)r)->datap());
}