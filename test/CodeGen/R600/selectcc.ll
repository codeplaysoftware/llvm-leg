; RUN: llc -verify-machineinstrs -march=r600 -mcpu=redwood < %s | FileCheck -check-prefix=EG -check-prefix=FUNC %s
; RUN: llc -verify-machineinstrs -march=r600 -mcpu=SI < %s | FileCheck -check-prefix=SI -check-prefix=FUNC %s

; FUNC-LABEL: {{^}}selectcc_i64:
; EG: XOR_INT
; EG: XOR_INT
; EG: OR_INT
; EG: CNDE_INT
; EG: CNDE_INT
; SI: V_CMP_EQ_I64
; SI: V_CNDMASK
; SI: V_CNDMASK
define void @selectcc_i64(i64 addrspace(1) * %out, i64 %lhs, i64 %rhs, i64 %true, i64 %false) {
entry:
  %0 = icmp eq i64 %lhs, %rhs
  %1 = select i1 %0, i64 %true, i64 %false
  store i64 %1, i64 addrspace(1)* %out
  ret void
}
