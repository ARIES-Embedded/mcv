//
// ARIES MCV module reference project -- top level module
//
// MIT License
//
// Copyright (c) 2016-2017 ARIES Embedded GmbH
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use, copy,
// modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
// BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

module mcv_reference(
	             memory_oct_rzqin,
	             clk50a,
	             hps_0_uart1_rxd,
	             hps_io_hps_io_emac0_inst_RXD0,
	             hps_io_hps_io_emac0_inst_RX_CTL,
	             hps_io_hps_io_emac0_inst_RX_CLK,
	             hps_io_hps_io_emac0_inst_RXD1,
	             hps_io_hps_io_emac0_inst_RXD2,
	             hps_io_hps_io_emac0_inst_RXD3,
	             hps_io_hps_io_usb1_inst_CLK,
	             hps_io_hps_io_usb1_inst_DIR,
	             hps_io_hps_io_usb1_inst_NXT,
	             hps_io_hps_io_spim1_inst_MISO,
	             hps_io_hps_io_uart0_inst_RX,
	             hps_io_hps_io_can0_inst_RX,
	             hps_io_hps_io_can1_inst_RX,
	             hps_io_hps_io_gpio_inst_HLGPI0,
	             hps_io_hps_io_gpio_inst_HLGPI1,
	             hps_io_hps_io_gpio_inst_HLGPI2,
	             hps_io_hps_io_gpio_inst_HLGPI3,
	             hps_io_hps_io_gpio_inst_HLGPI4,
	             hps_io_hps_io_gpio_inst_HLGPI5,
	             hps_io_hps_io_gpio_inst_HLGPI6,
	             hps_io_hps_io_gpio_inst_HLGPI7,
	             hps_io_hps_io_gpio_inst_HLGPI8,
	             hps_io_hps_io_gpio_inst_HLGPI9,
	             hps_io_hps_io_gpio_inst_HLGPI10,
	             hps_io_hps_io_gpio_inst_HLGPI11,
	             hps_io_hps_io_gpio_inst_HLGPI12,
	             hps_io_hps_io_gpio_inst_HLGPI13,
	             nrst,
	             memory_mem_ck,
	             memory_mem_ck_n,
	             memory_mem_cke,
	             memory_mem_cs_n,
	             memory_mem_ras_n,
	             memory_mem_cas_n,
	             memory_mem_we_n,
	             memory_mem_reset_n,
	             memory_mem_odt,
	             hps_0_uart1_txd,
	             hps_io_hps_io_emac0_inst_TX_CLK,
	             hps_io_hps_io_emac0_inst_TXD0,
	             hps_io_hps_io_emac0_inst_TXD1,
	             hps_io_hps_io_emac0_inst_TXD2,
	             hps_io_hps_io_emac0_inst_TXD3,
	             hps_io_hps_io_emac0_inst_MDC,
	             hps_io_hps_io_emac0_inst_TX_CTL,
	             hps_io_hps_io_sdio_inst_CLK,
	             hps_io_hps_io_usb1_inst_STP,
	             hps_io_hps_io_spim1_inst_CLK,
	             hps_io_hps_io_spim1_inst_MOSI,
	             hps_io_hps_io_spim1_inst_SS0,
	             hps_io_hps_io_uart0_inst_TX,
	             hps_io_hps_io_can0_inst_TX,
	             hps_io_hps_io_can1_inst_TX,
	             hps_io_hps_io_emac0_inst_MDIO,
	             hps_io_hps_io_sdio_inst_CMD,
	             hps_io_hps_io_sdio_inst_D0,
	             hps_io_hps_io_sdio_inst_D1,
	             hps_io_hps_io_sdio_inst_D2,
	             hps_io_hps_io_sdio_inst_D3,
	             hps_io_hps_io_sdio_inst_D4,
	             hps_io_hps_io_sdio_inst_D5,
	             hps_io_hps_io_sdio_inst_D6,
	             hps_io_hps_io_sdio_inst_D7,
	             hps_io_hps_io_usb1_inst_D0,
	             hps_io_hps_io_usb1_inst_D1,
	             hps_io_hps_io_usb1_inst_D2,
	             hps_io_hps_io_usb1_inst_D3,
	             hps_io_hps_io_usb1_inst_D4,
	             hps_io_hps_io_usb1_inst_D5,
	             hps_io_hps_io_usb1_inst_D6,
	             hps_io_hps_io_usb1_inst_D7,
	             hps_io_hps_io_i2c0_inst_SDA,
	             hps_io_hps_io_i2c0_inst_SCL,
	             hps_io_hps_io_gpio_inst_GPIO19,
	             hps_io_hps_io_gpio_inst_GPIO20,
	             hps_io_hps_io_gpio_inst_GPIO21,
	             hps_io_hps_io_gpio_inst_GPIO26,
	             hps_io_hps_io_gpio_inst_GPIO27,
	             hps_io_hps_io_gpio_inst_GPIO28,
	             hps_io_hps_io_gpio_inst_GPIO33,
	             hps_io_hps_io_gpio_inst_GPIO34,
	             hps_io_hps_io_gpio_inst_GPIO35,
	             hps_io_hps_io_gpio_inst_GPIO37,
	             hps_io_hps_io_gpio_inst_GPIO44,
	             hps_io_hps_io_gpio_inst_GPIO48,
	             hps_io_hps_io_gpio_inst_GPIO51,
	             hps_io_hps_io_gpio_inst_GPIO52,
	             hps_io_hps_io_gpio_inst_GPIO57,
	             hps_io_hps_io_gpio_inst_GPIO58,
	             hps_io_hps_io_gpio_inst_GPIO59,
	             hps_io_hps_io_gpio_inst_GPIO60,
	             iob3a,
	             iob3b,
	             iob4a,
	             iob5a,
	             iob5b,
	             iob8a,
	             memory_mem_a,
	             memory_mem_ba,
	             memory_mem_dm,
	             memory_mem_dq,
	             memory_mem_dqs,
	             memory_mem_dqs_n
                     );

   input wire	memory_oct_rzqin;
   input wire	clk50a;
   input wire	hps_0_uart1_rxd;
   input wire	hps_io_hps_io_emac0_inst_RXD0;
   input wire	hps_io_hps_io_emac0_inst_RX_CTL;
   input wire	hps_io_hps_io_emac0_inst_RX_CLK;
   input wire	hps_io_hps_io_emac0_inst_RXD1;
   input wire	hps_io_hps_io_emac0_inst_RXD2;
   input wire	hps_io_hps_io_emac0_inst_RXD3;
   input wire	hps_io_hps_io_usb1_inst_CLK;
   input wire	hps_io_hps_io_usb1_inst_DIR;
   input wire	hps_io_hps_io_usb1_inst_NXT;
   input wire	hps_io_hps_io_spim1_inst_MISO;
   input wire	hps_io_hps_io_uart0_inst_RX;
   input wire	hps_io_hps_io_can0_inst_RX;
   input wire	hps_io_hps_io_can1_inst_RX;
   input wire	hps_io_hps_io_gpio_inst_HLGPI0;
   input wire	hps_io_hps_io_gpio_inst_HLGPI1;
   input wire	hps_io_hps_io_gpio_inst_HLGPI2;
   input wire	hps_io_hps_io_gpio_inst_HLGPI3;
   input wire	hps_io_hps_io_gpio_inst_HLGPI4;
   input wire	hps_io_hps_io_gpio_inst_HLGPI5;
   input wire	hps_io_hps_io_gpio_inst_HLGPI6;
   input wire	hps_io_hps_io_gpio_inst_HLGPI7;
   input wire	hps_io_hps_io_gpio_inst_HLGPI8;
   input wire	hps_io_hps_io_gpio_inst_HLGPI9;
   input wire	hps_io_hps_io_gpio_inst_HLGPI10;
   input wire	hps_io_hps_io_gpio_inst_HLGPI11;
   input wire	hps_io_hps_io_gpio_inst_HLGPI12;
   input wire	hps_io_hps_io_gpio_inst_HLGPI13;
   input wire	nrst;
   output wire	memory_mem_ck;
   output wire	memory_mem_ck_n;
   output wire	memory_mem_cke;
   output wire	memory_mem_cs_n;
   output wire	memory_mem_ras_n;
   output wire	memory_mem_cas_n;
   output wire	memory_mem_we_n;
   output wire	memory_mem_reset_n;
   output wire	memory_mem_odt;
   output wire	hps_0_uart1_txd;
   output wire	hps_io_hps_io_emac0_inst_TX_CLK;
   output wire	hps_io_hps_io_emac0_inst_TXD0;
   output wire	hps_io_hps_io_emac0_inst_TXD1;
   output wire	hps_io_hps_io_emac0_inst_TXD2;
   output wire	hps_io_hps_io_emac0_inst_TXD3;
   output wire	hps_io_hps_io_emac0_inst_MDC;
   output wire	hps_io_hps_io_emac0_inst_TX_CTL;
   output wire	hps_io_hps_io_sdio_inst_CLK;
   output wire	hps_io_hps_io_usb1_inst_STP;
   output wire	hps_io_hps_io_spim1_inst_CLK;
   output wire	hps_io_hps_io_spim1_inst_MOSI;
   output wire	hps_io_hps_io_spim1_inst_SS0;
   output wire	hps_io_hps_io_uart0_inst_TX;
   output wire	hps_io_hps_io_can0_inst_TX;
   output wire	hps_io_hps_io_can1_inst_TX;
   inout wire	hps_io_hps_io_emac0_inst_MDIO;
   inout wire	hps_io_hps_io_sdio_inst_CMD;
   inout wire	hps_io_hps_io_sdio_inst_D0;
   inout wire	hps_io_hps_io_sdio_inst_D1;
   inout wire	hps_io_hps_io_sdio_inst_D2;
   inout wire	hps_io_hps_io_sdio_inst_D3;
   inout wire	hps_io_hps_io_sdio_inst_D4;
   inout wire	hps_io_hps_io_sdio_inst_D5;
   inout wire	hps_io_hps_io_sdio_inst_D6;
   inout wire	hps_io_hps_io_sdio_inst_D7;
   inout wire	hps_io_hps_io_usb1_inst_D0;
   inout wire	hps_io_hps_io_usb1_inst_D1;
   inout wire	hps_io_hps_io_usb1_inst_D2;
   inout wire	hps_io_hps_io_usb1_inst_D3;
   inout wire	hps_io_hps_io_usb1_inst_D4;
   inout wire	hps_io_hps_io_usb1_inst_D5;
   inout wire	hps_io_hps_io_usb1_inst_D6;
   inout wire	hps_io_hps_io_usb1_inst_D7;
   inout wire	hps_io_hps_io_i2c0_inst_SDA;
   inout wire	hps_io_hps_io_i2c0_inst_SCL;
   inout wire	hps_io_hps_io_gpio_inst_GPIO19;
   inout wire	hps_io_hps_io_gpio_inst_GPIO20;
   inout wire	hps_io_hps_io_gpio_inst_GPIO21;
   inout wire	hps_io_hps_io_gpio_inst_GPIO26;
   inout wire	hps_io_hps_io_gpio_inst_GPIO27;
   inout wire	hps_io_hps_io_gpio_inst_GPIO28;
   inout wire	hps_io_hps_io_gpio_inst_GPIO33;
   inout wire	hps_io_hps_io_gpio_inst_GPIO34;
   inout wire	hps_io_hps_io_gpio_inst_GPIO35;
   inout wire	hps_io_hps_io_gpio_inst_GPIO37;
   inout wire	hps_io_hps_io_gpio_inst_GPIO44;
   inout wire	hps_io_hps_io_gpio_inst_GPIO48;
   inout wire	hps_io_hps_io_gpio_inst_GPIO51;
   inout wire	hps_io_hps_io_gpio_inst_GPIO52;
   inout wire	hps_io_hps_io_gpio_inst_GPIO57;
   inout wire	hps_io_hps_io_gpio_inst_GPIO58;
   inout wire	hps_io_hps_io_gpio_inst_GPIO59;
   inout wire	hps_io_hps_io_gpio_inst_GPIO60;
   inout wire [15:0] iob3a;
   inout wire [31:0] iob3b;
   inout wire [67:0] iob4a;
   inout wire [15:0] iob5a;
   inout wire [5:0]  iob5b;
   inout wire [3:0]  iob8a;
   output wire [14:0] memory_mem_a;
   output wire [2:0]  memory_mem_ba;
   output wire [3:0]  memory_mem_dm;
   inout wire [31:0]  memory_mem_dq;
   inout wire [3:0]   memory_mem_dqs;
   inout wire [3:0]   memory_mem_dqs_n;

  wire  fpga_clk;
  wire  fpga_refclk;
  wire  fpga_clk_rst_n;
  assign fpga_refclk = clk50a;


  // LCD-Display:
  wire lcd_clk;    // LCD-CLK
  wire lcd_disp;   // LCD-DisplayOn/Off
  wire lcd_dim;    // LCD-DIMM/PWM
  wire lcd_hsync;  // LCD-DIMM/hync
  wire lcd_vsync;  // LCD-DIMM/vsync
  wire lcd_dval;   // LCD-DIMM/dval
  //
  wire [7:0] lcdr;
  wire [7:0] lcdg;
  wire [7:0] lcdb;

  wire [23:0] frmbuf_vid_dat;
  wire frmbuf_vid_val;
  wire frmbuf_vid_pkgstrt;
  wire frmbuf_vid_pkgend;
  wire vid_rdy_2frmbuf;


  // changed in LCD reference design:
  wire [5:0] led;


   mcv_hps b2v_inst(
              .clk_clk(fpga_refclk),
              .reset_reset_n(fpga_clk_rst_n),

              .alt_vip_cl_vfb_0_dout_ready(vid_rdy_2frmbuf),
              .alt_vip_cl_vfb_0_dout_startofpacket(frmbuf_vid_pkgstrt),
              .alt_vip_cl_vfb_0_dout_endofpacket(frmbuf_vid_pkgend),
              .alt_vip_cl_vfb_0_dout_valid(frmbuf_vid_val),
              .alt_vip_cl_vfb_0_dout_data(frmbuf_vid_dat),

	            .hps_io_hps_io_emac0_inst_RXD0(hps_io_hps_io_emac0_inst_RXD0),
	            .hps_io_hps_io_emac0_inst_RX_CTL(hps_io_hps_io_emac0_inst_RX_CTL),
	            .hps_io_hps_io_emac0_inst_RX_CLK(hps_io_hps_io_emac0_inst_RX_CLK),
	            .hps_io_hps_io_emac0_inst_RXD1(hps_io_hps_io_emac0_inst_RXD1),
	            .hps_io_hps_io_emac0_inst_RXD2(hps_io_hps_io_emac0_inst_RXD2),
	            .hps_io_hps_io_emac0_inst_RXD3(hps_io_hps_io_emac0_inst_RXD3),
	            .hps_io_hps_io_usb1_inst_CLK(hps_io_hps_io_usb1_inst_CLK),
	            .hps_io_hps_io_usb1_inst_DIR(hps_io_hps_io_usb1_inst_DIR),
	            .hps_io_hps_io_usb1_inst_NXT(hps_io_hps_io_usb1_inst_NXT),
	            .hps_io_hps_io_spim1_inst_MISO(hps_io_hps_io_spim1_inst_MISO),
	            .hps_io_hps_io_uart0_inst_RX(hps_io_hps_io_uart0_inst_RX),
	            .hps_io_hps_io_can0_inst_RX(hps_io_hps_io_can0_inst_RX),
	            .hps_io_hps_io_can1_inst_RX(hps_io_hps_io_can1_inst_RX),
	            .hps_io_hps_io_gpio_inst_HLGPI0(hps_io_hps_io_gpio_inst_HLGPI0),
	            .hps_io_hps_io_gpio_inst_HLGPI1(hps_io_hps_io_gpio_inst_HLGPI1),
	            .hps_io_hps_io_gpio_inst_HLGPI2(hps_io_hps_io_gpio_inst_HLGPI2),
	            .hps_io_hps_io_gpio_inst_HLGPI3(hps_io_hps_io_gpio_inst_HLGPI3),
	            .hps_io_hps_io_gpio_inst_HLGPI4(hps_io_hps_io_gpio_inst_HLGPI4),
	            .hps_io_hps_io_gpio_inst_HLGPI5(hps_io_hps_io_gpio_inst_HLGPI5),
	            .hps_io_hps_io_gpio_inst_HLGPI6(hps_io_hps_io_gpio_inst_HLGPI6),
	            .hps_io_hps_io_gpio_inst_HLGPI7(hps_io_hps_io_gpio_inst_HLGPI7),
	            .hps_io_hps_io_gpio_inst_HLGPI8(hps_io_hps_io_gpio_inst_HLGPI8),
	            .hps_io_hps_io_gpio_inst_HLGPI9(hps_io_hps_io_gpio_inst_HLGPI9),
	            .hps_io_hps_io_gpio_inst_HLGPI10(hps_io_hps_io_gpio_inst_HLGPI10),
	            .hps_io_hps_io_gpio_inst_HLGPI11(hps_io_hps_io_gpio_inst_HLGPI11),
	            .hps_io_hps_io_gpio_inst_HLGPI12(hps_io_hps_io_gpio_inst_HLGPI12),
	            .hps_io_hps_io_gpio_inst_HLGPI13(hps_io_hps_io_gpio_inst_HLGPI13),
	            .memory_oct_rzqin(memory_oct_rzqin),

	            .hps_0_uart1_rxd(hps_0_uart1_rxd),
	            .hps_io_hps_io_emac0_inst_MDIO(hps_io_hps_io_emac0_inst_MDIO),
	            .hps_io_hps_io_sdio_inst_CMD(hps_io_hps_io_sdio_inst_CMD),
	            .hps_io_hps_io_sdio_inst_D0(hps_io_hps_io_sdio_inst_D0),
	            .hps_io_hps_io_sdio_inst_D1(hps_io_hps_io_sdio_inst_D1),
	            .hps_io_hps_io_sdio_inst_D2(hps_io_hps_io_sdio_inst_D2),
	            .hps_io_hps_io_sdio_inst_D3(hps_io_hps_io_sdio_inst_D3),
	            .hps_io_hps_io_sdio_inst_D4(hps_io_hps_io_sdio_inst_D4),
	            .hps_io_hps_io_sdio_inst_D5(hps_io_hps_io_sdio_inst_D5),
	            .hps_io_hps_io_sdio_inst_D6(hps_io_hps_io_sdio_inst_D6),
	            .hps_io_hps_io_sdio_inst_D7(hps_io_hps_io_sdio_inst_D7),
	            .hps_io_hps_io_usb1_inst_D0(hps_io_hps_io_usb1_inst_D0),
	            .hps_io_hps_io_usb1_inst_D1(hps_io_hps_io_usb1_inst_D1),
	            .hps_io_hps_io_usb1_inst_D2(hps_io_hps_io_usb1_inst_D2),
	            .hps_io_hps_io_usb1_inst_D3(hps_io_hps_io_usb1_inst_D3),
	            .hps_io_hps_io_usb1_inst_D4(hps_io_hps_io_usb1_inst_D4),
	            .hps_io_hps_io_usb1_inst_D5(hps_io_hps_io_usb1_inst_D5),
	            .hps_io_hps_io_usb1_inst_D6(hps_io_hps_io_usb1_inst_D6),
	            .hps_io_hps_io_usb1_inst_D7(hps_io_hps_io_usb1_inst_D7),
	            .hps_io_hps_io_i2c0_inst_SDA(hps_io_hps_io_i2c0_inst_SDA),
	            .hps_io_hps_io_i2c0_inst_SCL(hps_io_hps_io_i2c0_inst_SCL),
	            .hps_io_hps_io_gpio_inst_GPIO19(hps_io_hps_io_gpio_inst_GPIO19),
	            .hps_io_hps_io_gpio_inst_GPIO20(hps_io_hps_io_gpio_inst_GPIO20),
	            .hps_io_hps_io_gpio_inst_GPIO21(hps_io_hps_io_gpio_inst_GPIO21),
	            .hps_io_hps_io_gpio_inst_GPIO26(hps_io_hps_io_gpio_inst_GPIO26),
	            .hps_io_hps_io_gpio_inst_GPIO27(hps_io_hps_io_gpio_inst_GPIO27),
	            .hps_io_hps_io_gpio_inst_GPIO28(hps_io_hps_io_gpio_inst_GPIO28),
	            .hps_io_hps_io_gpio_inst_GPIO33(hps_io_hps_io_gpio_inst_GPIO33),
	            .hps_io_hps_io_gpio_inst_GPIO34(hps_io_hps_io_gpio_inst_GPIO34),
	            .hps_io_hps_io_gpio_inst_GPIO35(hps_io_hps_io_gpio_inst_GPIO35),
	            .hps_io_hps_io_gpio_inst_GPIO37(hps_io_hps_io_gpio_inst_GPIO37),
	            .hps_io_hps_io_gpio_inst_GPIO44(hps_io_hps_io_gpio_inst_GPIO44),
	            .hps_io_hps_io_gpio_inst_GPIO48(hps_io_hps_io_gpio_inst_GPIO48),
	            .hps_io_hps_io_gpio_inst_GPIO51(hps_io_hps_io_gpio_inst_GPIO51),
	            .hps_io_hps_io_gpio_inst_GPIO52(hps_io_hps_io_gpio_inst_GPIO52),
	            .hps_io_hps_io_gpio_inst_GPIO57(hps_io_hps_io_gpio_inst_GPIO57),
	            .hps_io_hps_io_gpio_inst_GPIO58(hps_io_hps_io_gpio_inst_GPIO58),
	            .hps_io_hps_io_gpio_inst_GPIO59(hps_io_hps_io_gpio_inst_GPIO59),
	            .hps_io_hps_io_gpio_inst_GPIO60(hps_io_hps_io_gpio_inst_GPIO60),
	            .memory_mem_dq(memory_mem_dq),
	            .memory_mem_dqs(memory_mem_dqs),
	            .memory_mem_dqs_n(memory_mem_dqs_n),

				   // we changed in LCD reference design:
               // LCD   .pio_iob3a_export(iob3a),
               // LCD   .pio_iob3b_export(iob3b),
               // LEDs  .pio_iob4a_0_export(iob4a[31:0]),
               // LED-Signals:
               //       .pio_iob4a_1_export(iob4a[63:32]),

	            .pio_iob4a_0_export(iob4a[31:0]),
	            .pio_iob4a_1_export(iob4a[63:32]),
	            .pio_iob4a_2_export(iob4a[67:64]),

	            .pio_iob5a_export(iob5a),
	            .pio_iob5b_export(iob5b),
	            .pio_iob8a_export(iob8a),
	            .hps_io_hps_io_emac0_inst_TX_CLK(hps_io_hps_io_emac0_inst_TX_CLK),
	            .hps_io_hps_io_emac0_inst_TXD0(hps_io_hps_io_emac0_inst_TXD0),
	            .hps_io_hps_io_emac0_inst_TXD1(hps_io_hps_io_emac0_inst_TXD1),
	            .hps_io_hps_io_emac0_inst_TXD2(hps_io_hps_io_emac0_inst_TXD2),
	            .hps_io_hps_io_emac0_inst_TXD3(hps_io_hps_io_emac0_inst_TXD3),
	            .hps_io_hps_io_emac0_inst_MDC(hps_io_hps_io_emac0_inst_MDC),
	            .hps_io_hps_io_emac0_inst_TX_CTL(hps_io_hps_io_emac0_inst_TX_CTL),
	            .hps_io_hps_io_sdio_inst_CLK(hps_io_hps_io_sdio_inst_CLK),
	            .hps_io_hps_io_usb1_inst_STP(hps_io_hps_io_usb1_inst_STP),
	            .hps_io_hps_io_spim1_inst_CLK(hps_io_hps_io_spim1_inst_CLK),
	            .hps_io_hps_io_spim1_inst_MOSI(hps_io_hps_io_spim1_inst_MOSI),
	            .hps_io_hps_io_spim1_inst_SS0(hps_io_hps_io_spim1_inst_SS0),
	            .hps_io_hps_io_uart0_inst_TX(hps_io_hps_io_uart0_inst_TX),
	            .hps_io_hps_io_can0_inst_TX(hps_io_hps_io_can0_inst_TX),
	            .hps_io_hps_io_can1_inst_TX(hps_io_hps_io_can1_inst_TX),
	            .memory_mem_ck(memory_mem_ck),
	            .memory_mem_ck_n(memory_mem_ck_n),
	            .memory_mem_cke(memory_mem_cke),
	            .memory_mem_cs_n(memory_mem_cs_n),
	            .memory_mem_ras_n(memory_mem_ras_n),
	            .memory_mem_cas_n(memory_mem_cas_n),
	            .memory_mem_we_n(memory_mem_we_n),
	            .memory_mem_reset_n(memory_mem_reset_n),
	            .memory_mem_odt(memory_mem_odt),

	            .hps_0_uart1_txd(hps_0_uart1_txd),

	            .memory_mem_a(memory_mem_a),
	            .memory_mem_ba(memory_mem_ba),
	            .memory_mem_dm(memory_mem_dm)

            );


