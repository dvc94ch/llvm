# RUN: llvm-mc %s -triple=riscv32 -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK,CHECK-INST %s
# RUN: llvm-mc %s -triple=riscv64 -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK,CHECK-INST %s
# RUN: llvm-mc -filetype=obj -triple riscv32 < %s \
# RUN:     | llvm-objdump -d - | FileCheck -check-prefix=CHECK-INST %s
# RUN: llvm-mc -filetype=obj -triple riscv64 < %s \
# RUN:     | llvm-objdump -d - | FileCheck -check-prefix=CHECK-INST %s


# CHECK-INST: mul ra, zero, zero
# CHECK: encoding: [0xb3,0x00,0x00,0x02]
mul x1, x0, x0

# CHECK-INST: mulh ra, zero, zero
# CHECK: encoding: [0xb3,0x10,0x00,0x02]
mulh x1, x0, x0

# CHECK-INST: mulhsu ra, zero, zero
# CHECK: encoding: [0xb3,0x20,0x00,0x02]
mulhsu x1, x0, x0

# CHECK-INST: mulhu ra, zero, zero
# CHECK: encoding: [0xb3,0x30,0x00,0x02]
mulhu x1, x0, x0

# CHECK-INST: div ra, zero, zero
# CHECK: encoding: [0xb3,0x40,0x00,0x02]
div x1, x0, x0

# CHECK-INST: divu ra, zero, zero
# CHECK: encoding: [0xb3,0x50,0x00,0x02]
divu x1, x0, x0

# CHECK-INST: rem ra, zero, zero
# CHECK: encoding: [0xb3,0x60,0x00,0x02]
rem x1, x0, x0

# CHECK-INST: remu ra, zero, zero
# CHECK: encoding: [0xb3,0x70,0x00,0x02]
remu x1, x0, x0
