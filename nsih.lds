/*
 * Copyright (C) 2016  Nexell Co., Ltd.
 * Author: Sangjong, Han <hans@nexell.co.kr>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)

MEMORY
{
	FLASH(rxw) : ORIGIN = 0, LENGTH = 512
}

SECTIONS
{
	. = 0;
	. = ALIGN(4);
	.text :
	{
		nsih.o	(.text)
		*(.text)
	} > FLASH
	
	.fill :
  {
   /* FILL(0x4e534948); */
   	FILL(0x00000000);
    . = ORIGIN(FLASH) + LENGTH(FLASH) - 4;
    BYTE(0x4e)
    BYTE(0x53)
    BYTE(0x49)
    BYTE(0x48)
    ___ROM_AT = .;
  } > FLASH
	
}