//###########################################################################
// fpga_application: video stream output to lcd display
//###########################################################################

   fpga_appli appli_inst(
          .rst_n(nrst),
          .fpga_refclk(fpga_refclk),
          .fpga_clk_rst_n(fpga_clk_rst_n),
          .fpga_clk(fpga_clk),

          .vid_pkgstrt(frmbuf_vid_pkgstrt),
			 .vid_pkgend(frmbuf_vid_pkgend),
          .vid_dat(frmbuf_vid_dat),
          .vid_val(frmbuf_vid_val),
          .vid_rdy(vid_rdy_2frmbuf),

          .lcd_clk(lcd_clk),
          .lcd_disp(lcd_disp),
          .lcd_dim(lcd_dim),
          .lcd_vsync(lcd_vsync),
          .lcd_hsync(lcd_hsync),
          .lcd_dval(lcd_dval),
          .lcd_red(lcdr),
          .lcd_green(lcdg),
          .lcd_blue(lcdb),

          .led(led)
	            );


// LCD-Display:
assign iob3a[7]  = lcd_clk;
assign iob3b[26] = lcd_disp;  // LCD-DisplayOn/Off + Enable LED-BacklightDriver(1=ON)
assign iob3b[27] = lcd_dim;   // LCD-Dimm/PWM

