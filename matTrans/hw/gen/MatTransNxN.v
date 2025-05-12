// Generator : SpinalHDL v1.12.0    git head : 1aa7d7b5732f11cca2dd83bacc2a4cb92ca8e5c9
// Component : MatTransNxN
// Git hash  : 82012523208daa3593b96b864ae871fa49cd4c0d

`timescale 1ns/1ps

module MatTransNxN (
  output reg           io_inReady,
  input  wire          io_outReady,
  input  wire          io_inValid,
  output reg           io_outValid,
  input  wire [31:0]   io_inBus_0,
  input  wire [31:0]   io_inBus_1,
  input  wire [31:0]   io_inBus_2,
  input  wire [31:0]   io_inBus_3,
  input  wire [31:0]   io_inBus_4,
  input  wire [31:0]   io_inBus_5,
  input  wire [31:0]   io_inBus_6,
  input  wire [31:0]   io_inBus_7,
  output wire [31:0]   io_outBus_0,
  output wire [31:0]   io_outBus_1,
  output wire [31:0]   io_outBus_2,
  output wire [31:0]   io_outBus_3,
  output wire [31:0]   io_outBus_4,
  output wire [31:0]   io_outBus_5,
  output wire [31:0]   io_outBus_6,
  output wire [31:0]   io_outBus_7,
  input  wire          clk,
  input  wire          resetn
);
  localparam fsm_BOOT = 2'd0;
  localparam fsm_input_1 = 2'd1;
  localparam fsm_output_1 = 2'd2;

  wire       [31:0]   datapath_muxRegArray_0_0_io_output;
  wire       [31:0]   datapath_muxRegArray_0_1_io_output;
  wire       [31:0]   datapath_muxRegArray_0_2_io_output;
  wire       [31:0]   datapath_muxRegArray_0_3_io_output;
  wire       [31:0]   datapath_muxRegArray_0_4_io_output;
  wire       [31:0]   datapath_muxRegArray_0_5_io_output;
  wire       [31:0]   datapath_muxRegArray_0_6_io_output;
  wire       [31:0]   datapath_muxRegArray_0_7_io_output;
  wire       [31:0]   datapath_muxRegArray_1_0_io_output;
  wire       [31:0]   datapath_muxRegArray_1_1_io_output;
  wire       [31:0]   datapath_muxRegArray_1_2_io_output;
  wire       [31:0]   datapath_muxRegArray_1_3_io_output;
  wire       [31:0]   datapath_muxRegArray_1_4_io_output;
  wire       [31:0]   datapath_muxRegArray_1_5_io_output;
  wire       [31:0]   datapath_muxRegArray_1_6_io_output;
  wire       [31:0]   datapath_muxRegArray_1_7_io_output;
  wire       [31:0]   datapath_muxRegArray_2_0_io_output;
  wire       [31:0]   datapath_muxRegArray_2_1_io_output;
  wire       [31:0]   datapath_muxRegArray_2_2_io_output;
  wire       [31:0]   datapath_muxRegArray_2_3_io_output;
  wire       [31:0]   datapath_muxRegArray_2_4_io_output;
  wire       [31:0]   datapath_muxRegArray_2_5_io_output;
  wire       [31:0]   datapath_muxRegArray_2_6_io_output;
  wire       [31:0]   datapath_muxRegArray_2_7_io_output;
  wire       [31:0]   datapath_muxRegArray_3_0_io_output;
  wire       [31:0]   datapath_muxRegArray_3_1_io_output;
  wire       [31:0]   datapath_muxRegArray_3_2_io_output;
  wire       [31:0]   datapath_muxRegArray_3_3_io_output;
  wire       [31:0]   datapath_muxRegArray_3_4_io_output;
  wire       [31:0]   datapath_muxRegArray_3_5_io_output;
  wire       [31:0]   datapath_muxRegArray_3_6_io_output;
  wire       [31:0]   datapath_muxRegArray_3_7_io_output;
  wire       [31:0]   datapath_muxRegArray_4_0_io_output;
  wire       [31:0]   datapath_muxRegArray_4_1_io_output;
  wire       [31:0]   datapath_muxRegArray_4_2_io_output;
  wire       [31:0]   datapath_muxRegArray_4_3_io_output;
  wire       [31:0]   datapath_muxRegArray_4_4_io_output;
  wire       [31:0]   datapath_muxRegArray_4_5_io_output;
  wire       [31:0]   datapath_muxRegArray_4_6_io_output;
  wire       [31:0]   datapath_muxRegArray_4_7_io_output;
  wire       [31:0]   datapath_muxRegArray_5_0_io_output;
  wire       [31:0]   datapath_muxRegArray_5_1_io_output;
  wire       [31:0]   datapath_muxRegArray_5_2_io_output;
  wire       [31:0]   datapath_muxRegArray_5_3_io_output;
  wire       [31:0]   datapath_muxRegArray_5_4_io_output;
  wire       [31:0]   datapath_muxRegArray_5_5_io_output;
  wire       [31:0]   datapath_muxRegArray_5_6_io_output;
  wire       [31:0]   datapath_muxRegArray_5_7_io_output;
  wire       [31:0]   datapath_muxRegArray_6_0_io_output;
  wire       [31:0]   datapath_muxRegArray_6_1_io_output;
  wire       [31:0]   datapath_muxRegArray_6_2_io_output;
  wire       [31:0]   datapath_muxRegArray_6_3_io_output;
  wire       [31:0]   datapath_muxRegArray_6_4_io_output;
  wire       [31:0]   datapath_muxRegArray_6_5_io_output;
  wire       [31:0]   datapath_muxRegArray_6_6_io_output;
  wire       [31:0]   datapath_muxRegArray_6_7_io_output;
  wire       [31:0]   datapath_muxRegArray_7_0_io_output;
  wire       [31:0]   datapath_muxRegArray_7_1_io_output;
  wire       [31:0]   datapath_muxRegArray_7_2_io_output;
  wire       [31:0]   datapath_muxRegArray_7_3_io_output;
  wire       [31:0]   datapath_muxRegArray_7_4_io_output;
  wire       [31:0]   datapath_muxRegArray_7_5_io_output;
  wire       [31:0]   datapath_muxRegArray_7_6_io_output;
  wire       [31:0]   datapath_muxRegArray_7_7_io_output;
  reg                 selH;
  wire                shiftEnb;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [7:0]    fsm_count;
  reg        [1:0]    fsm_stateReg;
  reg        [1:0]    fsm_stateNext;
  wire                when_MatTrans_l115;
  wire                when_MatTrans_l133;
  wire                fsm_onExit_BOOT;
  wire                fsm_onExit_input_1;
  wire                fsm_onExit_output_1;
  wire                fsm_onEntry_BOOT;
  wire                fsm_onEntry_input_1;
  wire                fsm_onEntry_output_1;
  `ifndef SYNTHESIS
  reg [63:0] fsm_stateReg_string;
  reg [63:0] fsm_stateNext_string;
  `endif


  muxReg datapath_muxRegArray_0_0 (
    .io_inputH   (io_inBus_0[31:0]                        ), //i
    .io_inputV   (datapath_muxRegArray_1_0_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_0_0_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_0_1 (
    .io_inputH   (datapath_muxRegArray_0_0_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_1_1_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_0_1_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_0_2 (
    .io_inputH   (datapath_muxRegArray_0_1_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_1_2_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_0_2_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_0_3 (
    .io_inputH   (datapath_muxRegArray_0_2_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_1_3_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_0_3_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_0_4 (
    .io_inputH   (datapath_muxRegArray_0_3_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_1_4_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_0_4_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_0_5 (
    .io_inputH   (datapath_muxRegArray_0_4_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_1_5_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_0_5_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_0_6 (
    .io_inputH   (datapath_muxRegArray_0_5_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_1_6_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_0_6_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_0_7 (
    .io_inputH   (datapath_muxRegArray_0_6_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_1_7_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_0_7_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_1_0 (
    .io_inputH   (io_inBus_1[31:0]                        ), //i
    .io_inputV   (datapath_muxRegArray_2_0_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_1_0_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_1_1 (
    .io_inputH   (datapath_muxRegArray_1_0_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_2_1_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_1_1_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_1_2 (
    .io_inputH   (datapath_muxRegArray_1_1_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_2_2_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_1_2_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_1_3 (
    .io_inputH   (datapath_muxRegArray_1_2_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_2_3_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_1_3_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_1_4 (
    .io_inputH   (datapath_muxRegArray_1_3_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_2_4_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_1_4_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_1_5 (
    .io_inputH   (datapath_muxRegArray_1_4_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_2_5_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_1_5_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_1_6 (
    .io_inputH   (datapath_muxRegArray_1_5_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_2_6_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_1_6_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_1_7 (
    .io_inputH   (datapath_muxRegArray_1_6_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_2_7_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_1_7_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_2_0 (
    .io_inputH   (io_inBus_2[31:0]                        ), //i
    .io_inputV   (datapath_muxRegArray_3_0_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_2_0_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_2_1 (
    .io_inputH   (datapath_muxRegArray_2_0_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_3_1_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_2_1_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_2_2 (
    .io_inputH   (datapath_muxRegArray_2_1_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_3_2_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_2_2_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_2_3 (
    .io_inputH   (datapath_muxRegArray_2_2_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_3_3_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_2_3_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_2_4 (
    .io_inputH   (datapath_muxRegArray_2_3_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_3_4_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_2_4_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_2_5 (
    .io_inputH   (datapath_muxRegArray_2_4_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_3_5_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_2_5_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_2_6 (
    .io_inputH   (datapath_muxRegArray_2_5_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_3_6_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_2_6_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_2_7 (
    .io_inputH   (datapath_muxRegArray_2_6_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_3_7_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_2_7_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_3_0 (
    .io_inputH   (io_inBus_3[31:0]                        ), //i
    .io_inputV   (datapath_muxRegArray_4_0_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_3_0_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_3_1 (
    .io_inputH   (datapath_muxRegArray_3_0_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_4_1_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_3_1_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_3_2 (
    .io_inputH   (datapath_muxRegArray_3_1_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_4_2_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_3_2_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_3_3 (
    .io_inputH   (datapath_muxRegArray_3_2_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_4_3_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_3_3_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_3_4 (
    .io_inputH   (datapath_muxRegArray_3_3_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_4_4_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_3_4_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_3_5 (
    .io_inputH   (datapath_muxRegArray_3_4_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_4_5_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_3_5_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_3_6 (
    .io_inputH   (datapath_muxRegArray_3_5_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_4_6_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_3_6_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_3_7 (
    .io_inputH   (datapath_muxRegArray_3_6_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_4_7_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_3_7_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_4_0 (
    .io_inputH   (io_inBus_4[31:0]                        ), //i
    .io_inputV   (datapath_muxRegArray_5_0_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_4_0_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_4_1 (
    .io_inputH   (datapath_muxRegArray_4_0_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_5_1_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_4_1_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_4_2 (
    .io_inputH   (datapath_muxRegArray_4_1_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_5_2_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_4_2_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_4_3 (
    .io_inputH   (datapath_muxRegArray_4_2_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_5_3_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_4_3_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_4_4 (
    .io_inputH   (datapath_muxRegArray_4_3_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_5_4_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_4_4_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_4_5 (
    .io_inputH   (datapath_muxRegArray_4_4_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_5_5_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_4_5_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_4_6 (
    .io_inputH   (datapath_muxRegArray_4_5_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_5_6_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_4_6_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_4_7 (
    .io_inputH   (datapath_muxRegArray_4_6_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_5_7_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_4_7_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_5_0 (
    .io_inputH   (io_inBus_5[31:0]                        ), //i
    .io_inputV   (datapath_muxRegArray_6_0_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_5_0_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_5_1 (
    .io_inputH   (datapath_muxRegArray_5_0_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_6_1_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_5_1_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_5_2 (
    .io_inputH   (datapath_muxRegArray_5_1_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_6_2_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_5_2_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_5_3 (
    .io_inputH   (datapath_muxRegArray_5_2_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_6_3_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_5_3_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_5_4 (
    .io_inputH   (datapath_muxRegArray_5_3_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_6_4_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_5_4_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_5_5 (
    .io_inputH   (datapath_muxRegArray_5_4_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_6_5_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_5_5_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_5_6 (
    .io_inputH   (datapath_muxRegArray_5_5_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_6_6_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_5_6_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_5_7 (
    .io_inputH   (datapath_muxRegArray_5_6_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_6_7_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_5_7_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_6_0 (
    .io_inputH   (io_inBus_6[31:0]                        ), //i
    .io_inputV   (datapath_muxRegArray_7_0_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_6_0_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_6_1 (
    .io_inputH   (datapath_muxRegArray_6_0_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_7_1_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_6_1_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_6_2 (
    .io_inputH   (datapath_muxRegArray_6_1_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_7_2_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_6_2_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_6_3 (
    .io_inputH   (datapath_muxRegArray_6_2_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_7_3_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_6_3_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_6_4 (
    .io_inputH   (datapath_muxRegArray_6_3_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_7_4_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_6_4_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_6_5 (
    .io_inputH   (datapath_muxRegArray_6_4_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_7_5_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_6_5_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_6_6 (
    .io_inputH   (datapath_muxRegArray_6_5_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_7_6_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_6_6_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_6_7 (
    .io_inputH   (datapath_muxRegArray_6_6_io_output[31:0]), //i
    .io_inputV   (datapath_muxRegArray_7_7_io_output[31:0]), //i
    .io_output   (datapath_muxRegArray_6_7_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_7_0 (
    .io_inputH   (io_inBus_7[31:0]                        ), //i
    .io_inputV   (32'h0                                   ), //i
    .io_output   (datapath_muxRegArray_7_0_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_7_1 (
    .io_inputH   (datapath_muxRegArray_7_0_io_output[31:0]), //i
    .io_inputV   (32'h0                                   ), //i
    .io_output   (datapath_muxRegArray_7_1_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_7_2 (
    .io_inputH   (datapath_muxRegArray_7_1_io_output[31:0]), //i
    .io_inputV   (32'h0                                   ), //i
    .io_output   (datapath_muxRegArray_7_2_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_7_3 (
    .io_inputH   (datapath_muxRegArray_7_2_io_output[31:0]), //i
    .io_inputV   (32'h0                                   ), //i
    .io_output   (datapath_muxRegArray_7_3_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_7_4 (
    .io_inputH   (datapath_muxRegArray_7_3_io_output[31:0]), //i
    .io_inputV   (32'h0                                   ), //i
    .io_output   (datapath_muxRegArray_7_4_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_7_5 (
    .io_inputH   (datapath_muxRegArray_7_4_io_output[31:0]), //i
    .io_inputV   (32'h0                                   ), //i
    .io_output   (datapath_muxRegArray_7_5_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_7_6 (
    .io_inputH   (datapath_muxRegArray_7_5_io_output[31:0]), //i
    .io_inputV   (32'h0                                   ), //i
    .io_output   (datapath_muxRegArray_7_6_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  muxReg datapath_muxRegArray_7_7 (
    .io_inputH   (datapath_muxRegArray_7_6_io_output[31:0]), //i
    .io_inputV   (32'h0                                   ), //i
    .io_output   (datapath_muxRegArray_7_7_io_output[31:0]), //o
    .io_selH     (selH                                    ), //i
    .io_shiftEnb (shiftEnb                                ), //i
    .clk         (clk                                     ), //i
    .resetn      (resetn                                  )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_stateReg)
      fsm_BOOT : fsm_stateReg_string = "BOOT    ";
      fsm_input_1 : fsm_stateReg_string = "input_1 ";
      fsm_output_1 : fsm_stateReg_string = "output_1";
      default : fsm_stateReg_string = "????????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_BOOT : fsm_stateNext_string = "BOOT    ";
      fsm_input_1 : fsm_stateNext_string = "input_1 ";
      fsm_output_1 : fsm_stateNext_string = "output_1";
      default : fsm_stateNext_string = "????????";
    endcase
  end
  `endif

  assign shiftEnb = ((io_outValid && io_outReady) || (io_inValid && io_inReady));
  assign io_outBus_7 = datapath_muxRegArray_0_0_io_output;
  assign io_outBus_6 = datapath_muxRegArray_0_1_io_output;
  assign io_outBus_5 = datapath_muxRegArray_0_2_io_output;
  assign io_outBus_4 = datapath_muxRegArray_0_3_io_output;
  assign io_outBus_3 = datapath_muxRegArray_0_4_io_output;
  assign io_outBus_2 = datapath_muxRegArray_0_5_io_output;
  assign io_outBus_1 = datapath_muxRegArray_0_6_io_output;
  assign io_outBus_0 = datapath_muxRegArray_0_7_io_output;
  assign fsm_wantExit = 1'b0;
  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_input_1 : begin
      end
      fsm_output_1 : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  always @(*) begin
    io_inReady = 1'b0;
    case(fsm_stateReg)
      fsm_input_1 : begin
        io_inReady = 1'b1;
      end
      fsm_output_1 : begin
      end
      default : begin
      end
    endcase
    if(fsm_onEntry_input_1) begin
      io_inReady = 1'b1;
    end
  end

  always @(*) begin
    io_outValid = 1'b0;
    case(fsm_stateReg)
      fsm_input_1 : begin
      end
      fsm_output_1 : begin
        if(io_outReady) begin
          io_outValid = 1'b1;
        end else begin
          io_outValid = 1'b0;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_input_1 : begin
        if(when_MatTrans_l115) begin
          fsm_stateNext = fsm_output_1;
        end
      end
      fsm_output_1 : begin
        if(when_MatTrans_l133) begin
          fsm_stateNext = fsm_input_1;
        end
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_input_1;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_BOOT;
    end
  end

  assign when_MatTrans_l115 = (fsm_count == 8'h07);
  assign when_MatTrans_l133 = (fsm_count == 8'h07);
  assign fsm_onExit_BOOT = ((fsm_stateNext != fsm_BOOT) && (fsm_stateReg == fsm_BOOT));
  assign fsm_onExit_input_1 = ((fsm_stateNext != fsm_input_1) && (fsm_stateReg == fsm_input_1));
  assign fsm_onExit_output_1 = ((fsm_stateNext != fsm_output_1) && (fsm_stateReg == fsm_output_1));
  assign fsm_onEntry_BOOT = ((fsm_stateNext == fsm_BOOT) && (fsm_stateReg != fsm_BOOT));
  assign fsm_onEntry_input_1 = ((fsm_stateNext == fsm_input_1) && (fsm_stateReg != fsm_input_1));
  assign fsm_onEntry_output_1 = ((fsm_stateNext == fsm_output_1) && (fsm_stateReg != fsm_output_1));
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      selH <= 1'b0;
      fsm_count <= 8'h0;
      fsm_stateReg <= fsm_BOOT;
    end else begin
      fsm_stateReg <= fsm_stateNext;
      case(fsm_stateReg)
        fsm_input_1 : begin
          if(io_inValid) begin
            fsm_count <= (fsm_count + 8'h01);
          end
        end
        fsm_output_1 : begin
          if(io_outReady) begin
            fsm_count <= (fsm_count + 8'h01);
          end
        end
        default : begin
        end
      endcase
      if(fsm_onEntry_input_1) begin
        fsm_count <= 8'h0;
        selH <= 1'b1;
      end
      if(fsm_onEntry_output_1) begin
        fsm_count <= 8'h0;
        selH <= 1'b0;
      end
    end
  end


endmodule

//muxReg_63 replaced by muxReg

//muxReg_62 replaced by muxReg

//muxReg_61 replaced by muxReg

//muxReg_60 replaced by muxReg

//muxReg_59 replaced by muxReg

//muxReg_58 replaced by muxReg

//muxReg_57 replaced by muxReg

//muxReg_56 replaced by muxReg

//muxReg_55 replaced by muxReg

//muxReg_54 replaced by muxReg

//muxReg_53 replaced by muxReg

//muxReg_52 replaced by muxReg

//muxReg_51 replaced by muxReg

//muxReg_50 replaced by muxReg

//muxReg_49 replaced by muxReg

//muxReg_48 replaced by muxReg

//muxReg_47 replaced by muxReg

//muxReg_46 replaced by muxReg

//muxReg_45 replaced by muxReg

//muxReg_44 replaced by muxReg

//muxReg_43 replaced by muxReg

//muxReg_42 replaced by muxReg

//muxReg_41 replaced by muxReg

//muxReg_40 replaced by muxReg

//muxReg_39 replaced by muxReg

//muxReg_38 replaced by muxReg

//muxReg_37 replaced by muxReg

//muxReg_36 replaced by muxReg

//muxReg_35 replaced by muxReg

//muxReg_34 replaced by muxReg

//muxReg_33 replaced by muxReg

//muxReg_32 replaced by muxReg

//muxReg_31 replaced by muxReg

//muxReg_30 replaced by muxReg

//muxReg_29 replaced by muxReg

//muxReg_28 replaced by muxReg

//muxReg_27 replaced by muxReg

//muxReg_26 replaced by muxReg

//muxReg_25 replaced by muxReg

//muxReg_24 replaced by muxReg

//muxReg_23 replaced by muxReg

//muxReg_22 replaced by muxReg

//muxReg_21 replaced by muxReg

//muxReg_20 replaced by muxReg

//muxReg_19 replaced by muxReg

//muxReg_18 replaced by muxReg

//muxReg_17 replaced by muxReg

//muxReg_16 replaced by muxReg

//muxReg_15 replaced by muxReg

//muxReg_14 replaced by muxReg

//muxReg_13 replaced by muxReg

//muxReg_12 replaced by muxReg

//muxReg_11 replaced by muxReg

//muxReg_10 replaced by muxReg

//muxReg_9 replaced by muxReg

//muxReg_8 replaced by muxReg

//muxReg_7 replaced by muxReg

//muxReg_6 replaced by muxReg

//muxReg_5 replaced by muxReg

//muxReg_4 replaced by muxReg

//muxReg_3 replaced by muxReg

//muxReg_2 replaced by muxReg

//muxReg_1 replaced by muxReg

module muxReg (
  input  wire [31:0]   io_inputH,
  input  wire [31:0]   io_inputV,
  output wire [31:0]   io_output,
  input  wire          io_selH,
  input  wire          io_shiftEnb,
  input  wire          clk,
  input  wire          resetn
);

  reg        [31:0]   reg_1;

  assign io_output = reg_1;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      reg_1 <= 32'h0;
    end else begin
      if(io_shiftEnb) begin
        if(io_selH) begin
          reg_1 <= io_inputH;
        end else begin
          reg_1 <= io_inputV;
        end
      end else begin
        reg_1 <= reg_1;
      end
    end
  end


endmodule
