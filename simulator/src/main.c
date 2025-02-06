#include <common.h>
#include <defs.h>

int main(int argc, char **argv){
  init_monitor(argc, argv);
  cpu_exec(UINT64_MAX);
  return 0;
}