assign iob3b[1] = lcd_vsync;
assign iob3b[2] = lcd_hsync;
assign iob3b[0] = lcd_dval;

// LCD-Data:
// lcdr
assign iob3a[6]  = lcdr[0];
assign iob3a[5]  = lcdr[1];
assign iob3a[4]  = lcdr[2];
assign iob3a[3]  = lcdr[3];
assign iob3a[2]  = lcdr[4];
assign iob3a[1]  = lcdr[5];
assign iob3a[0]  = lcdr[6];
assign iob3b[15] = lcdr[7];

// lcdg
assign iob3b[14] = lcdg[0];
assign iob3b[13] = lcdg[1];
assign iob3b[12] = lcdg[2];
assign iob3b[11] = lcdg[3];
assign iob3b[10] = lcdg[4];
assign iob3b[9]  = lcdg[5];
assign iob3b[8]  = lcdg[6];
assign iob3b[7]  = lcdg[7];

// lcdb
assign iob3b[6]  = lcdb[0];
assign iob3b[5]  = lcdb[1];
assign iob3b[4]  = lcdb[2];
assign iob3b[3]  = lcdb[3];
assign iob3b[31] = lcdb[4];
assign iob3b[30] = lcdb[5];
assign iob3b[29] = lcdb[6];
assign iob3b[28] = lcdb[7];


//#################
// Display-Touch-Ctrl.(LCD-Touch: Reset=Low-active)
assign iob3a[8]  = fpga_clk_rst_n;

//##################
//LEDs:
//assign iob4a[16] = led[0];
//assign iob4a[44] = led[1];
//assign iob4a[52] = led[5];
//assign iob4a[17] = led[4];
//assign iob4a[45] = led[3];
//assign iob4a[53] = led[2];

endmodule
