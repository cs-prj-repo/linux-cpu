#include <stdio.h>
#include <cstdint>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <time.h>
#define CONFIG_MSIZE 0x8000000
#define CONFIG_MBASE 0x80000000
typedef uint64_t word_t;

uint8_t pmem[CONFIG_MSIZE]  = {}; 
void init_mem() {
    srand(time(NULL));    
    // 为每个字节生成随机值
    for (size_t i = 0; i < CONFIG_MSIZE; i++) {
      pmem[i] = rand() % 0x100;  // 确保值在0-255范围内
    }
}
static inline word_t host_read(void *addr, int len) {
  switch (len) {
    case 1: return *(uint8_t  *)addr;
    case 2: return *(uint16_t *)addr;
    case 4: return *(uint32_t *)addr;
    case 8: return *(uint64_t *)addr;
    default: assert(0);
  }
}
uint8_t* guest_to_host(word_t paddr) { return pmem + paddr - CONFIG_MBASE; }

word_t pmem_read(word_t addr, int len){
  return host_read(guest_to_host(addr), len);
}

extern "C" uint32_t dpi_instr_mem_read(uint64_t addr){
  if(addr >= CONFIG_MBASE && addr < CONFIG_MBASE + CONFIG_MSIZE){
        //printf("访问的内存地址是0x%lx\n", addr);
		return pmem_read(addr, 4);
	}else{
      printf("你将要访问的内存地址是0x%lx, 超出了内存区域\n", addr);
      return 0;
   }
}


