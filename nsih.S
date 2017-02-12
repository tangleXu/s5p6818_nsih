	.global _start
_start:
	b reset1
	b reset2
	b reset2
	b reset2
	b reset2
	b reset2
	b reset2
	b reset2
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	
	.word 0x00000000 // revice read address from 2ndboot device
	.word 0x00000000 // load size for 2ndboot
	.word 0xffff0000 // load address for 2ndboot
	.word 0xffff0000 // launch address for 2ndboot

	.word 0x00000000
	.word 0x00000000
	.word 0x00000000	
	
reset1:
	movw r0, #0x1000
	movt r0, #0xc001
	movw r1, #0xc080
	movt r1, #0x3fff
	movw r2, #0x0000
	movt r2, #0x0000
	str r1,[r0,#0x140] // set all cpus reset vector address to 0xffff0200(0x3fffc0800>>2)
	str r2,[r0,#324]
	str r1,[r0,#328]
	str r2,[r0,#332]
	str r1,[r0,#336]
	str r2,[r0,#340]
	str r1,[r0,#344]
	str r2,[r0,#348]
	str r1,[r0,#0x184]
	str r2,[r0,#392]
	str r1,[r0,#396]
	str r2,[r0,#400]
	str r1,[r0,#404]
	str r2,[r0,#408]
	str r1,[r0,#412]
	str r2,[r0,#416]
	
	ldr r1, [r0,#0x13c] // all group 0 cpu AArch64 mode
	orr r1, r1,#0xf000
	str r1, [r0,#0x13c]
	
	ldr r1, [r0,#0x180] // all group 1 cpu AArch64 mode
	orr r1, r1,#0xf0
	str r1, [r0,#0x180]
	
	ldr r1, [r0,#0x138] // all group 0 cpu excepetion vectors at reset is 0xffff0000
	orr r1, r1,#0xf00000
	str r1, [r0,#0x138]
	
	ldr r1, [r0,#0x17c] // all group 1 cpu excepetion vectors at reset is 0xffff0000
	orr r1, r1,#0xf000
	str r1, [r0,#0x17c]

	movw r0, #0x0000	// systen control reset request
	movt r0, #0xc001
	ldr r1, [r0,#0x2ac]
	orr r1, r1,#0x1
	str r1, [r0,#0x2ac]
	wfi	// wait for interrupt

reset2:	
	// LED control on GPIOB12
	movw r0, #0xb000
	movt r0, #0xc001
	
	ldr r1, [r0,#0x020]
	bic r1, r1, #0x03000000
	orr r1, r1, #0x02000000
	str r1, [r0,#0x020]
	
	ldr r1, [r0,#0x000]
	orr r1, r1, #0x1000
	str r1, [r0,#0x000]
	
	ldr r1, [r0,#0x004]
	orr r1, r1, #0x1000
	str r1, [r0,#0x004]
	
	b .
	


